; The following SPIR 2.0 was obtained via SPIR-V generator/Clang:
; bash$ clang -cc1 -x cl -cl-std=CL2.0 -triple spir64-unknonw-unknown -emit-llvm -include opencl-20.h -Dcl_khr_subgroups pipe_builtins.cl -o pipe_builtins.ll

;; Regression test:
;; Pipe built-ins are mangled accordingly to SPIR2.0/C++ ABI.

; #pragma OPENCL EXTENSION cl_khr_subgroups : enable
;
; __kernel void test_pipe_convenience_write_uint(__global uint *src, __write_only pipe uint out_pipe)
; {
;   int gid = get_global_id(0);
;   write_pipe(out_pipe, &src[gid]);
; }
;
; __kernel void test_pipe_convenience_read_uint(__read_only pipe uint in_pipe, __global uint *dst)
; {
;   int gid = get_global_id(0);
;   read_pipe(in_pipe, &dst[gid]);
; }
;
; __kernel void test_pipe_write(__global int *src, __write_only pipe int out_pipe)
; {
;     int gid = get_global_id(0);
;     reserve_id_t res_id;
;     res_id = reserve_write_pipe(out_pipe, 1);
;     if(is_valid_reserve_id(res_id))
;     {
;         write_pipe(out_pipe, res_id, 0, &src[gid]);
;         commit_write_pipe(out_pipe, res_id);
;     }
; }
;
; __kernel void test_pipe_query_functions(__write_only pipe int out_pipe, __global int *num_packets, __global int *max_packets)
; {
;     *max_packets = get_pipe_max_packets(out_pipe);
;     *num_packets = get_pipe_num_packets(out_pipe);
; }
;
; __kernel void test_pipe_read(__read_only pipe int in_pipe, __global int *dst)
; {
;     int gid = get_global_id(0);
;     reserve_id_t res_id;
;     res_id = reserve_read_pipe(in_pipe, 1);
;     if(is_valid_reserve_id(res_id))
;     {
;         read_pipe(in_pipe, res_id, 0, &dst[gid]);
;         commit_read_pipe(in_pipe, res_id);
;     }
; }
;
; __kernel void test_pipe_workgroup_write_char(__global char *src, __write_only pipe char out_pipe)
; {
;   int gid = get_global_id(0);
;   __local reserve_id_t res_id;
;
;   res_id = work_group_reserve_write_pipe(out_pipe, get_local_size(0));
;   if(is_valid_reserve_id(res_id))
;   {
;     write_pipe(out_pipe, res_id, get_local_id(0), &src[gid]);
;     work_group_commit_write_pipe(out_pipe, res_id);
;   }
; }
;
; __kernel void test_pipe_workgroup_read_char(__read_only pipe char in_pipe, __global char *dst)
; {
;   int gid = get_global_id(0);
;   __local reserve_id_t res_id;
;
;   res_id = work_group_reserve_read_pipe(in_pipe, get_local_size(0));
;   if(is_valid_reserve_id(res_id))
;   {
;     read_pipe(in_pipe, res_id, get_local_id(0), &dst[gid]);
;     work_group_commit_read_pipe(in_pipe, res_id);
;   }
; }
;
; __kernel void test_pipe_subgroup_write_uint(__global uint *src, __write_only pipe uint out_pipe)
; {
;   int gid = get_global_id(0);
;   reserve_id_t res_id;
;
;   res_id = sub_group_reserve_write_pipe(out_pipe, get_sub_group_size());
;   if(is_valid_reserve_id(res_id))
;   {
;     write_pipe(out_pipe, res_id, get_sub_group_local_id(), &src[gid]);
;     sub_group_commit_write_pipe(out_pipe, res_id);
;   }
; }
;
; __kernel void test_pipe_subgroup_read_uint(__read_only pipe uint in_pipe, __global uint *dst)
; {
;   int gid = get_global_id(0);
;   reserve_id_t res_id;
;
;   res_id = sub_group_reserve_read_pipe(in_pipe, get_sub_group_size());
;   if(is_valid_reserve_id(res_id))
;   {
;     read_pipe(in_pipe, res_id, get_sub_group_local_id(), &dst[gid]);
;     sub_group_commit_read_pipe(in_pipe, res_id);
;   }
; }

; RUN: llvm-as %s -o %t.bc
; RUN: llvm-spirv %t.bc -spirv-text -o %t.spt
; RUN: FileCheck < %t.spt %s --check-prefix=CHECK-SPIRV
; RUN: llvm-spirv %t.bc -o %t.spv
; RUN: llvm-spirv -r %t.spv -o %t.bc
; RUN: llvm-dis < %t.bc | FileCheck %s --check-prefix=CHECK-LLVM

