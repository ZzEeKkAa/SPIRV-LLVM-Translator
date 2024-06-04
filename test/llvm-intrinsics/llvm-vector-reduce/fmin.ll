; RUN: llvm-as %s -o %t.bc
; RUN: llvm-spirv %t.bc -spirv-text -o - | FileCheck --check-prefix CHECK-SPIRV %s
; RUN: llvm-spirv %t.bc -o %t.spv
; RUN: spirv-val %t.spv

target triple = "spir64-unknown-unknown"

; CHECK-SPIRV-DAG: TypeBool [[#BTYPE:]]
; CHECK-SPIRV-DAG: TypeInt [[#I32TYPE:]] 32
; CHECK-SPIRV-DAG: TypeFloat [[#F16TYPE:]] 16
; CHECK-SPIRV-DAG: TypeFloat [[#F32TYPE:]] 32
; CHECK-SPIRV-DAG: TypeFloat [[#F64TYPE:]] 64
; CHECK-SPIRV-DAG: Constant [[#I32TYPE]] [[#CONST_0:]] 0
; CHECK-SPIRV-DAG: Constant [[#I32TYPE]] [[#CONST_1:]] 1
; CHECK-SPIRV-DAG: Constant [[#I32TYPE]] [[#CONST_2:]] 2
; CHECK-SPIRV-DAG: Constant [[#I32TYPE]] [[#CONST_3:]] 3
; CHECK-SPIRV-DAG: Constant [[#I32TYPE]] [[#CONST_4:]] 4
; CHECK-SPIRV-DAG: Constant [[#I32TYPE]] [[#CONST_5:]] 5
; CHECK-SPIRV-DAG: Constant [[#I32TYPE]] [[#CONST_6:]] 6
; CHECK-SPIRV-DAG: Constant [[#I32TYPE]] [[#CONST_7:]] 7
; CHECK-SPIRV-DAG: Constant [[#I32TYPE]] [[#CONST_8:]] 8
; CHECK-SPIRV-DAG: Constant [[#I32TYPE]] [[#CONST_9:]] 9
; CHECK-SPIRV-DAG: Constant [[#I32TYPE]] [[#CONST_10:]] 10
; CHECK-SPIRV-DAG: Constant [[#I32TYPE]] [[#CONST_11:]] 11
; CHECK-SPIRV-DAG: Constant [[#I32TYPE]] [[#CONST_12:]] 12
; CHECK-SPIRV-DAG: Constant [[#I32TYPE]] [[#CONST_13:]] 13
; CHECK-SPIRV-DAG: Constant [[#I32TYPE]] [[#CONST_14:]] 14
; CHECK-SPIRV-DAG: Constant [[#I32TYPE]] [[#CONST_15:]] 15
; CHECK-SPIRV-DAG: TypeVector [[#V2XF16TYPE:]] [[#F16TYPE]] 2
; CHECK-SPIRV-DAG: TypeVector [[#V3XF16TYPE:]] [[#F16TYPE]] 3
; CHECK-SPIRV-DAG: TypeVector [[#V4XF16TYPE:]] [[#F16TYPE]] 4
; CHECK-SPIRV-DAG: TypeVector [[#V8XF16TYPE:]] [[#F16TYPE]] 8
; CHECK-SPIRV-DAG: TypeVector [[#V16XF16TYPE:]] [[#F16TYPE]] 16
; CHECK-SPIRV-DAG: TypeVector [[#V2XF32TYPE:]] [[#F32TYPE]] 2
; CHECK-SPIRV-DAG: TypeVector [[#V3XF32TYPE:]] [[#F32TYPE]] 3
; CHECK-SPIRV-DAG: TypeVector [[#V4XF32TYPE:]] [[#F32TYPE]] 4
; CHECK-SPIRV-DAG: TypeVector [[#V8XF32TYPE:]] [[#F32TYPE]] 8
; CHECK-SPIRV-DAG: TypeVector [[#V16XF32TYPE:]] [[#F32TYPE]] 16
; CHECK-SPIRV-DAG: TypeVector [[#V2XF64TYPE:]] [[#F64TYPE]] 2
; CHECK-SPIRV-DAG: TypeVector [[#V3XF64TYPE:]] [[#F64TYPE]] 3
; CHECK-SPIRV-DAG: TypeVector [[#V4XF64TYPE:]] [[#F64TYPE]] 4
; CHECK-SPIRV-DAG: TypeVector [[#V8XF64TYPE:]] [[#F64TYPE]] 8
; CHECK-SPIRV-DAG: TypeVector [[#V16XF64TYPE:]] [[#F64TYPE]] 16

; -------- F16 --------

; CHECK-SPIRV: FunctionParameter [[#V2XF16TYPE]] [[#VEC_V2XF16TYPE:]]
; CHECK-SPIRV: VectorExtractDynamic [[#F16TYPE]] [[#EXTRACT_0_V2XF16TYPE:]] [[#VEC_V2XF16TYPE]] [[#CONST_0]]
; CHECK-SPIRV: VectorExtractDynamic [[#F16TYPE]] [[#EXTRACT_1_V2XF16TYPE:]] [[#VEC_V2XF16TYPE]] [[#CONST_1]]

; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_0_V2XF16TYPE:]] [[#EXTRACT_0_V2XF16TYPE]] [[#EXTRACT_1_V2XF16TYPE]]
; CHECK-SPIRV: Select [[#F16TYPE]] [[#SELECT_0_V2XF16TYPE:]] [[#COND_0_V2XF16TYPE]] [[#EXTRACT_0_V2XF16TYPE]] [[#EXTRACT_1_V2XF16TYPE]]
; CHECK-SPIRV: ReturnValue [[#SELECT_0_V2XF16TYPE]]

; CHECK-SPIRV: FunctionParameter [[#V3XF16TYPE]] [[#VEC_V3XF16TYPE:]]
; CHECK-SPIRV: VectorExtractDynamic [[#F16TYPE]] [[#EXTRACT_0_V3XF16TYPE:]] [[#VEC_V3XF16TYPE]] [[#CONST_0]]
; CHECK-SPIRV: VectorExtractDynamic [[#F16TYPE]] [[#EXTRACT_1_V3XF16TYPE:]] [[#VEC_V3XF16TYPE]] [[#CONST_1]]
; CHECK-SPIRV: VectorExtractDynamic [[#F16TYPE]] [[#EXTRACT_2_V3XF16TYPE:]] [[#VEC_V3XF16TYPE]] [[#CONST_2]]

; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_0_V3XF16TYPE:]] [[#EXTRACT_0_V3XF16TYPE]] [[#EXTRACT_1_V3XF16TYPE]]
; CHECK-SPIRV: Select [[#F16TYPE]] [[#SELECT_0_V3XF16TYPE:]] [[#COND_0_V3XF16TYPE]] [[#EXTRACT_0_V3XF16TYPE]] [[#EXTRACT_1_V3XF16TYPE]]

; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_1_V3XF16TYPE:]] [[#SELECT_0_V3XF16TYPE]] [[#EXTRACT_2_V3XF16TYPE]]
; CHECK-SPIRV: Select [[#F16TYPE]] [[#SELECT_1_V3XF16TYPE:]] [[#COND_1_V3XF16TYPE]] [[#SELECT_0_V3XF16TYPE]] [[#EXTRACT_2_V3XF16TYPE]]
; CHECK-SPIRV: ReturnValue [[#SELECT_1_V3XF16TYPE]]

; CHECK-SPIRV: FunctionParameter [[#V4XF16TYPE]] [[#VEC_V4XF16TYPE:]]
; CHECK-SPIRV: VectorExtractDynamic [[#F16TYPE]] [[#EXTRACT_0_V4XF16TYPE:]] [[#VEC_V4XF16TYPE]] [[#CONST_0]]
; CHECK-SPIRV: VectorExtractDynamic [[#F16TYPE]] [[#EXTRACT_1_V4XF16TYPE:]] [[#VEC_V4XF16TYPE]] [[#CONST_1]]
; CHECK-SPIRV: VectorExtractDynamic [[#F16TYPE]] [[#EXTRACT_2_V4XF16TYPE:]] [[#VEC_V4XF16TYPE]] [[#CONST_2]]
; CHECK-SPIRV: VectorExtractDynamic [[#F16TYPE]] [[#EXTRACT_3_V4XF16TYPE:]] [[#VEC_V4XF16TYPE]] [[#CONST_3]]

; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_0_V4XF16TYPE:]] [[#EXTRACT_0_V4XF16TYPE]] [[#EXTRACT_1_V4XF16TYPE]]
; CHECK-SPIRV: Select [[#F16TYPE]] [[#SELECT_0_V4XF16TYPE:]] [[#COND_0_V4XF16TYPE]] [[#EXTRACT_0_V4XF16TYPE]] [[#EXTRACT_1_V4XF16TYPE]]
; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_1_V4XF16TYPE:]] [[#EXTRACT_2_V4XF16TYPE]] [[#EXTRACT_3_V4XF16TYPE]]
; CHECK-SPIRV: Select [[#F16TYPE]] [[#SELECT_1_V4XF16TYPE:]] [[#COND_1_V4XF16TYPE]] [[#EXTRACT_2_V4XF16TYPE]] [[#EXTRACT_3_V4XF16TYPE]]

; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_2_V4XF16TYPE:]] [[#SELECT_0_V4XF16TYPE]] [[#SELECT_1_V4XF16TYPE]]
; CHECK-SPIRV: Select [[#F16TYPE]] [[#SELECT_2_V4XF16TYPE:]] [[#COND_2_V4XF16TYPE]] [[#SELECT_0_V4XF16TYPE]] [[#SELECT_1_V4XF16TYPE]]
; CHECK-SPIRV: ReturnValue [[#SELECT_2_V4XF16TYPE]]

; CHECK-SPIRV: FunctionParameter [[#V8XF16TYPE]] [[#VEC_V8XF16TYPE:]]
; CHECK-SPIRV: VectorExtractDynamic [[#F16TYPE]] [[#EXTRACT_0_V8XF16TYPE:]] [[#VEC_V8XF16TYPE]] [[#CONST_0]]
; CHECK-SPIRV: VectorExtractDynamic [[#F16TYPE]] [[#EXTRACT_1_V8XF16TYPE:]] [[#VEC_V8XF16TYPE]] [[#CONST_1]]
; CHECK-SPIRV: VectorExtractDynamic [[#F16TYPE]] [[#EXTRACT_2_V8XF16TYPE:]] [[#VEC_V8XF16TYPE]] [[#CONST_2]]
; CHECK-SPIRV: VectorExtractDynamic [[#F16TYPE]] [[#EXTRACT_3_V8XF16TYPE:]] [[#VEC_V8XF16TYPE]] [[#CONST_3]]
; CHECK-SPIRV: VectorExtractDynamic [[#F16TYPE]] [[#EXTRACT_4_V8XF16TYPE:]] [[#VEC_V8XF16TYPE]] [[#CONST_4]]
; CHECK-SPIRV: VectorExtractDynamic [[#F16TYPE]] [[#EXTRACT_5_V8XF16TYPE:]] [[#VEC_V8XF16TYPE]] [[#CONST_5]]
; CHECK-SPIRV: VectorExtractDynamic [[#F16TYPE]] [[#EXTRACT_6_V8XF16TYPE:]] [[#VEC_V8XF16TYPE]] [[#CONST_6]]
; CHECK-SPIRV: VectorExtractDynamic [[#F16TYPE]] [[#EXTRACT_7_V8XF16TYPE:]] [[#VEC_V8XF16TYPE]] [[#CONST_7]]

; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_0_V8XF16TYPE:]] [[#EXTRACT_0_V8XF16TYPE]] [[#EXTRACT_1_V8XF16TYPE]]
; CHECK-SPIRV: Select [[#F16TYPE]] [[#SELECT_0_V8XF16TYPE:]] [[#COND_0_V8XF16TYPE]] [[#EXTRACT_0_V8XF16TYPE]] [[#EXTRACT_1_V8XF16TYPE]]
; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_1_V8XF16TYPE:]] [[#EXTRACT_2_V8XF16TYPE]] [[#EXTRACT_3_V8XF16TYPE]]
; CHECK-SPIRV: Select [[#F16TYPE]] [[#SELECT_1_V8XF16TYPE:]] [[#COND_1_V8XF16TYPE]] [[#EXTRACT_2_V8XF16TYPE]] [[#EXTRACT_3_V8XF16TYPE]]
; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_2_V8XF16TYPE:]] [[#EXTRACT_4_V8XF16TYPE]] [[#EXTRACT_5_V8XF16TYPE]]
; CHECK-SPIRV: Select [[#F16TYPE]] [[#SELECT_2_V8XF16TYPE:]] [[#COND_2_V8XF16TYPE]] [[#EXTRACT_4_V8XF16TYPE]] [[#EXTRACT_5_V8XF16TYPE]]
; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_3_V8XF16TYPE:]] [[#EXTRACT_6_V8XF16TYPE]] [[#EXTRACT_7_V8XF16TYPE]]
; CHECK-SPIRV: Select [[#F16TYPE]] [[#SELECT_3_V8XF16TYPE:]] [[#COND_3_V8XF16TYPE]] [[#EXTRACT_6_V8XF16TYPE]] [[#EXTRACT_7_V8XF16TYPE]]

; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_4_V8XF16TYPE:]] [[#SELECT_0_V8XF16TYPE]] [[#SELECT_1_V8XF16TYPE]] 
; CHECK-SPIRV: Select [[#F16TYPE]] [[#SELECT_4_V8XF16TYPE:]] [[#COND_4_V8XF16TYPE]] [[#SELECT_0_V8XF16TYPE]] [[#SELECT_1_V8XF16TYPE]]
; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_5_V8XF16TYPE:]] [[#SELECT_2_V8XF16TYPE]] [[#SELECT_3_V8XF16TYPE]]
; CHECK-SPIRV: Select [[#F16TYPE]] [[#SELECT_5_V8XF16TYPE:]] [[#COND_5_V8XF16TYPE]] [[#SELECT_2_V8XF16TYPE]] [[#SELECT_3_V8XF16TYPE]]

; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_6_V8XF16TYPE:]] [[#SELECT_4_V8XF16TYPE]] [[#SELECT_5_V8XF16TYPE]]
; CHECK-SPIRV: Select [[#F16TYPE]] [[#SELECT_6_V8XF16TYPE:]] [[#COND_6_V8XF16TYPE:]] [[#SELECT_4_V8XF16TYPE]] [[#SELECT_5_V8XF16TYPE]]
; CHECK-SPIRV: ReturnValue [[#SELECT_6_V8XF16TYPE]]

; CHECK-SPIRV: FunctionParameter [[#V16XF16TYPE]] [[#VEC_V16XF16TYPE:]]
; CHECK-SPIRV: VectorExtractDynamic [[#F16TYPE]] [[#EXTRACT_0_V16XF16TYPE:]] [[#VEC_V16XF16TYPE]] [[#CONST_0]]
; CHECK-SPIRV: VectorExtractDynamic [[#F16TYPE]] [[#EXTRACT_1_V16XF16TYPE:]] [[#VEC_V16XF16TYPE]] [[#CONST_1]]
; CHECK-SPIRV: VectorExtractDynamic [[#F16TYPE]] [[#EXTRACT_2_V16XF16TYPE:]] [[#VEC_V16XF16TYPE]] [[#CONST_2]]
; CHECK-SPIRV: VectorExtractDynamic [[#F16TYPE]] [[#EXTRACT_3_V16XF16TYPE:]] [[#VEC_V16XF16TYPE]] [[#CONST_3]]
; CHECK-SPIRV: VectorExtractDynamic [[#F16TYPE]] [[#EXTRACT_4_V16XF16TYPE:]] [[#VEC_V16XF16TYPE]] [[#CONST_4]]
; CHECK-SPIRV: VectorExtractDynamic [[#F16TYPE]] [[#EXTRACT_5_V16XF16TYPE:]] [[#VEC_V16XF16TYPE]] [[#CONST_5]]
; CHECK-SPIRV: VectorExtractDynamic [[#F16TYPE]] [[#EXTRACT_6_V16XF16TYPE:]] [[#VEC_V16XF16TYPE]] [[#CONST_6]]
; CHECK-SPIRV: VectorExtractDynamic [[#F16TYPE]] [[#EXTRACT_7_V16XF16TYPE:]] [[#VEC_V16XF16TYPE]] [[#CONST_7]]
; CHECK-SPIRV: VectorExtractDynamic [[#F16TYPE]] [[#EXTRACT_8_V16XF16TYPE:]] [[#VEC_V16XF16TYPE]] [[#CONST_8]]
; CHECK-SPIRV: VectorExtractDynamic [[#F16TYPE]] [[#EXTRACT_9_V16XF16TYPE:]] [[#VEC_V16XF16TYPE]] [[#CONST_9]]
; CHECK-SPIRV: VectorExtractDynamic [[#F16TYPE]] [[#EXTRACT_10_V16XF16TYPE:]] [[#VEC_V16XF16TYPE]] [[#CONST_10]]
; CHECK-SPIRV: VectorExtractDynamic [[#F16TYPE]] [[#EXTRACT_11_V16XF16TYPE:]] [[#VEC_V16XF16TYPE]] [[#CONST_11]]
; CHECK-SPIRV: VectorExtractDynamic [[#F16TYPE]] [[#EXTRACT_12_V16XF16TYPE:]] [[#VEC_V16XF16TYPE]] [[#CONST_12]]
; CHECK-SPIRV: VectorExtractDynamic [[#F16TYPE]] [[#EXTRACT_13_V16XF16TYPE:]] [[#VEC_V16XF16TYPE]] [[#CONST_13]]
; CHECK-SPIRV: VectorExtractDynamic [[#F16TYPE]] [[#EXTRACT_14_V16XF16TYPE:]] [[#VEC_V16XF16TYPE]] [[#CONST_14]]
; CHECK-SPIRV: VectorExtractDynamic [[#F16TYPE]] [[#EXTRACT_15_V16XF16TYPE:]] [[#VEC_V16XF16TYPE]] [[#CONST_15]]

; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_0_V16XF16TYPE:]] [[#EXTRACT_0_V16XF16TYPE]] [[#EXTRACT_1_V16XF16TYPE]]
; CHECK-SPIRV: Select [[#F16TYPE]] [[#SELECT_0_V16XF16TYPE:]] [[#COND_0_V16XF16TYPE]] [[#EXTRACT_0_V16XF16TYPE]] [[#EXTRACT_1_V16XF16TYPE]]
; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_1_V16XF16TYPE:]] [[#EXTRACT_2_V16XF16TYPE]] [[#EXTRACT_3_V16XF16TYPE]]
; CHECK-SPIRV: Select [[#F16TYPE]] [[#SELECT_1_V16XF16TYPE:]] [[#COND_1_V16XF16TYPE]] [[#EXTRACT_2_V16XF16TYPE]] [[#EXTRACT_3_V16XF16TYPE]]
; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_2_V16XF16TYPE:]] [[#EXTRACT_4_V16XF16TYPE]] [[#EXTRACT_5_V16XF16TYPE]]
; CHECK-SPIRV: Select [[#F16TYPE]] [[#SELECT_2_V16XF16TYPE:]] [[#COND_2_V16XF16TYPE]] [[#EXTRACT_4_V16XF16TYPE]] [[#EXTRACT_5_V16XF16TYPE]]
; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_3_V16XF16TYPE:]] [[#EXTRACT_6_V16XF16TYPE]] [[#EXTRACT_7_V16XF16TYPE]]
; CHECK-SPIRV: Select [[#F16TYPE]] [[#SELECT_3_V16XF16TYPE:]] [[#COND_3_V16XF16TYPE]] [[#EXTRACT_6_V16XF16TYPE]] [[#EXTRACT_7_V16XF16TYPE]]
; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_4_V16XF16TYPE:]] [[#EXTRACT_8_V16XF16TYPE]] [[#EXTRACT_9_V16XF16TYPE]]
; CHECK-SPIRV: Select [[#F16TYPE]] [[#SELECT_4_V16XF16TYPE:]] [[#COND_4_V16XF16TYPE]] [[#EXTRACT_8_V16XF16TYPE]] [[#EXTRACT_9_V16XF16TYPE]]
; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_5_V16XF16TYPE:]] [[#EXTRACT_10_V16XF16TYPE]] [[#EXTRACT_11_V16XF16TYPE]]
; CHECK-SPIRV: Select [[#F16TYPE]] [[#SELECT_5_V16XF16TYPE:]] [[#COND_5_V16XF16TYPE]] [[#EXTRACT_10_V16XF16TYPE]] [[#EXTRACT_11_V16XF16TYPE]]
; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_6_V16XF16TYPE:]] [[#EXTRACT_12_V16XF16TYPE]] [[#EXTRACT_13_V16XF16TYPE]]
; CHECK-SPIRV: Select [[#F16TYPE]] [[#SELECT_6_V16XF16TYPE:]] [[#COND_6_V16XF16TYPE]] [[#EXTRACT_12_V16XF16TYPE]] [[#EXTRACT_13_V16XF16TYPE]]
; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_7_V16XF16TYPE:]] [[#EXTRACT_14_V16XF16TYPE]] [[#EXTRACT_15_V16XF16TYPE]]
; CHECK-SPIRV: Select [[#F16TYPE]] [[#SELECT_7_V16XF16TYPE:]] [[#COND_7_V16XF16TYPE]] [[#EXTRACT_14_V16XF16TYPE]] [[#EXTRACT_15_V16XF16TYPE]]

; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_8_V16XF16TYPE:]] [[#SELECT_0_V16XF16TYPE]] [[#SELECT_1_V16XF16TYPE]] 
; CHECK-SPIRV: Select [[#F16TYPE]] [[#SELECT_8_V16XF16TYPE:]] [[#COND_8_V16XF16TYPE]] [[#SELECT_0_V16XF16TYPE]] [[#SELECT_1_V16XF16TYPE]]
; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_9_V16XF16TYPE:]] [[#SELECT_2_V16XF16TYPE]] [[#SELECT_3_V16XF16TYPE]]
; CHECK-SPIRV: Select [[#F16TYPE]] [[#SELECT_9_V16XF16TYPE:]] [[#COND_9_V16XF16TYPE]] [[#SELECT_2_V16XF16TYPE]] [[#SELECT_3_V16XF16TYPE]]
; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_10_V16XF16TYPE:]] [[#SELECT_4_V16XF16TYPE]] [[#SELECT_5_V16XF16TYPE]] 
; CHECK-SPIRV: Select [[#F16TYPE]] [[#SELECT_10_V16XF16TYPE:]] [[#COND_10_V16XF16TYPE]] [[#SELECT_4_V16XF16TYPE]] [[#SELECT_5_V16XF16TYPE]]
; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_11_V16XF16TYPE:]] [[#SELECT_6_V16XF16TYPE]] [[#SELECT_7_V16XF16TYPE]]
; CHECK-SPIRV: Select [[#F16TYPE]] [[#SELECT_11_V16XF16TYPE:]] [[#COND_11_V16XF16TYPE]] [[#SELECT_6_V16XF16TYPE]] [[#SELECT_7_V16XF16TYPE]]

; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_12_V16XF16TYPE:]] [[#SELECT_8_V16XF16TYPE]] [[#SELECT_9_V16XF16TYPE]]
; CHECK-SPIRV: Select [[#F16TYPE]] [[#SELECT_12_V16XF16TYPE:]] [[#COND_12_V16XF16TYPE]] [[#SELECT_8_V16XF16TYPE]] [[#SELECT_9_V16XF16TYPE]]
; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_13_V16XF16TYPE:]] [[#SELECT_10_V16XF16TYPE]] [[#SELECT_11_V16XF16TYPE]]
; CHECK-SPIRV: Select [[#F16TYPE]] [[#SELECT_13_V16XF16TYPE:]] [[#COND_13_V16XF16TYPE]] [[#SELECT_10_V16XF16TYPE]] [[#SELECT_11_V16XF16TYPE]]

; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_14_V16XF16TYPE:]] [[#SELECT_12_V16XF16TYPE]] [[#SELECT_13_V16XF16TYPE]]
; CHECK-SPIRV: Select [[#F16TYPE]] [[#SELECT_14_V16XF16TYPE:]] [[#COND_14_V16XF16TYPE]] [[#SELECT_12_V16XF16TYPE]] [[#SELECT_13_V16XF16TYPE]]
; CHECK-SPIRV: ReturnValue [[#SELECT_14_V16XF16TYPE]]

; -------- F32 --------

; CHECK-SPIRV: FunctionParameter [[#V2XF32TYPE]] [[#VEC_V2XF32TYPE:]]
; CHECK-SPIRV: VectorExtractDynamic [[#F32TYPE]] [[#EXTRACT_0_V2XF32TYPE:]] [[#VEC_V2XF32TYPE]] [[#CONST_0]]
; CHECK-SPIRV: VectorExtractDynamic [[#F32TYPE]] [[#EXTRACT_1_V2XF32TYPE:]] [[#VEC_V2XF32TYPE]] [[#CONST_1]]

; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_0_V2XF32TYPE:]] [[#EXTRACT_0_V2XF32TYPE]] [[#EXTRACT_1_V2XF32TYPE]]
; CHECK-SPIRV: Select [[#F32TYPE]] [[#SELECT_0_V2XF32TYPE:]] [[#COND_0_V2XF32TYPE]] [[#EXTRACT_0_V2XF32TYPE]] [[#EXTRACT_1_V2XF32TYPE]]
; CHECK-SPIRV: ReturnValue [[#SELECT_0_V2XF32TYPE]]

; CHECK-SPIRV: FunctionParameter [[#V3XF32TYPE]] [[#VEC_V3XF32TYPE:]]
; CHECK-SPIRV: VectorExtractDynamic [[#F32TYPE]] [[#EXTRACT_0_V3XF32TYPE:]] [[#VEC_V3XF32TYPE]] [[#CONST_0]]
; CHECK-SPIRV: VectorExtractDynamic [[#F32TYPE]] [[#EXTRACT_1_V3XF32TYPE:]] [[#VEC_V3XF32TYPE]] [[#CONST_1]]
; CHECK-SPIRV: VectorExtractDynamic [[#F32TYPE]] [[#EXTRACT_2_V3XF32TYPE:]] [[#VEC_V3XF32TYPE]] [[#CONST_2]]

; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_0_V3XF32TYPE:]] [[#EXTRACT_0_V3XF32TYPE]] [[#EXTRACT_1_V3XF32TYPE]]
; CHECK-SPIRV: Select [[#F32TYPE]] [[#SELECT_0_V3XF32TYPE:]] [[#COND_0_V3XF32TYPE]] [[#EXTRACT_0_V3XF32TYPE]] [[#EXTRACT_1_V3XF32TYPE]]

; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_1_V3XF32TYPE:]] [[#SELECT_0_V3XF32TYPE]] [[#EXTRACT_2_V3XF32TYPE]]
; CHECK-SPIRV: Select [[#F32TYPE]] [[#SELECT_1_V3XF32TYPE:]] [[#COND_1_V3XF32TYPE]] [[#SELECT_0_V3XF32TYPE]] [[#EXTRACT_2_V3XF32TYPE]]
; CHECK-SPIRV: ReturnValue [[#SELECT_1_V3XF32TYPE]]

; CHECK-SPIRV: FunctionParameter [[#V4XF32TYPE]] [[#VEC_V4XF32TYPE:]]
; CHECK-SPIRV: VectorExtractDynamic [[#F32TYPE]] [[#EXTRACT_0_V4XF32TYPE:]] [[#VEC_V4XF32TYPE]] [[#CONST_0]]
; CHECK-SPIRV: VectorExtractDynamic [[#F32TYPE]] [[#EXTRACT_1_V4XF32TYPE:]] [[#VEC_V4XF32TYPE]] [[#CONST_1]]
; CHECK-SPIRV: VectorExtractDynamic [[#F32TYPE]] [[#EXTRACT_2_V4XF32TYPE:]] [[#VEC_V4XF32TYPE]] [[#CONST_2]]
; CHECK-SPIRV: VectorExtractDynamic [[#F32TYPE]] [[#EXTRACT_3_V4XF32TYPE:]] [[#VEC_V4XF32TYPE]] [[#CONST_3]]

; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_0_V4XF32TYPE:]] [[#EXTRACT_0_V4XF32TYPE]] [[#EXTRACT_1_V4XF32TYPE]]
; CHECK-SPIRV: Select [[#F32TYPE]] [[#SELECT_0_V4XF32TYPE:]] [[#COND_0_V4XF32TYPE]] [[#EXTRACT_0_V4XF32TYPE]] [[#EXTRACT_1_V4XF32TYPE]]
; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_1_V4XF32TYPE:]] [[#EXTRACT_2_V4XF32TYPE]] [[#EXTRACT_3_V4XF32TYPE]]
; CHECK-SPIRV: Select [[#F32TYPE]] [[#SELECT_1_V4XF32TYPE:]] [[#COND_1_V4XF32TYPE]] [[#EXTRACT_2_V4XF32TYPE]] [[#EXTRACT_3_V4XF32TYPE]]

; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_2_V4XF32TYPE:]] [[#SELECT_0_V4XF32TYPE]] [[#SELECT_1_V4XF32TYPE]]
; CHECK-SPIRV: Select [[#F32TYPE]] [[#SELECT_2_V4XF32TYPE:]] [[#COND_2_V4XF32TYPE]] [[#SELECT_0_V4XF32TYPE]] [[#SELECT_1_V4XF32TYPE]]
; CHECK-SPIRV: ReturnValue [[#SELECT_2_V4XF32TYPE]]

; CHECK-SPIRV: FunctionParameter [[#V8XF32TYPE]] [[#VEC_V8XF32TYPE:]]
; CHECK-SPIRV: VectorExtractDynamic [[#F32TYPE]] [[#EXTRACT_0_V8XF32TYPE:]] [[#VEC_V8XF32TYPE]] [[#CONST_0]]
; CHECK-SPIRV: VectorExtractDynamic [[#F32TYPE]] [[#EXTRACT_1_V8XF32TYPE:]] [[#VEC_V8XF32TYPE]] [[#CONST_1]]
; CHECK-SPIRV: VectorExtractDynamic [[#F32TYPE]] [[#EXTRACT_2_V8XF32TYPE:]] [[#VEC_V8XF32TYPE]] [[#CONST_2]]
; CHECK-SPIRV: VectorExtractDynamic [[#F32TYPE]] [[#EXTRACT_3_V8XF32TYPE:]] [[#VEC_V8XF32TYPE]] [[#CONST_3]]
; CHECK-SPIRV: VectorExtractDynamic [[#F32TYPE]] [[#EXTRACT_4_V8XF32TYPE:]] [[#VEC_V8XF32TYPE]] [[#CONST_4]]
; CHECK-SPIRV: VectorExtractDynamic [[#F32TYPE]] [[#EXTRACT_5_V8XF32TYPE:]] [[#VEC_V8XF32TYPE]] [[#CONST_5]]
; CHECK-SPIRV: VectorExtractDynamic [[#F32TYPE]] [[#EXTRACT_6_V8XF32TYPE:]] [[#VEC_V8XF32TYPE]] [[#CONST_6]]
; CHECK-SPIRV: VectorExtractDynamic [[#F32TYPE]] [[#EXTRACT_7_V8XF32TYPE:]] [[#VEC_V8XF32TYPE]] [[#CONST_7]]

; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_0_V8XF32TYPE:]] [[#EXTRACT_0_V8XF32TYPE]] [[#EXTRACT_1_V8XF32TYPE]]
; CHECK-SPIRV: Select [[#F32TYPE]] [[#SELECT_0_V8XF32TYPE:]] [[#COND_0_V8XF32TYPE]] [[#EXTRACT_0_V8XF32TYPE]] [[#EXTRACT_1_V8XF32TYPE]]
; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_1_V8XF32TYPE:]] [[#EXTRACT_2_V8XF32TYPE]] [[#EXTRACT_3_V8XF32TYPE]]
; CHECK-SPIRV: Select [[#F32TYPE]] [[#SELECT_1_V8XF32TYPE:]] [[#COND_1_V8XF32TYPE]] [[#EXTRACT_2_V8XF32TYPE]] [[#EXTRACT_3_V8XF32TYPE]]
; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_2_V8XF32TYPE:]] [[#EXTRACT_4_V8XF32TYPE]] [[#EXTRACT_5_V8XF32TYPE]]
; CHECK-SPIRV: Select [[#F32TYPE]] [[#SELECT_2_V8XF32TYPE:]] [[#COND_2_V8XF32TYPE]] [[#EXTRACT_4_V8XF32TYPE]] [[#EXTRACT_5_V8XF32TYPE]]
; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_3_V8XF32TYPE:]] [[#EXTRACT_6_V8XF32TYPE]] [[#EXTRACT_7_V8XF32TYPE]]
; CHECK-SPIRV: Select [[#F32TYPE]] [[#SELECT_3_V8XF32TYPE:]] [[#COND_3_V8XF32TYPE]] [[#EXTRACT_6_V8XF32TYPE]] [[#EXTRACT_7_V8XF32TYPE]]

; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_4_V8XF32TYPE:]] [[#SELECT_0_V8XF32TYPE]] [[#SELECT_1_V8XF32TYPE]] 
; CHECK-SPIRV: Select [[#F32TYPE]] [[#SELECT_4_V8XF32TYPE:]] [[#COND_4_V8XF32TYPE]] [[#SELECT_0_V8XF32TYPE]] [[#SELECT_1_V8XF32TYPE]]
; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_5_V8XF32TYPE:]] [[#SELECT_2_V8XF32TYPE]] [[#SELECT_3_V8XF32TYPE]]
; CHECK-SPIRV: Select [[#F32TYPE]] [[#SELECT_5_V8XF32TYPE:]] [[#COND_5_V8XF32TYPE]] [[#SELECT_2_V8XF32TYPE]] [[#SELECT_3_V8XF32TYPE]]

; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_6_V8XF32TYPE:]] [[#SELECT_4_V8XF32TYPE]] [[#SELECT_5_V8XF32TYPE]]
; CHECK-SPIRV: Select [[#F32TYPE]] [[#SELECT_6_V8XF32TYPE:]] [[#COND_6_V8XF32TYPE:]] [[#SELECT_4_V8XF32TYPE]] [[#SELECT_5_V8XF32TYPE]]
; CHECK-SPIRV: ReturnValue [[#SELECT_6_V8XF32TYPE]]

; CHECK-SPIRV: FunctionParameter [[#V16XF32TYPE]] [[#VEC_V16XF32TYPE:]]
; CHECK-SPIRV: VectorExtractDynamic [[#F32TYPE]] [[#EXTRACT_0_V16XF32TYPE:]] [[#VEC_V16XF32TYPE]] [[#CONST_0]]
; CHECK-SPIRV: VectorExtractDynamic [[#F32TYPE]] [[#EXTRACT_1_V16XF32TYPE:]] [[#VEC_V16XF32TYPE]] [[#CONST_1]]
; CHECK-SPIRV: VectorExtractDynamic [[#F32TYPE]] [[#EXTRACT_2_V16XF32TYPE:]] [[#VEC_V16XF32TYPE]] [[#CONST_2]]
; CHECK-SPIRV: VectorExtractDynamic [[#F32TYPE]] [[#EXTRACT_3_V16XF32TYPE:]] [[#VEC_V16XF32TYPE]] [[#CONST_3]]
; CHECK-SPIRV: VectorExtractDynamic [[#F32TYPE]] [[#EXTRACT_4_V16XF32TYPE:]] [[#VEC_V16XF32TYPE]] [[#CONST_4]]
; CHECK-SPIRV: VectorExtractDynamic [[#F32TYPE]] [[#EXTRACT_5_V16XF32TYPE:]] [[#VEC_V16XF32TYPE]] [[#CONST_5]]
; CHECK-SPIRV: VectorExtractDynamic [[#F32TYPE]] [[#EXTRACT_6_V16XF32TYPE:]] [[#VEC_V16XF32TYPE]] [[#CONST_6]]
; CHECK-SPIRV: VectorExtractDynamic [[#F32TYPE]] [[#EXTRACT_7_V16XF32TYPE:]] [[#VEC_V16XF32TYPE]] [[#CONST_7]]
; CHECK-SPIRV: VectorExtractDynamic [[#F32TYPE]] [[#EXTRACT_8_V16XF32TYPE:]] [[#VEC_V16XF32TYPE]] [[#CONST_8]]
; CHECK-SPIRV: VectorExtractDynamic [[#F32TYPE]] [[#EXTRACT_9_V16XF32TYPE:]] [[#VEC_V16XF32TYPE]] [[#CONST_9]]
; CHECK-SPIRV: VectorExtractDynamic [[#F32TYPE]] [[#EXTRACT_10_V16XF32TYPE:]] [[#VEC_V16XF32TYPE]] [[#CONST_10]]
; CHECK-SPIRV: VectorExtractDynamic [[#F32TYPE]] [[#EXTRACT_11_V16XF32TYPE:]] [[#VEC_V16XF32TYPE]] [[#CONST_11]]
; CHECK-SPIRV: VectorExtractDynamic [[#F32TYPE]] [[#EXTRACT_12_V16XF32TYPE:]] [[#VEC_V16XF32TYPE]] [[#CONST_12]]
; CHECK-SPIRV: VectorExtractDynamic [[#F32TYPE]] [[#EXTRACT_13_V16XF32TYPE:]] [[#VEC_V16XF32TYPE]] [[#CONST_13]]
; CHECK-SPIRV: VectorExtractDynamic [[#F32TYPE]] [[#EXTRACT_14_V16XF32TYPE:]] [[#VEC_V16XF32TYPE]] [[#CONST_14]]
; CHECK-SPIRV: VectorExtractDynamic [[#F32TYPE]] [[#EXTRACT_15_V16XF32TYPE:]] [[#VEC_V16XF32TYPE]] [[#CONST_15]]

; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_0_V16XF32TYPE:]] [[#EXTRACT_0_V16XF32TYPE]] [[#EXTRACT_1_V16XF32TYPE]]
; CHECK-SPIRV: Select [[#F32TYPE]] [[#SELECT_0_V16XF32TYPE:]] [[#COND_0_V16XF32TYPE]] [[#EXTRACT_0_V16XF32TYPE]] [[#EXTRACT_1_V16XF32TYPE]]
; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_1_V16XF32TYPE:]] [[#EXTRACT_2_V16XF32TYPE]] [[#EXTRACT_3_V16XF32TYPE]]
; CHECK-SPIRV: Select [[#F32TYPE]] [[#SELECT_1_V16XF32TYPE:]] [[#COND_1_V16XF32TYPE]] [[#EXTRACT_2_V16XF32TYPE]] [[#EXTRACT_3_V16XF32TYPE]]
; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_2_V16XF32TYPE:]] [[#EXTRACT_4_V16XF32TYPE]] [[#EXTRACT_5_V16XF32TYPE]]
; CHECK-SPIRV: Select [[#F32TYPE]] [[#SELECT_2_V16XF32TYPE:]] [[#COND_2_V16XF32TYPE]] [[#EXTRACT_4_V16XF32TYPE]] [[#EXTRACT_5_V16XF32TYPE]]
; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_3_V16XF32TYPE:]] [[#EXTRACT_6_V16XF32TYPE]] [[#EXTRACT_7_V16XF32TYPE]]
; CHECK-SPIRV: Select [[#F32TYPE]] [[#SELECT_3_V16XF32TYPE:]] [[#COND_3_V16XF32TYPE]] [[#EXTRACT_6_V16XF32TYPE]] [[#EXTRACT_7_V16XF32TYPE]]
; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_4_V16XF32TYPE:]] [[#EXTRACT_8_V16XF32TYPE]] [[#EXTRACT_9_V16XF32TYPE]]
; CHECK-SPIRV: Select [[#F32TYPE]] [[#SELECT_4_V16XF32TYPE:]] [[#COND_4_V16XF32TYPE]] [[#EXTRACT_8_V16XF32TYPE]] [[#EXTRACT_9_V16XF32TYPE]]
; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_5_V16XF32TYPE:]] [[#EXTRACT_10_V16XF32TYPE]] [[#EXTRACT_11_V16XF32TYPE]]
; CHECK-SPIRV: Select [[#F32TYPE]] [[#SELECT_5_V16XF32TYPE:]] [[#COND_5_V16XF32TYPE]] [[#EXTRACT_10_V16XF32TYPE]] [[#EXTRACT_11_V16XF32TYPE]]
; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_6_V16XF32TYPE:]] [[#EXTRACT_12_V16XF32TYPE]] [[#EXTRACT_13_V16XF32TYPE]]
; CHECK-SPIRV: Select [[#F32TYPE]] [[#SELECT_6_V16XF32TYPE:]] [[#COND_6_V16XF32TYPE]] [[#EXTRACT_12_V16XF32TYPE]] [[#EXTRACT_13_V16XF32TYPE]]
; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_7_V16XF32TYPE:]] [[#EXTRACT_14_V16XF32TYPE]] [[#EXTRACT_15_V16XF32TYPE]]
; CHECK-SPIRV: Select [[#F32TYPE]] [[#SELECT_7_V16XF32TYPE:]] [[#COND_7_V16XF32TYPE]] [[#EXTRACT_14_V16XF32TYPE]] [[#EXTRACT_15_V16XF32TYPE]]

; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_8_V16XF32TYPE:]] [[#SELECT_0_V16XF32TYPE]] [[#SELECT_1_V16XF32TYPE]] 
; CHECK-SPIRV: Select [[#F32TYPE]] [[#SELECT_8_V16XF32TYPE:]] [[#COND_8_V16XF32TYPE]] [[#SELECT_0_V16XF32TYPE]] [[#SELECT_1_V16XF32TYPE]]
; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_9_V16XF32TYPE:]] [[#SELECT_2_V16XF32TYPE]] [[#SELECT_3_V16XF32TYPE]]
; CHECK-SPIRV: Select [[#F32TYPE]] [[#SELECT_9_V16XF32TYPE:]] [[#COND_9_V16XF32TYPE]] [[#SELECT_2_V16XF32TYPE]] [[#SELECT_3_V16XF32TYPE]]
; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_10_V16XF32TYPE:]] [[#SELECT_4_V16XF32TYPE]] [[#SELECT_5_V16XF32TYPE]] 
; CHECK-SPIRV: Select [[#F32TYPE]] [[#SELECT_10_V16XF32TYPE:]] [[#COND_10_V16XF32TYPE]] [[#SELECT_4_V16XF32TYPE]] [[#SELECT_5_V16XF32TYPE]]
; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_11_V16XF32TYPE:]] [[#SELECT_6_V16XF32TYPE]] [[#SELECT_7_V16XF32TYPE]]
; CHECK-SPIRV: Select [[#F32TYPE]] [[#SELECT_11_V16XF32TYPE:]] [[#COND_11_V16XF32TYPE]] [[#SELECT_6_V16XF32TYPE]] [[#SELECT_7_V16XF32TYPE]]

; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_12_V16XF32TYPE:]] [[#SELECT_8_V16XF32TYPE]] [[#SELECT_9_V16XF32TYPE]]
; CHECK-SPIRV: Select [[#F32TYPE]] [[#SELECT_12_V16XF32TYPE:]] [[#COND_12_V16XF32TYPE]] [[#SELECT_8_V16XF32TYPE]] [[#SELECT_9_V16XF32TYPE]]
; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_13_V16XF32TYPE:]] [[#SELECT_10_V16XF32TYPE]] [[#SELECT_11_V16XF32TYPE]]
; CHECK-SPIRV: Select [[#F32TYPE]] [[#SELECT_13_V16XF32TYPE:]] [[#COND_13_V16XF32TYPE]] [[#SELECT_10_V16XF32TYPE]] [[#SELECT_11_V16XF32TYPE]]

; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_14_V16XF32TYPE:]] [[#SELECT_12_V16XF32TYPE]] [[#SELECT_13_V16XF32TYPE]]
; CHECK-SPIRV: Select [[#F32TYPE]] [[#SELECT_14_V16XF32TYPE:]] [[#COND_14_V16XF32TYPE]] [[#SELECT_12_V16XF32TYPE]] [[#SELECT_13_V16XF32TYPE]]
; CHECK-SPIRV: ReturnValue [[#SELECT_14_V16XF32TYPE]]

; -------- F64 --------

; CHECK-SPIRV: FunctionParameter [[#V2XF64TYPE]] [[#VEC_V2XF64TYPE:]]
; CHECK-SPIRV: VectorExtractDynamic [[#F64TYPE]] [[#EXTRACT_0_V2XF64TYPE:]] [[#VEC_V2XF64TYPE]] [[#CONST_0]]
; CHECK-SPIRV: VectorExtractDynamic [[#F64TYPE]] [[#EXTRACT_1_V2XF64TYPE:]] [[#VEC_V2XF64TYPE]] [[#CONST_1]]

; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_0_V2XF64TYPE:]] [[#EXTRACT_0_V2XF64TYPE]] [[#EXTRACT_1_V2XF64TYPE]]
; CHECK-SPIRV: Select [[#F64TYPE]] [[#SELECT_0_V2XF64TYPE:]] [[#COND_0_V2XF64TYPE]] [[#EXTRACT_0_V2XF64TYPE]] [[#EXTRACT_1_V2XF64TYPE]]
; CHECK-SPIRV: ReturnValue [[#SELECT_0_V2XF64TYPE]]

; CHECK-SPIRV: FunctionParameter [[#V3XF64TYPE]] [[#VEC_V3XF64TYPE:]]
; CHECK-SPIRV: VectorExtractDynamic [[#F64TYPE]] [[#EXTRACT_0_V3XF64TYPE:]] [[#VEC_V3XF64TYPE]] [[#CONST_0]]
; CHECK-SPIRV: VectorExtractDynamic [[#F64TYPE]] [[#EXTRACT_1_V3XF64TYPE:]] [[#VEC_V3XF64TYPE]] [[#CONST_1]]
; CHECK-SPIRV: VectorExtractDynamic [[#F64TYPE]] [[#EXTRACT_2_V3XF64TYPE:]] [[#VEC_V3XF64TYPE]] [[#CONST_2]]

; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_0_V3XF64TYPE:]] [[#EXTRACT_0_V3XF64TYPE]] [[#EXTRACT_1_V3XF64TYPE]]
; CHECK-SPIRV: Select [[#F64TYPE]] [[#SELECT_0_V3XF64TYPE:]] [[#COND_0_V3XF64TYPE]] [[#EXTRACT_0_V3XF64TYPE]] [[#EXTRACT_1_V3XF64TYPE]]

; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_1_V3XF64TYPE:]] [[#SELECT_0_V3XF64TYPE]] [[#EXTRACT_2_V3XF64TYPE]]
; CHECK-SPIRV: Select [[#F64TYPE]] [[#SELECT_1_V3XF64TYPE:]] [[#COND_1_V3XF64TYPE]] [[#SELECT_0_V3XF64TYPE]] [[#EXTRACT_2_V3XF64TYPE]]
; CHECK-SPIRV: ReturnValue [[#SELECT_1_V3XF64TYPE]]

; CHECK-SPIRV: FunctionParameter [[#V4XF64TYPE]] [[#VEC_V4XF64TYPE:]]
; CHECK-SPIRV: VectorExtractDynamic [[#F64TYPE]] [[#EXTRACT_0_V4XF64TYPE:]] [[#VEC_V4XF64TYPE]] [[#CONST_0]]
; CHECK-SPIRV: VectorExtractDynamic [[#F64TYPE]] [[#EXTRACT_1_V4XF64TYPE:]] [[#VEC_V4XF64TYPE]] [[#CONST_1]]
; CHECK-SPIRV: VectorExtractDynamic [[#F64TYPE]] [[#EXTRACT_2_V4XF64TYPE:]] [[#VEC_V4XF64TYPE]] [[#CONST_2]]
; CHECK-SPIRV: VectorExtractDynamic [[#F64TYPE]] [[#EXTRACT_3_V4XF64TYPE:]] [[#VEC_V4XF64TYPE]] [[#CONST_3]]

; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_0_V4XF64TYPE:]] [[#EXTRACT_0_V4XF64TYPE]] [[#EXTRACT_1_V4XF64TYPE]]
; CHECK-SPIRV: Select [[#F64TYPE]] [[#SELECT_0_V4XF64TYPE:]] [[#COND_0_V4XF64TYPE]] [[#EXTRACT_0_V4XF64TYPE]] [[#EXTRACT_1_V4XF64TYPE]]
; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_1_V4XF64TYPE:]] [[#EXTRACT_2_V4XF64TYPE]] [[#EXTRACT_3_V4XF64TYPE]]
; CHECK-SPIRV: Select [[#F64TYPE]] [[#SELECT_1_V4XF64TYPE:]] [[#COND_1_V4XF64TYPE]] [[#EXTRACT_2_V4XF64TYPE]] [[#EXTRACT_3_V4XF64TYPE]]

; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_2_V4XF64TYPE:]] [[#SELECT_0_V4XF64TYPE]] [[#SELECT_1_V4XF64TYPE]]
; CHECK-SPIRV: Select [[#F64TYPE]] [[#SELECT_2_V4XF64TYPE:]] [[#COND_2_V4XF64TYPE]] [[#SELECT_0_V4XF64TYPE]] [[#SELECT_1_V4XF64TYPE]]
; CHECK-SPIRV: ReturnValue [[#SELECT_2_V4XF64TYPE]]

; CHECK-SPIRV: FunctionParameter [[#V8XF64TYPE]] [[#VEC_V8XF64TYPE:]]
; CHECK-SPIRV: VectorExtractDynamic [[#F64TYPE]] [[#EXTRACT_0_V8XF64TYPE:]] [[#VEC_V8XF64TYPE]] [[#CONST_0]]
; CHECK-SPIRV: VectorExtractDynamic [[#F64TYPE]] [[#EXTRACT_1_V8XF64TYPE:]] [[#VEC_V8XF64TYPE]] [[#CONST_1]]
; CHECK-SPIRV: VectorExtractDynamic [[#F64TYPE]] [[#EXTRACT_2_V8XF64TYPE:]] [[#VEC_V8XF64TYPE]] [[#CONST_2]]
; CHECK-SPIRV: VectorExtractDynamic [[#F64TYPE]] [[#EXTRACT_3_V8XF64TYPE:]] [[#VEC_V8XF64TYPE]] [[#CONST_3]]
; CHECK-SPIRV: VectorExtractDynamic [[#F64TYPE]] [[#EXTRACT_4_V8XF64TYPE:]] [[#VEC_V8XF64TYPE]] [[#CONST_4]]
; CHECK-SPIRV: VectorExtractDynamic [[#F64TYPE]] [[#EXTRACT_5_V8XF64TYPE:]] [[#VEC_V8XF64TYPE]] [[#CONST_5]]
; CHECK-SPIRV: VectorExtractDynamic [[#F64TYPE]] [[#EXTRACT_6_V8XF64TYPE:]] [[#VEC_V8XF64TYPE]] [[#CONST_6]]
; CHECK-SPIRV: VectorExtractDynamic [[#F64TYPE]] [[#EXTRACT_7_V8XF64TYPE:]] [[#VEC_V8XF64TYPE]] [[#CONST_7]]

; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_0_V8XF64TYPE:]] [[#EXTRACT_0_V8XF64TYPE]] [[#EXTRACT_1_V8XF64TYPE]]
; CHECK-SPIRV: Select [[#F64TYPE]] [[#SELECT_0_V8XF64TYPE:]] [[#COND_0_V8XF64TYPE]] [[#EXTRACT_0_V8XF64TYPE]] [[#EXTRACT_1_V8XF64TYPE]]
; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_1_V8XF64TYPE:]] [[#EXTRACT_2_V8XF64TYPE]] [[#EXTRACT_3_V8XF64TYPE]]
; CHECK-SPIRV: Select [[#F64TYPE]] [[#SELECT_1_V8XF64TYPE:]] [[#COND_1_V8XF64TYPE]] [[#EXTRACT_2_V8XF64TYPE]] [[#EXTRACT_3_V8XF64TYPE]]
; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_2_V8XF64TYPE:]] [[#EXTRACT_4_V8XF64TYPE]] [[#EXTRACT_5_V8XF64TYPE]]
; CHECK-SPIRV: Select [[#F64TYPE]] [[#SELECT_2_V8XF64TYPE:]] [[#COND_2_V8XF64TYPE]] [[#EXTRACT_4_V8XF64TYPE]] [[#EXTRACT_5_V8XF64TYPE]]
; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_3_V8XF64TYPE:]] [[#EXTRACT_6_V8XF64TYPE]] [[#EXTRACT_7_V8XF64TYPE]]
; CHECK-SPIRV: Select [[#F64TYPE]] [[#SELECT_3_V8XF64TYPE:]] [[#COND_3_V8XF64TYPE]] [[#EXTRACT_6_V8XF64TYPE]] [[#EXTRACT_7_V8XF64TYPE]]

; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_4_V8XF64TYPE:]] [[#SELECT_0_V8XF64TYPE]] [[#SELECT_1_V8XF64TYPE]] 
; CHECK-SPIRV: Select [[#F64TYPE]] [[#SELECT_4_V8XF64TYPE:]] [[#COND_4_V8XF64TYPE]] [[#SELECT_0_V8XF64TYPE]] [[#SELECT_1_V8XF64TYPE]]
; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_5_V8XF64TYPE:]] [[#SELECT_2_V8XF64TYPE]] [[#SELECT_3_V8XF64TYPE]]
; CHECK-SPIRV: Select [[#F64TYPE]] [[#SELECT_5_V8XF64TYPE:]] [[#COND_5_V8XF64TYPE]] [[#SELECT_2_V8XF64TYPE]] [[#SELECT_3_V8XF64TYPE]]

; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_6_V8XF64TYPE:]] [[#SELECT_4_V8XF64TYPE]] [[#SELECT_5_V8XF64TYPE]]
; CHECK-SPIRV: Select [[#F64TYPE]] [[#SELECT_6_V8XF64TYPE:]] [[#COND_6_V8XF64TYPE:]] [[#SELECT_4_V8XF64TYPE]] [[#SELECT_5_V8XF64TYPE]]
; CHECK-SPIRV: ReturnValue [[#SELECT_6_V8XF64TYPE]]

; CHECK-SPIRV: FunctionParameter [[#V16XF64TYPE]] [[#VEC_V16XF64TYPE:]]
; CHECK-SPIRV: VectorExtractDynamic [[#F64TYPE]] [[#EXTRACT_0_V16XF64TYPE:]] [[#VEC_V16XF64TYPE]] [[#CONST_0]]
; CHECK-SPIRV: VectorExtractDynamic [[#F64TYPE]] [[#EXTRACT_1_V16XF64TYPE:]] [[#VEC_V16XF64TYPE]] [[#CONST_1]]
; CHECK-SPIRV: VectorExtractDynamic [[#F64TYPE]] [[#EXTRACT_2_V16XF64TYPE:]] [[#VEC_V16XF64TYPE]] [[#CONST_2]]
; CHECK-SPIRV: VectorExtractDynamic [[#F64TYPE]] [[#EXTRACT_3_V16XF64TYPE:]] [[#VEC_V16XF64TYPE]] [[#CONST_3]]
; CHECK-SPIRV: VectorExtractDynamic [[#F64TYPE]] [[#EXTRACT_4_V16XF64TYPE:]] [[#VEC_V16XF64TYPE]] [[#CONST_4]]
; CHECK-SPIRV: VectorExtractDynamic [[#F64TYPE]] [[#EXTRACT_5_V16XF64TYPE:]] [[#VEC_V16XF64TYPE]] [[#CONST_5]]
; CHECK-SPIRV: VectorExtractDynamic [[#F64TYPE]] [[#EXTRACT_6_V16XF64TYPE:]] [[#VEC_V16XF64TYPE]] [[#CONST_6]]
; CHECK-SPIRV: VectorExtractDynamic [[#F64TYPE]] [[#EXTRACT_7_V16XF64TYPE:]] [[#VEC_V16XF64TYPE]] [[#CONST_7]]
; CHECK-SPIRV: VectorExtractDynamic [[#F64TYPE]] [[#EXTRACT_8_V16XF64TYPE:]] [[#VEC_V16XF64TYPE]] [[#CONST_8]]
; CHECK-SPIRV: VectorExtractDynamic [[#F64TYPE]] [[#EXTRACT_9_V16XF64TYPE:]] [[#VEC_V16XF64TYPE]] [[#CONST_9]]
; CHECK-SPIRV: VectorExtractDynamic [[#F64TYPE]] [[#EXTRACT_10_V16XF64TYPE:]] [[#VEC_V16XF64TYPE]] [[#CONST_10]]
; CHECK-SPIRV: VectorExtractDynamic [[#F64TYPE]] [[#EXTRACT_11_V16XF64TYPE:]] [[#VEC_V16XF64TYPE]] [[#CONST_11]]
; CHECK-SPIRV: VectorExtractDynamic [[#F64TYPE]] [[#EXTRACT_12_V16XF64TYPE:]] [[#VEC_V16XF64TYPE]] [[#CONST_12]]
; CHECK-SPIRV: VectorExtractDynamic [[#F64TYPE]] [[#EXTRACT_13_V16XF64TYPE:]] [[#VEC_V16XF64TYPE]] [[#CONST_13]]
; CHECK-SPIRV: VectorExtractDynamic [[#F64TYPE]] [[#EXTRACT_14_V16XF64TYPE:]] [[#VEC_V16XF64TYPE]] [[#CONST_14]]
; CHECK-SPIRV: VectorExtractDynamic [[#F64TYPE]] [[#EXTRACT_15_V16XF64TYPE:]] [[#VEC_V16XF64TYPE]] [[#CONST_15]]

; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_0_V16XF64TYPE:]] [[#EXTRACT_0_V16XF64TYPE]] [[#EXTRACT_1_V16XF64TYPE]]
; CHECK-SPIRV: Select [[#F64TYPE]] [[#SELECT_0_V16XF64TYPE:]] [[#COND_0_V16XF64TYPE]] [[#EXTRACT_0_V16XF64TYPE]] [[#EXTRACT_1_V16XF64TYPE]]
; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_1_V16XF64TYPE:]] [[#EXTRACT_2_V16XF64TYPE]] [[#EXTRACT_3_V16XF64TYPE]]
; CHECK-SPIRV: Select [[#F64TYPE]] [[#SELECT_1_V16XF64TYPE:]] [[#COND_1_V16XF64TYPE]] [[#EXTRACT_2_V16XF64TYPE]] [[#EXTRACT_3_V16XF64TYPE]]
; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_2_V16XF64TYPE:]] [[#EXTRACT_4_V16XF64TYPE]] [[#EXTRACT_5_V16XF64TYPE]]
; CHECK-SPIRV: Select [[#F64TYPE]] [[#SELECT_2_V16XF64TYPE:]] [[#COND_2_V16XF64TYPE]] [[#EXTRACT_4_V16XF64TYPE]] [[#EXTRACT_5_V16XF64TYPE]]
; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_3_V16XF64TYPE:]] [[#EXTRACT_6_V16XF64TYPE]] [[#EXTRACT_7_V16XF64TYPE]]
; CHECK-SPIRV: Select [[#F64TYPE]] [[#SELECT_3_V16XF64TYPE:]] [[#COND_3_V16XF64TYPE]] [[#EXTRACT_6_V16XF64TYPE]] [[#EXTRACT_7_V16XF64TYPE]]
; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_4_V16XF64TYPE:]] [[#EXTRACT_8_V16XF64TYPE]] [[#EXTRACT_9_V16XF64TYPE]]
; CHECK-SPIRV: Select [[#F64TYPE]] [[#SELECT_4_V16XF64TYPE:]] [[#COND_4_V16XF64TYPE]] [[#EXTRACT_8_V16XF64TYPE]] [[#EXTRACT_9_V16XF64TYPE]]
; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_5_V16XF64TYPE:]] [[#EXTRACT_10_V16XF64TYPE]] [[#EXTRACT_11_V16XF64TYPE]]
; CHECK-SPIRV: Select [[#F64TYPE]] [[#SELECT_5_V16XF64TYPE:]] [[#COND_5_V16XF64TYPE]] [[#EXTRACT_10_V16XF64TYPE]] [[#EXTRACT_11_V16XF64TYPE]]
; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_6_V16XF64TYPE:]] [[#EXTRACT_12_V16XF64TYPE]] [[#EXTRACT_13_V16XF64TYPE]]
; CHECK-SPIRV: Select [[#F64TYPE]] [[#SELECT_6_V16XF64TYPE:]] [[#COND_6_V16XF64TYPE]] [[#EXTRACT_12_V16XF64TYPE]] [[#EXTRACT_13_V16XF64TYPE]]
; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_7_V16XF64TYPE:]] [[#EXTRACT_14_V16XF64TYPE]] [[#EXTRACT_15_V16XF64TYPE]]
; CHECK-SPIRV: Select [[#F64TYPE]] [[#SELECT_7_V16XF64TYPE:]] [[#COND_7_V16XF64TYPE]] [[#EXTRACT_14_V16XF64TYPE]] [[#EXTRACT_15_V16XF64TYPE]]

; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_8_V16XF64TYPE:]] [[#SELECT_0_V16XF64TYPE]] [[#SELECT_1_V16XF64TYPE]] 
; CHECK-SPIRV: Select [[#F64TYPE]] [[#SELECT_8_V16XF64TYPE:]] [[#COND_8_V16XF64TYPE]] [[#SELECT_0_V16XF64TYPE]] [[#SELECT_1_V16XF64TYPE]]
; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_9_V16XF64TYPE:]] [[#SELECT_2_V16XF64TYPE]] [[#SELECT_3_V16XF64TYPE]]
; CHECK-SPIRV: Select [[#F64TYPE]] [[#SELECT_9_V16XF64TYPE:]] [[#COND_9_V16XF64TYPE]] [[#SELECT_2_V16XF64TYPE]] [[#SELECT_3_V16XF64TYPE]]
; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_10_V16XF64TYPE:]] [[#SELECT_4_V16XF64TYPE]] [[#SELECT_5_V16XF64TYPE]] 
; CHECK-SPIRV: Select [[#F64TYPE]] [[#SELECT_10_V16XF64TYPE:]] [[#COND_10_V16XF64TYPE]] [[#SELECT_4_V16XF64TYPE]] [[#SELECT_5_V16XF64TYPE]]
; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_11_V16XF64TYPE:]] [[#SELECT_6_V16XF64TYPE]] [[#SELECT_7_V16XF64TYPE]]
; CHECK-SPIRV: Select [[#F64TYPE]] [[#SELECT_11_V16XF64TYPE:]] [[#COND_11_V16XF64TYPE]] [[#SELECT_6_V16XF64TYPE]] [[#SELECT_7_V16XF64TYPE]]

; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_12_V16XF64TYPE:]] [[#SELECT_8_V16XF64TYPE]] [[#SELECT_9_V16XF64TYPE]]
; CHECK-SPIRV: Select [[#F64TYPE]] [[#SELECT_12_V16XF64TYPE:]] [[#COND_12_V16XF64TYPE]] [[#SELECT_8_V16XF64TYPE]] [[#SELECT_9_V16XF64TYPE]]
; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_13_V16XF64TYPE:]] [[#SELECT_10_V16XF64TYPE]] [[#SELECT_11_V16XF64TYPE]]
; CHECK-SPIRV: Select [[#F64TYPE]] [[#SELECT_13_V16XF64TYPE:]] [[#COND_13_V16XF64TYPE]] [[#SELECT_10_V16XF64TYPE]] [[#SELECT_11_V16XF64TYPE]]

; CHECK-SPIRV: FOrdLessThan [[#BTYPE]] [[#COND_14_V16XF64TYPE:]] [[#SELECT_12_V16XF64TYPE]] [[#SELECT_13_V16XF64TYPE]]
; CHECK-SPIRV: Select [[#F64TYPE]] [[#SELECT_14_V16XF64TYPE:]] [[#COND_14_V16XF64TYPE]] [[#SELECT_12_V16XF64TYPE]] [[#SELECT_13_V16XF64TYPE]]
; CHECK-SPIRV: ReturnValue [[#SELECT_14_V16XF64TYPE]]

define spir_func half @test_vector_reduce_fmin_v2half(<2 x half> %v) {
entry:
  %0 = call half @llvm.vector.reduce.fmin.v2half(<2 x half> %v)
  ret half %0
}

define spir_func half @test_vector_reduce_fmin_v3half(<3 x half> %v) {
entry:
  %0 = call half @llvm.vector.reduce.fmin.v3half(<3 x half> %v)
  ret half %0
}

define spir_func half @test_vector_reduce_fmin_v4half(<4 x half> %v) {
entry:
  %0 = call half @llvm.vector.reduce.fmin.v4half(<4 x half> %v)
  ret half %0
}

define spir_func half @test_vector_reduce_fmin_v8half(<8 x half> %v) {
entry:
  %0 = call half @llvm.vector.reduce.fmin.v8half(<8 x half> %v)
  ret half %0
}

define spir_func half @test_vector_reduce_fmin_v16half(<16 x half> %v) {
entry:
  %0 = call half @llvm.vector.reduce.fmin.v16half(<16 x half> %v)
  ret half %0
}

define spir_func float @test_vector_reduce_fmin_v2float(<2 x float> %v) {
entry:
  %0 = call float @llvm.vector.reduce.fmin.v2float(<2 x float> %v)
  ret float %0
}

define spir_func float @test_vector_reduce_fmin_v3float(<3 x float> %v) {
entry:
  %0 = call float @llvm.vector.reduce.fmin.v3float(<3 x float> %v)
  ret float %0
}

define spir_func float @test_vector_reduce_fmin_v4float(<4 x float> %v) {
entry:
  %0 = call float @llvm.vector.reduce.fmin.v4float(<4 x float> %v)
  ret float %0
}

define spir_func float @test_vector_reduce_fmin_v8float(<8 x float> %v) {
entry:
  %0 = call float @llvm.vector.reduce.fmin.v8float(<8 x float> %v)
  ret float %0
}

define spir_func float @test_vector_reduce_fmin_v16float(<16 x float> %v) {
entry:
  %0 = call float @llvm.vector.reduce.fmin.v16float(<16 x float> %v)
  ret float %0
}

define spir_func double @test_vector_reduce_fmin_v2double(<2 x double> %v) {
entry:
  %0 = call double @llvm.vector.reduce.fmin.v2double(<2 x double> %v)
  ret double %0
}

define spir_func double @test_vector_reduce_fmin_v3double(<3 x double> %v) {
entry:
  %0 = call double @llvm.vector.reduce.fmin.v3double(<3 x double> %v)
  ret double %0
}

define spir_func double @test_vector_reduce_fmin_v4double(<4 x double> %v) {
entry:
  %0 = call double @llvm.vector.reduce.fmin.v4double(<4 x double> %v)
  ret double %0
}

define spir_func double @test_vector_reduce_fmin_v8double(<8 x double> %v) {
entry:
  %0 = call double @llvm.vector.reduce.fmin.v8double(<8 x double> %v)
  ret double %0
}

define spir_func double @test_vector_reduce_fmin_v16double(<16 x double> %v) {
entry:
  %0 = call double @llvm.vector.reduce.fmin.v16double(<16 x double> %v)
  ret double %0
}

declare half @llvm.vector.reduce.fmin.v2half(<2 x half>)
declare half @llvm.vector.reduce.fmin.v3half(<3 x half>)
declare half @llvm.vector.reduce.fmin.v4half(<4 x half>)
declare half @llvm.vector.reduce.fmin.v8half(<8 x half>)
declare half @llvm.vector.reduce.fmin.v16half(<16 x half>)
declare float @llvm.vector.reduce.fmin.v2float(<2 x float>)
declare float @llvm.vector.reduce.fmin.v3float(<3 x float>)
declare float @llvm.vector.reduce.fmin.v4float(<4 x float>)
declare float @llvm.vector.reduce.fmin.v8float(<8 x float>)
declare float @llvm.vector.reduce.fmin.v16float(<16 x float>)
declare double @llvm.vector.reduce.fmin.v2double(<2 x double>)
declare double @llvm.vector.reduce.fmin.v3double(<3 x double>)
declare double @llvm.vector.reduce.fmin.v4double(<4 x double>)
declare double @llvm.vector.reduce.fmin.v8double(<8 x double>)
declare double @llvm.vector.reduce.fmin.v16double(<16 x double>)