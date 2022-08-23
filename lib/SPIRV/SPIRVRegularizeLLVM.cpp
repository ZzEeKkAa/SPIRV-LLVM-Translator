//===- SPIRVRegularizeLLVM.cpp - Regularize LLVM for SPIR-V ------- C++ -*-===//
//
//                     The LLVM/SPIRV Translator
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
// Copyright (c) 2014 Advanced Micro Devices, Inc. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a
// copy of this software and associated documentation files (the "Software"),
// to deal with the Software without restriction, including without limitation
// the rights to use, copy, modify, merge, publish, distribute, sublicense,
// and/or sell copies of the Software, and to permit persons to whom the
// Software is furnished to do so, subject to the following conditions:
//
// Redistributions of source code must retain the above copyright notice,
// this list of conditions and the following disclaimers.
// Redistributions in binary form must reproduce the above copyright notice,
// this list of conditions and the following disclaimers in the documentation
// and/or other materials provided with the distribution.
// Neither the names of Advanced Micro Devices, Inc., nor the names of its
// contributors may be used to endorse or promote products derived from this
// Software without specific prior written permission.
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// CONTRIBUTORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS WITH
// THE SOFTWARE.
//
//===----------------------------------------------------------------------===//
//
// This file implements regularization of LLVM module for SPIR-V.
//
//===----------------------------------------------------------------------===//
#define DEBUG_TYPE "spvregular"

#include "OCLUtil.h"
#include "SPIRVInternal.h"
#include "SPIRVMDWalker.h"

#include "llvm/IR/InstVisitor.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/Operator.h"
#include "llvm/IR/Verifier.h"
#include "llvm/Pass.h"
#include "llvm/PassSupport.h"
#include "llvm/Support/Debug.h"

#include <set>

using namespace llvm;
using namespace SPIRV;
using namespace OCLUtil;

namespace SPIRV {

static bool SPIRVDbgSaveRegularizedModule = false;
static std::string RegularizedModuleTmpFile = "regularized.bc";

class SPIRVRegularizeLLVM : public ModulePass {
public:
  SPIRVRegularizeLLVM() : ModulePass(ID), M(nullptr), Ctx(nullptr) {
    initializeSPIRVRegularizeLLVMPass(*PassRegistry::getPassRegistry());
  }

  bool runOnModule(Module &M) override;

  // Lower functions
  bool regularize();

  // SPIR-V disallows functions being entrypoints and called
  // LLVM doesn't. This adds a wrapper around the entry point
  // that later SPIR-V writer renames.
  void addKernelEntryPoint(Module *M);

  /// Erase cast inst of function and replace with the function.
  /// Assuming F is a SPIR-V builtin function with op code \param OC.
  void lowerFuncPtr(Function *F, Op OC);
  void lowerFuncPtr(Module *M);