; CHECK-SPIRV-DAG: TypePipe [[ROPipeTy:[0-9]+]] 0
; CHECK-SPIRV-DAG: TypePipe [[WOPipeTy:[0-9]+]] 1

; ModuleID = 'pipe_builtins.cl'
target datalayout = "e-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "spir64-unknonw-unknown"

%opencl.reserve_id_t = type opaque
%opencl.pipe_wo_t = type opaque
%opencl.pipe_ro_t = type opaque

@test_pipe_workgroup_write_char.res_id = internal addrspace(3) global %opencl.reserve_id_t* undef, align 8
@test_pipe_workgroup_read_char.res_id = internal addrspace(3) global %opencl.reserve_id_t* undef, align 8

; Function Attrs: nounwind
define spir_kernel void @test_pipe_convenience_write_uint(i32 addrspace(1)* %src, %opencl.pipe_wo_t addrspace(1)* %out_pipe) #0 !kernel_arg_addr_space !4 !kernel_arg_access_qual !5 !kernel_arg_type !6 !kernel_arg_base_type !7 !kernel_arg_type_qual !8 !kernel_arg_host_accessible !9 !kernel_arg_pipe_depth !10 !kernel_arg_pipe_io !11 !kernel_arg_buffer_location !11 {
; CHECK-LLVM-LABEL: @test_pipe_convenience_write_uint

; CHECK-SPIRV: 5 Function
; CHECK-SPIRV-NEXT:  FunctionParameter
; CHECK-SPIRV-NEXT:  FunctionParameter [[WOPipeTy]] [[PipeArgID:[0-9]+]]
entry:
  %call = tail call spir_func i64 @_Z13get_global_idj(i32 0) #2
  %sext = shl i64 %call, 32
  %idxprom = ashr exact i64 %sext, 32
  %arrayidx = getelementptr inbounds i32, i32 addrspace(1)* %src, i64 %idxprom
  %0 = bitcast i32 addrspace(1)* %arrayidx to i8 addrspace(1)*
  %1 = addrspacecast i8 addrspace(1)* %0 to i8 addrspace(4)*
  ; CHECK-LLVM: call{{.*}}@__write_pipe_2
  ; CHECK-SPIRV: WritePipe {{[0-9]+}} {{[0-9]+}} [[PipeArgID]] {{[0-9]+}} {{[0-9]+}} {{[0-9]+}}
  %2 = tail call i32 @__write_pipe_2(%opencl.pipe_wo_t addrspace(1)* %out_pipe, i8 addrspace(4)* %1, i32 4, i32 4) #5
  ret void
; CHECK-SPIRV-LABEL: 1 FunctionEnd
}

declare spir_func i64 @_Z13get_global_idj(i32) #1

declare i32 @__write_pipe_2(%opencl.pipe_wo_t addrspace(1)*, i8 addrspace(4)*, i32, i32)

; Function Attrs: nounwind
define spir_kernel void @test_pipe_convenience_read_uint(%opencl.pipe_ro_t addrspace(1)* %in_pipe, i32 addrspace(1)* %dst) #0 !kernel_arg_addr_space !4 !kernel_arg_access_qual !12 !kernel_arg_type !13 !kernel_arg_base_type !14 !kernel_arg_type_qual !15 !kernel_arg_host_accessible !9 !kernel_arg_pipe_depth !10 !kernel_arg_pipe_io !11 !kernel_arg_buffer_location !11 {
; CHECK-LLVM-LABEL: @test_pipe_convenience_read_uint
; CHECK-SPIRV-LABEL: 5 Function
; CHECK-SPIRV-NEXT:  FunctionParameter [[ROPipeTy]] [[PipeArgID:[0-9]+]]
entry:
  %call = tail call spir_func i64 @_Z13get_global_idj(i32 0) #2
  %sext = shl i64 %call, 32
  %idxprom = ashr exact i64 %sext, 32
  %arrayidx = getelementptr inbounds i32, i32 addrspace(1)* %dst, i64 %idxprom
  %0 = bitcast i32 addrspace(1)* %arrayidx to i8 addrspace(1)*
  %1 = addrspacecast i8 addrspace(1)* %0 to i8 addrspace(4)*
  ; CHECK-LLVM: call{{.*}}@__read_pipe_2
  ; CHECK-SPIRV: ReadPipe {{[0-9]+}} {{[0-9]+}} [[PipeArgID]] {{[0-9]+}} {{[0-9]+}} {{[0-9]+}}
  %2 = tail call i32 @__read_pipe_2(%opencl.pipe_ro_t addrspace(1)* %in_pipe, i8 addrspace(4)* %1, i32 4, i32 4) #5
  ret void
; CHECK-SPIRV-LABEL: 1 FunctionEnd
}

declare i32 @__read_pipe_2(%opencl.pipe_ro_t addrspace(1)*, i8 addrspace(4)*, i32, i32)

