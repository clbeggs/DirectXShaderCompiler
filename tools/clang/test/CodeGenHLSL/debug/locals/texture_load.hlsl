// RUN: %dxc -E main -T ps_6_0 -Zi %s | FileCheck %s

// Test that the debug information for the result of a texture load
// is preserved after scalarization and optims.

// CHECK: call %dx.types.ResRet.f32 @dx.op.textureLoad.f32
// CHECK: extractvalue %dx.types.ResRet.f32
// CHECK: call void @llvm.dbg.value
// CHECK: extractvalue %dx.types.ResRet.f32
// CHECK: call void @llvm.dbg.value
// CHECK: extractvalue %dx.types.ResRet.f32
// CHECK: call void @llvm.dbg.value
// CHECK: extractvalue %dx.types.ResRet.f32
// CHECK: call void @llvm.dbg.value
// CHECK: call void @dx.op.storeOutput.f32
// CHECK: call void @dx.op.storeOutput.f32
// CHECK: call void @dx.op.storeOutput.f32
// CHECK: call void @dx.op.storeOutput.f32

// Exclude quoted source file (see readme)
// CHECK: {{!"[^"]*\\0A[^"]*"}}

// CHECK: !DIExpression(DW_OP_bit_piece, 0, 32)
// CHECK: !DIExpression(DW_OP_bit_piece, 32, 32)
// CHECK: !DIExpression(DW_OP_bit_piece, 64, 32)
// CHECK: !DIExpression(DW_OP_bit_piece, 96, 32)

Texture1D<float4> tex;
float4 main() : SV_Target
{
    float4 texel = tex.Load(0);
    return texel;
}