  static char ID;

private:
  Module *M;
  LLVMContext *Ctx;
};

char SPIRVRegularizeLLVM::ID = 0;

bool SPIRVRegularizeLLVM::runOnModule(Module &Module) {
  M = &Module;
  Ctx = &M->getContext();

  LLVM_DEBUG(dbgs() << "Enter SPIRVRegularizeLLVM:\n");
  regularize();

  LLVM_DEBUG(dbgs() << "After SPIRVRegularizeLLVM:\n" << *M);
  std::string Err;
  raw_string_ostream ErrorOS(Err);
  if (verifyModule(*M, &ErrorOS)) {
    LLVM_DEBUG(errs() << "Fails to verify module: " << ErrorOS.str());
  }
  return true;
}

/// Remove entities not representable by SPIR-V
bool SPIRVRegularizeLLVM::regularize() {
  eraseUselessFunctions(M);
  lowerFuncPtr(M);
  addKernelEntryPoint(M);

  for (auto I = M->begin(), E = M->end(); I != E;) {
    Function *F = &(*I++);
    if (F->isDeclaration() && F->use_empty()) {
      F->eraseFromParent();
      continue;
    }

    for (auto BI = F->begin(), BE = F->end(); BI != BE; ++BI) {
      for (auto II = BI->begin(), IE = BI->end(); II != IE; ++II) {
        if (auto Call = dyn_cast<CallInst>(II)) {
          Call->setTailCall(false);
          Function *CF = Call->getCalledFunction();
          if (CF && CF->isIntrinsic())
            removeFnAttr(Call, Attribute::NoUnwind);
        }

        // Remove optimization info not supported by SPIRV
        if (auto BO = dyn_cast<BinaryOperator>(II)) {
          if (isa<PossiblyExactOperator>(BO) && BO->isExact())
            BO->setIsExact(false);
        }
        // Remove metadata not supported by SPIRV
        static const char *MDs[] = {
            "fpmath",
            "tbaa",
            "range",
        };
        for (auto &MDName : MDs) {
          if (II->getMetadata(MDName)) {
            II->setMetadata(MDName, nullptr);
          }
        }
      }
    }
  }

  std::string Err;
  raw_string_ostream ErrorOS(Err);
  if (verifyModule(*M, &ErrorOS)) {
    SPIRVDBG(errs() << "Fails to verify module: " << ErrorOS.str();)
    return false;
  }

  if (SPIRVDbgSaveRegularizedModule)
    saveLLVMModule(M, RegularizedModuleTmpFile);
  return true;
}

// Assume F is a SPIR-V builtin function with a function pointer argument which
// is a bitcast instruction casting a function to a void(void) function pointer.
void SPIRVRegularizeLLVM::lowerFuncPtr(Function *F, Op OC) {
  LLVM_DEBUG(dbgs() << "[lowerFuncPtr] " << *F << '\n');
  auto Name = decorateSPIRVFunction(getName(OC));
  std::set<Value *> InvokeFuncPtrs;
  auto Attrs = F->getAttributes();
  mutateFunction(
      F,
      [=, &InvokeFuncPtrs](CallInst *CI, std::vector<Value *> &Args) {
        for (auto &I : Args) {
          if (isFunctionPointerType(I->getType())) {
            InvokeFuncPtrs.insert(I);
            I = removeCast(I);
          }
        }
        return Name;
      },
      nullptr, &Attrs, false);
  for (auto &I : InvokeFuncPtrs)
    eraseIfNoUse(I);
}

void SPIRVRegularizeLLVM::lowerFuncPtr(Module *M) {
  std::vector<std::pair<Function *, Op>> Work;
  for (auto &F : *M) {
    auto AI = F.arg_begin();
    if (hasFunctionPointerArg(&F, AI)) {
      auto OC = getSPIRVFuncOC(F.getName());
      if (OC != OpNop) // builtin with a function pointer argument
        Work.push_back(std::make_pair(&F, OC));
    }
  }
  for (auto &I : Work)
    lowerFuncPtr(I.first, I.second);
}

void SPIRVRegularizeLLVM::addKernelEntryPoint(Module *M) {
  std::vector<Function *> Work;

  // Get a list of all functions that have SPIR kernel calling conv
  for (auto &F : *M) {
    if (F.getCallingConv() == CallingConv::SPIR_KERNEL)
      Work.push_back(&F);
  }
  for (auto &F : Work) {
    // for declarations just make them into SPIR functions.
    F->setCallingConv(CallingConv::SPIR_FUNC);
    if (F->isDeclaration())
      continue;

    // Otherwise add a wrapper around the function to act as an entry point.
    FunctionType *FType = F->getFunctionType();
    std::string WrapName =
        kSPIRVName::EntrypointPrefix + static_cast<std::string>(F->getName());
    Function *WrapFn =
        getOrCreateFunction(M, F->getReturnType(), FType->params(), WrapName);

    auto *CallBB = BasicBlock::Create(M->getContext(), "", WrapFn);
    IRBuilder<> Builder(CallBB);

    Function::arg_iterator DestI = WrapFn->arg_begin();
    for (const Argument &I : F->args()) {
      DestI->setName(I.getName());
      DestI++;
    }
    SmallVector<Value *, 1> Args;
    for (Argument &I : WrapFn->args()) {
      Args.emplace_back(&I);
    }
    auto *CI = CallInst::Create(F, ArrayRef<Value *>(Args), "", CallBB);
    CI->setCallingConv(F->getCallingConv());
    CI->setAttributes(F->getAttributes());

    // copy over all the metadata (should it be removed from F?)
    SmallVector<std::pair<unsigned, MDNode *>, 8> MDs;
    F->getAllMetadata(MDs);
    WrapFn->setAttributes(F->getAttributes());
    for (auto MD = MDs.begin(), End = MDs.end(); MD != End; ++MD) {
      WrapFn->addMetadata(MD->first, *MD->second);
    }
    WrapFn->setCallingConv(CallingConv::SPIR_KERNEL);
    WrapFn->setLinkage(llvm::GlobalValue::InternalLinkage);

    Builder.CreateRet(F->getReturnType()->isVoidTy() ? nullptr : CI);

    // Have to find the spir-v metadata for execution mode and transfer it to
    // the wrapper.
    if (auto NMD = SPIRVMDWalker(*M).getNamedMD(kSPIRVMD::ExecutionMode)) {
      while (!NMD.atEnd()) {
        Function *MDF = nullptr;
        auto N = NMD.nextOp(); /* execution mode MDNode */
        N.get(MDF);
        if (MDF == F)
          N.M->replaceOperandWith(0, ValueAsMetadata::get(WrapFn));
      }
    }
  }
}

} // namespace SPIRV

INITIALIZE_PASS(SPIRVRegularizeLLVM, "spvregular", "Regularize LLVM for SPIR-V",
                false, false)

ModulePass *llvm::createSPIRVRegularizeLLVM() {
  return new SPIRVRegularizeLLVM();
}