; Function Attrs: nounwind
define spir_kernel void @test_pipe_write(i32 addrspace(1)* %src, %opencl.pipe_wo_t addrspace(1)* %out_pipe) #0 !kernel_arg_addr_space !4 !kernel_arg_access_qual !5 !kernel_arg_type !16 !kernel_arg_base_type !16 !kernel_arg_type_qual !8 !kernel_arg_host_accessible !9 !kernel_arg_pipe_depth !10 !kernel_arg_pipe_io !11 !kernel_arg_buffer_location !11 {
; CHECK-LLVM-LABEL: @test_pipe_write
; CHECK-SPIRV-LABEL: 5 Function
; CHECK-SPIRV-NEXT:  FunctionParameter
; CHECK-SPIRV-NEXT:  FunctionParameter [[WOPipeTy]] [[PipeArgID:[0-9]+]]
entry:
  %call = tail call spir_func i64 @_Z13get_global_idj(i32 0) #2
  ; CHECK-LLVM: @__reserve_write_pipe
  ; CHECK-SPIRV: ReserveWritePipePackets {{[0-9]+}} {{[0-9]+}} [[PipeArgID]] {{[0-9]+}} {{[0-9]+}} {{[0-9]+}}
  %0 = tail call %opencl.reserve_id_t* @__reserve_write_pipe(%opencl.pipe_wo_t addrspace(1)* %out_pipe, i32 1, i32 4, i32 4) #5
  %call1 = tail call spir_func zeroext i1 @_Z19is_valid_reserve_id13ocl_reserveid(%opencl.reserve_id_t* %0) #2
  br i1 %call1, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %sext = shl i64 %call, 32
  %idxprom = ashr exact i64 %sext, 32
  %arrayidx = getelementptr inbounds i32, i32 addrspace(1)* %src, i64 %idxprom
  %1 = bitcast i32 addrspace(1)* %arrayidx to i8 addrspace(1)*
  %2 = addrspacecast i8 addrspace(1)* %1 to i8 addrspace(4)*
  ; CHECK-LLVM: call{{.*}}@__write_pipe_4
  ; CHECK-SPIRV: ReservedWritePipe {{[0-9]+}} {{[0-9]+}} [[PipeArgID]] {{[0-9]+}} {{[0-9]+}} {{[0-9]+}} {{[0-9]+}} {{[0-9]+}}
  %3 = tail call i32 @__write_pipe_4(%opencl.pipe_wo_t addrspace(1)* %out_pipe, %opencl.reserve_id_t* %0, i32 0, i8 addrspace(4)* %2, i32 4, i32 4) #5
  ; CHECK-LLVM: call{{.*}}@__commit_write_pipe
  ; CHECK-SPIRV: CommitWritePipe [[PipeArgID]] {{[0-9]+}} {{[0-9]+}}
  tail call void @__commit_write_pipe(%opencl.pipe_wo_t addrspace(1)* %out_pipe, %opencl.reserve_id_t* %0, i32 4, i32 4) #5
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret void
; CHECK-SPIRV-LABEL: 1 FunctionEnd
}

declare %opencl.reserve_id_t* @__reserve_write_pipe(%opencl.pipe_wo_t addrspace(1)*, i32, i32, i32)

declare spir_func zeroext i1 @_Z19is_valid_reserve_id13ocl_reserveid(%opencl.reserve_id_t*) #1

declare i32 @__write_pipe_4(%opencl.pipe_wo_t addrspace(1)*, %opencl.reserve_id_t*, i32, i8 addrspace(4)*, i32, i32)

declare void @__commit_write_pipe(%opencl.pipe_wo_t addrspace(1)*, %opencl.reserve_id_t*, i32, i32)

; Function Attrs: nounwind
define spir_kernel void @test_pipe_query_functions(%opencl.pipe_wo_t addrspace(1)* %out_pipe, i32 addrspace(1)* %num_packets, i32 addrspace(1)* %max_packets) #3 !kernel_arg_addr_space !17 !kernel_arg_access_qual !18 !kernel_arg_type !19 !kernel_arg_base_type !19 !kernel_arg_type_qual !20 !kernel_arg_host_accessible !21 !kernel_arg_pipe_depth !22 !kernel_arg_pipe_io !23 !kernel_arg_buffer_location !23 {
; CHECK-LLVM-LABEL: @test_pipe_query_functions
; CHECK-SPIRV-LABEL: 5 Function
; CHECK-SPIRV-NEXT:  FunctionParameter [[WOPipeTy]] [[PipeArgID:[0-9]+]]
entry:
  ; CHECK-LLVM: call{{.*}}@__get_pipe_max_packets_wo
  ; CHECK-SPIRV: GetMaxPipePackets {{[0-9]+}} {{[0-9]+}} [[PipeArgID]] {{[0-9]+}} {{[0-9]+}}
  %0 = tail call i32 @__get_pipe_max_packets_wo(%opencl.pipe_wo_t addrspace(1)* %out_pipe, i32 4, i32 4) #5
  store i32 %0, i32 addrspace(1)* %max_packets, align 4, !tbaa !35
  ; CHECK-LLVM: call{{.*}}@__get_pipe_num_packets
  ; CHECK-SPIRV: GetNumPipePackets {{[0-9]+}} {{[0-9]+}} [[PipeArgID]] {{[0-9]+}} {{[0-9]+}}
  %1 = tail call i32 @__get_pipe_num_packets_wo(%opencl.pipe_wo_t addrspace(1)* %out_pipe, i32 4, i32 4) #5
  store i32 %1, i32 addrspace(1)* %num_packets, align 4, !tbaa !35
  ret void
; CHECK-SPIRV-LABEL: 1 FunctionEnd
}

declare i32 @__get_pipe_max_packets_wo(%opencl.pipe_wo_t addrspace(1)*, i32, i32)

declare i32 @__get_pipe_num_packets_wo(%opencl.pipe_wo_t addrspace(1)*, i32, i32)

; Function Attrs: nounwind
define spir_kernel void @test_pipe_read(%opencl.pipe_ro_t addrspace(1)* %in_pipe, i32 addrspace(1)* %dst) #0 !kernel_arg_addr_space !4 !kernel_arg_access_qual !12 !kernel_arg_type !28 !kernel_arg_base_type !28 !kernel_arg_type_qual !15 !kernel_arg_host_accessible !9 !kernel_arg_pipe_depth !10 !kernel_arg_pipe_io !11 !kernel_arg_buffer_location !11 {
; CHECK-LLVM-LABEL: @test_pipe_read
; CHECK-SPIRV-LABEL: 5 Function
; CHECK-SPIRV-NEXT:  FunctionParameter [[ROPipeTy]] [[PipeArgID:[0-9]+]]
entry:
  %call = tail call spir_func i64 @_Z13get_global_idj(i32 0) #2
  ; CHECK-LLVM: call{{.*}}@__reserve_read_pipe
  ; CHECK-SPIRV: ReserveReadPipePackets {{[0-9]+}} {{[0-9]+}} [[PipeArgID]] {{[0-9]+}} {{[0-9]+}} {{[0-9]+}}
  %0 = tail call %opencl.reserve_id_t* @__reserve_read_pipe(%opencl.pipe_ro_t addrspace(1)* %in_pipe, i32 1, i32 4, i32 4) #5
  %call1 = tail call spir_func zeroext i1 @_Z19is_valid_reserve_id13ocl_reserveid(%opencl.reserve_id_t* %0) #2
  br i1 %call1, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %sext = shl i64 %call, 32
  %idxprom = ashr exact i64 %sext, 32
  %arrayidx = getelementptr inbounds i32, i32 addrspace(1)* %dst, i64 %idxprom
  %1 = bitcast i32 addrspace(1)* %arrayidx to i8 addrspace(1)*
  %2 = addrspacecast i8 addrspace(1)* %1 to i8 addrspace(4)*
  ; CHECK-LLVM: call{{.*}}@__read_pipe_4
  ; CHECK-SPIRV: ReservedReadPipe {{[0-9]+}} {{[0-9]+}} [[PipeArgID]] {{[0-9]+}} {{[0-9]+}} {{[0-9]+}} {{[0-9]+}} {{[0-9]+}}
  %3 = tail call i32 @__read_pipe_4(%opencl.pipe_ro_t addrspace(1)* %in_pipe, %opencl.reserve_id_t* %0, i32 0, i8 addrspace(4)* %2, i32 4, i32 4) #5
  ; CHECK-LLVM: call{{.*}}@__commit_read_pipe
  ; CHECK-SPIRV: CommitReadPipe [[PipeArgID]] {{[0-9]+}} {{[0-9]+}} {{[0-9]+}}
  tail call void @__commit_read_pipe(%opencl.pipe_ro_t addrspace(1)* %in_pipe, %opencl.reserve_id_t* %0, i32 4, i32 4) #5
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret void
; CHECK-SPIRV-LABEL: 1 FunctionEnd
}

declare %opencl.reserve_id_t* @__reserve_read_pipe(%opencl.pipe_ro_t addrspace(1)*, i32, i32, i32)

declare i32 @__read_pipe_4(%opencl.pipe_ro_t addrspace(1)*, %opencl.reserve_id_t*, i32, i8 addrspace(4)*, i32, i32)

declare void @__commit_read_pipe(%opencl.pipe_ro_t addrspace(1)*, %opencl.reserve_id_t*, i32, i32)

; Function Attrs: nounwind
define spir_kernel void @test_pipe_workgroup_write_char(i8 addrspace(1)* %src, %opencl.pipe_wo_t addrspace(1)* %out_pipe) #0 !kernel_arg_addr_space !4 !kernel_arg_access_qual !5 !kernel_arg_type !29 !kernel_arg_base_type !29 !kernel_arg_type_qual !8 !kernel_arg_host_accessible !9 !kernel_arg_pipe_depth !10 !kernel_arg_pipe_io !11 !kernel_arg_buffer_location !11 {
; CHECK-LLVM-LABEL: @test_pipe_workgroup_write_char
; CHECK-SPIRV-LABEL: 5 Function
; CHECK-SPIRV-NEXT:  FunctionParameter
; CHECK-SPIRV-NEXT:  FunctionParameter [[WOPipeTy]] [[PipeArgID:[0-9]+]]
entry:
  %call = tail call spir_func i64 @_Z13get_global_idj(i32 0) #2
  %call1 = tail call spir_func i64 @_Z14get_local_sizej(i32 0) #2
  %0 = trunc i64 %call1 to i32
  ; CHECK-LLVM: call{{.*}}@__work_group_reserve_write_pipe
  ; CHECK-SPIRV: GroupReserveWritePipePackets {{[0-9]+}} {{[0-9]+}} {{[0-9]+}} [[PipeArgID]] {{[0-9]+}} {{[0-9]+}} {{[0-9]+}}
  %1 = tail call %opencl.reserve_id_t* @__work_group_reserve_write_pipe(%opencl.pipe_wo_t addrspace(1)* %out_pipe, i32 %0, i32 1, i32 1) #5
  store %opencl.reserve_id_t* %1, %opencl.reserve_id_t* addrspace(3)* @test_pipe_workgroup_write_char.res_id, align 8, !tbaa !39
  %call2 = tail call spir_func zeroext i1 @_Z19is_valid_reserve_id13ocl_reserveid(%opencl.reserve_id_t* %1) #2
  br i1 %call2, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %2 = load %opencl.reserve_id_t*, %opencl.reserve_id_t* addrspace(3)* @test_pipe_workgroup_write_char.res_id, align 8, !tbaa !39
  %call3 = tail call spir_func i64 @_Z12get_local_idj(i32 0) #2
  %sext = shl i64 %call, 32
  %idxprom = ashr exact i64 %sext, 32
  %arrayidx = getelementptr inbounds i8, i8 addrspace(1)* %src, i64 %idxprom
  %3 = addrspacecast i8 addrspace(1)* %arrayidx to i8 addrspace(4)*
  %4 = trunc i64 %call3 to i32
  %5 = tail call i32 @__write_pipe_4(%opencl.pipe_wo_t addrspace(1)* %out_pipe, %opencl.reserve_id_t* %2, i32 %4, i8 addrspace(4)* %3, i32 1, i32 1) #5
  %6 = load %opencl.reserve_id_t*, %opencl.reserve_id_t* addrspace(3)* @test_pipe_workgroup_write_char.res_id, align 8, !tbaa !39
  ; CHECK-LLVM: call{{.*}}@__work_group_commit_write_pipe
  ; CHECK-SPIRV: GroupCommitWritePipe {{[0-9]+}} [[PipeArgID]] {{[0-9]+}} {{[0-9]+}} {{[0-9]+}}
  tail call void @__work_group_commit_write_pipe(%opencl.pipe_wo_t addrspace(1)* %out_pipe, %opencl.reserve_id_t* %6, i32 1, i32 1) #5
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret void
; CHECK-SPIRV-LABEL: 1 FunctionEnd
}

declare spir_func i64 @_Z14get_local_sizej(i32) #1

declare %opencl.reserve_id_t* @__work_group_reserve_write_pipe(%opencl.pipe_wo_t addrspace(1)*, i32, i32, i32)

declare spir_func i64 @_Z12get_local_idj(i32) #1

declare void @__work_group_commit_write_pipe(%opencl.pipe_wo_t addrspace(1)*, %opencl.reserve_id_t*, i32, i32)

; Function Attrs: nounwind
define spir_kernel void @test_pipe_workgroup_read_char(%opencl.pipe_ro_t addrspace(1)* %in_pipe, i8 addrspace(1)* %dst) #0 !kernel_arg_addr_space !4 !kernel_arg_access_qual !12 !kernel_arg_type !32 !kernel_arg_base_type !32 !kernel_arg_type_qual !15 !kernel_arg_host_accessible !9 !kernel_arg_pipe_depth !10 !kernel_arg_pipe_io !11 !kernel_arg_buffer_location !11 {
; CHECK-LLVM-LABEL: @test_pipe_workgroup_read_char
; CHECK-SPIRV-LABEL: 5 Function
; CHECK-SPIRV-NEXT:  FunctionParameter [[ROPipeTy]] [[PipeArgID:[0-9]+]]
entry:
  %call = tail call spir_func i64 @_Z13get_global_idj(i32 0) #2
  %call1 = tail call spir_func i64 @_Z14get_local_sizej(i32 0) #2
  %0 = trunc i64 %call1 to i32
  ; CHECK-LLVM: call{{.*}}@__work_group_reserve_read_pipe
  ; CHECK-SPIRV: GroupReserveReadPipePackets {{[0-9]+}} {{[0-9]+}} {{[0-9]+}} [[PipeArgID]] {{[0-9]+}} {{[0-9]+}} {{[0-9]+}}
  %1 = tail call %opencl.reserve_id_t* @__work_group_reserve_read_pipe(%opencl.pipe_ro_t addrspace(1)* %in_pipe, i32 %0, i32 1, i32 1) #5
  store %opencl.reserve_id_t* %1, %opencl.reserve_id_t* addrspace(3)* @test_pipe_workgroup_read_char.res_id, align 8, !tbaa !39
  %call2 = tail call spir_func zeroext i1 @_Z19is_valid_reserve_id13ocl_reserveid(%opencl.reserve_id_t* %1) #2
  br i1 %call2, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %2 = load %opencl.reserve_id_t*, %opencl.reserve_id_t* addrspace(3)* @test_pipe_workgroup_read_char.res_id, align 8, !tbaa !39
  %call3 = tail call spir_func i64 @_Z12get_local_idj(i32 0) #2
  %sext = shl i64 %call, 32
  %idxprom = ashr exact i64 %sext, 32
  %arrayidx = getelementptr inbounds i8, i8 addrspace(1)* %dst, i64 %idxprom
  %3 = addrspacecast i8 addrspace(1)* %arrayidx to i8 addrspace(4)*
  %4 = trunc i64 %call3 to i32
  %5 = tail call i32 @__read_pipe_4(%opencl.pipe_ro_t addrspace(1)* %in_pipe, %opencl.reserve_id_t* %2, i32 %4, i8 addrspace(4)* %3, i32 1, i32 1) #5
  %6 = load %opencl.reserve_id_t*, %opencl.reserve_id_t* addrspace(3)* @test_pipe_workgroup_read_char.res_id, align 8, !tbaa !39
  ; CHECK-LLVM: call{{.*}}@__work_group_commit_read_pipe
  ; CHECK-SPIRV: GroupCommitReadPipe {{[0-9]+}} [[PipeArgID]] {{[0-9]+}} {{[0-9]+}} {{[0-9]+}}
  tail call void @__work_group_commit_read_pipe(%opencl.pipe_ro_t addrspace(1)* %in_pipe, %opencl.reserve_id_t* %6, i32 1, i32 1) #5
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret void
; CHECK-SPIRV-LABEL: 1 FunctionEnd
}

declare %opencl.reserve_id_t* @__work_group_reserve_read_pipe(%opencl.pipe_ro_t addrspace(1)*, i32, i32, i32)

declare void @__work_group_commit_read_pipe(%opencl.pipe_ro_t addrspace(1)*, %opencl.reserve_id_t*, i32, i32)

; Function Attrs: nounwind
define spir_kernel void @test_pipe_subgroup_write_uint(i32 addrspace(1)* %src, %opencl.pipe_wo_t addrspace(1)* %out_pipe) #0 !kernel_arg_addr_space !4 !kernel_arg_access_qual !5 !kernel_arg_type !6 !kernel_arg_base_type !7 !kernel_arg_type_qual !8 !kernel_arg_host_accessible !9 !kernel_arg_pipe_depth !10 !kernel_arg_pipe_io !11 !kernel_arg_buffer_location !11 {
; CHECK-LLVM-LABEL: @test_pipe_subgroup_write_uint
; CHECK-SPIRV-LABEL: 5 Function
; CHECK-SPIRV-NEXT:  FunctionParameter
; CHECK-SPIRV-NEXT:  FunctionParameter [[WOPipeTy]] [[PipeArgID:[0-9]+]]
entry:
  %call = tail call spir_func i64 @_Z13get_global_idj(i32 0) #2
  %call1 = tail call spir_func i32 @_Z18get_sub_group_sizev() #2
  ; CHECK-LLVM: call{{.*}}@__sub_group_reserve_write_pipe
  ; CHECK-SPIRV: GroupReserveWritePipePackets {{[0-9]+}} {{[0-9]+}} {{[0-9]+}} [[PipeArgID]] {{[0-9]+}} {{[0-9]+}} {{[0-9]+}}
  %0 = tail call %opencl.reserve_id_t* @__sub_group_reserve_write_pipe(%opencl.pipe_wo_t addrspace(1)* %out_pipe, i32 %call1, i32 4, i32 4) #5
  %call2 = tail call spir_func zeroext i1 @_Z19is_valid_reserve_id13ocl_reserveid(%opencl.reserve_id_t* %0) #2
  br i1 %call2, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %call3 = tail call spir_func i32 @_Z22get_sub_group_local_idv() #2
  %sext = shl i64 %call, 32
  %idxprom = ashr exact i64 %sext, 32
  %arrayidx = getelementptr inbounds i32, i32 addrspace(1)* %src, i64 %idxprom
  %1 = bitcast i32 addrspace(1)* %arrayidx to i8 addrspace(1)*
  %2 = addrspacecast i8 addrspace(1)* %1 to i8 addrspace(4)*
  %3 = tail call i32 @__write_pipe_4(%opencl.pipe_wo_t addrspace(1)* %out_pipe, %opencl.reserve_id_t* %0, i32 %call3, i8 addrspace(4)* %2, i32 4, i32 4) #5
  ; CHECK-LLVM: call{{.*}}@__sub_group_commit_write_pipe
  ; CHECK-SPIRV: GroupCommitWritePipe {{[0-9]+}} [[PipeArgID]] {{[0-9]+}} {{[0-9]+}} {{[0-9]+}}
  tail call void @__sub_group_commit_write_pipe(%opencl.pipe_wo_t addrspace(1)* %out_pipe, %opencl.reserve_id_t* %0, i32 4, i32 4) #5
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret void
; CHECK-SPIRV-LABEL: 1 FunctionEnd
}

declare spir_func i32 @_Z18get_sub_group_sizev() #1

declare %opencl.reserve_id_t* @__sub_group_reserve_write_pipe(%opencl.pipe_wo_t addrspace(1)*, i32, i32, i32)

declare spir_func i32 @_Z22get_sub_group_local_idv() #1

declare void @__sub_group_commit_write_pipe(%opencl.pipe_wo_t addrspace(1)*, %opencl.reserve_id_t*, i32, i32)


define spir_kernel void @test_pipe_subgroup_read_uint(%opencl.pipe_ro_t addrspace(1)* %in_pipe, i32 addrspace(1)* %dst) #0 !kernel_arg_addr_space !4 !kernel_arg_access_qual !12 !kernel_arg_type !13 !kernel_arg_base_type !14 !kernel_arg_type_qual !15 !kernel_arg_host_accessible !9 !kernel_arg_pipe_depth !10 !kernel_arg_pipe_io !11 !kernel_arg_buffer_location !11 {
; Function Attrs: nounwind
; CHECK-LLVM-LABEL: @test_pipe_subgroup_read_uint
; CHECK-SPIRV-LABEL: 5 Function
; CHECK-SPIRV-NEXT:  FunctionParameter [[ROPipeTy]] [[PipeArgID:[0-9]+]]
entry:
  %call = tail call spir_func i64 @_Z13get_global_idj(i32 0) #2
  %call1 = tail call spir_func i32 @_Z18get_sub_group_sizev() #2
  ; CHECK-LLVM: call{{.*}}@__sub_group_reserve_read_pipe
  ; CHECK-SPIRV: GroupReserveReadPipePackets {{[0-9]+}} {{[0-9]+}} {{[0-9]+}} [[PipeArgID]] {{[0-9]+}} {{[0-9]+}} {{[0-9]+}}
  %0 = tail call %opencl.reserve_id_t* @__sub_group_reserve_read_pipe(%opencl.pipe_ro_t addrspace(1)* %in_pipe, i32 %call1, i32 4, i32 4) #5
  %call2 = tail call spir_func zeroext i1 @_Z19is_valid_reserve_id13ocl_reserveid(%opencl.reserve_id_t* %0) #2
  br i1 %call2, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %call3 = tail call spir_func i32 @_Z22get_sub_group_local_idv() #2
  %sext = shl i64 %call, 32
  %idxprom = ashr exact i64 %sext, 32
  %arrayidx = getelementptr inbounds i32, i32 addrspace(1)* %dst, i64 %idxprom
  %1 = bitcast i32 addrspace(1)* %arrayidx to i8 addrspace(1)*
  %2 = addrspacecast i8 addrspace(1)* %1 to i8 addrspace(4)*
  %3 = tail call i32 @__read_pipe_4(%opencl.pipe_ro_t addrspace(1)* %in_pipe, %opencl.reserve_id_t* %0, i32 %call3, i8 addrspace(4)* %2, i32 4, i32 4) #5
  ; CHECK-LLVM: call{{.*}}@__sub_group_commit_read_pipe
  ; CHECK-SPIRV: GroupCommitReadPipe {{[0-9]+}} [[PipeArgID]] {{[0-9]+}} {{[0-9]+}} {{[0-9]+}}
  tail call void @__sub_group_commit_read_pipe(%opencl.pipe_ro_t addrspace(1)* %in_pipe, %opencl.reserve_id_t* %0, i32 4, i32 4) #5
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret void
; CHECK-SPIRV-LABEL: 1 FunctionEnd
}

declare %opencl.reserve_id_t* @__sub_group_reserve_read_pipe(%opencl.pipe_ro_t addrspace(1)*, i32, i32, i32)

declare void @__sub_group_commit_read_pipe(%opencl.pipe_ro_t addrspace(1)*, %opencl.reserve_id_t*, i32, i32)

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-realign-stack" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-realign-stack" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0, !6, !11, !14, !20, !23, !26, !29, !30}
!opencl.enable.FP_CONTRACT = !{}
!opencl.spir.version = !{!31}
!opencl.ocl.version = !{!32}
!opencl.used.extensions = !{!33}
!opencl.used.optional.core.features = !{!33}
!opencl.compiler.options = !{!33}

!0 = !{void (i32 addrspace(1)*, %opencl.pipe_wo_t addrspace(1)*)* @test_pipe_convenience_write_uint, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 1, i32 1}
!2 = !{!"kernel_arg_access_qual", !"none", !"write_only"}
!3 = !{!"kernel_arg_type", !"uint*", !"uint"}
!4 = !{!"kernel_arg_base_type", !"uint*", !"uint"}
!5 = !{!"kernel_arg_type_qual", !"", !"pipe"}
!6 = !{void (%opencl.pipe_ro_t addrspace(1)*, i32 addrspace(1)*)* @test_pipe_convenience_read_uint, !1, !7, !8, !9, !10}
!7 = !{!"kernel_arg_access_qual", !"read_only", !"none"}
!8 = !{!"kernel_arg_type", !"uint", !"uint*"}
!9 = !{!"kernel_arg_base_type", !"uint", !"uint*"}
!10 = !{!"kernel_arg_type_qual", !"pipe", !""}
!11 = !{void (i32 addrspace(1)*, %opencl.pipe_wo_t addrspace(1)*)* @test_pipe_write, !1, !2, !12, !13, !5}
!12 = !{!"kernel_arg_type", !"int*", !"int"}
!13 = !{!"kernel_arg_base_type", !"int*", !"int"}
!14 = !{void (%opencl.pipe_wo_t addrspace(1)*, i32 addrspace(1)*, i32 addrspace(1)*)* @test_pipe_query_functions, !15, !16, !17, !18, !19}
!15 = !{!"kernel_arg_addr_space", i32 1, i32 1, i32 1}
!16 = !{!"kernel_arg_access_qual", !"write_only", !"none", !"none"}
!17 = !{!"kernel_arg_type", !"int", !"int*", !"int*"}
!18 = !{!"kernel_arg_base_type", !"int", !"int*", !"int*"}
!19 = !{!"kernel_arg_type_qual", !"pipe", !"", !""}
!20 = !{void (%opencl.pipe_ro_t addrspace(1)*, i32 addrspace(1)*)* @test_pipe_read, !1, !7, !21, !22, !10}
!21 = !{!"kernel_arg_type", !"int", !"int*"}
!22 = !{!"kernel_arg_base_type", !"int", !"int*"}
!23 = !{void (i8 addrspace(1)*, %opencl.pipe_wo_t addrspace(1)*)* @test_pipe_workgroup_write_char, !1, !2, !24, !25, !5}
!24 = !{!"kernel_arg_type", !"char*", !"char"}
!25 = !{!"kernel_arg_base_type", !"char*", !"char"}
!26 = !{void (%opencl.pipe_ro_t addrspace(1)*, i8 addrspace(1)*)* @test_pipe_workgroup_read_char, !1, !7, !27, !28, !10}
!27 = !{!"kernel_arg_type", !"char", !"char*"}
!28 = !{!"kernel_arg_base_type", !"char", !"char*"}
!29 = !{void (i32 addrspace(1)*, %opencl.pipe_wo_t addrspace(1)*)* @test_pipe_subgroup_write_uint, !1, !2, !3, !4, !5}
!30 = !{void (%opencl.pipe_ro_t addrspace(1)*, i32 addrspace(1)*)* @test_pipe_subgroup_read_uint, !1, !7, !8, !9, !10}
!31 = !{i32 1, i32 2}
!32 = !{i32 2, i32 0}
!33 = !{}
!35 = !{!36, !36, i64 0}
!36 = !{!"int", !37, i64 0}
!37 = !{!"omnipotent char", !38, i64 0}
!38 = !{!"Simple C/C++ TBAA"}
!39 = !{!40, !40, i64 0}
!40 = !{!"reserve_id_t", !37, i64 0}
