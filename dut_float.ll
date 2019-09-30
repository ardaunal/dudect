; ModuleID = './dut/float/dut_float.c'
source_filename = "./dut/float/dut_float.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@chunk_size = dso_local local_unnamed_addr constant i64 16, align 8
@number_measurements = dso_local local_unnamed_addr constant i64 1000000, align 8
@__const.do_one_computation.secret = private unnamed_addr constant [16 x double] [double 0x3FE66AE92390E143, double 0x3FCD9662CFB2C760, double 0x3FE2884492EA2770, double 0x3FD3C42999E8E218, double 0x3FD461B083434852, double 0x3FB19299B668C9E0, double 0x3FE0D2994874CD8D, double 0x3F970F8A00450920, double 0x3FEA7937857F810C, double 0x3FE1E206FB8B90DF, double 0x3FD80073E5A0E360, double 0x3FE322A72B35B79A, double 0x3FE5F0AB21E24EF5, double 0x3FE92AC07A2839F3, double 0x3FD7C8B21E74B54A, double 0x3FE695E3B5EF7391], align 16

; Function Attrs: nounwind readonly uwtable
define dso_local double @do_one_computation(i8* nocapture readonly %data) local_unnamed_addr #0 {
entry:
  %secret = alloca [16 x double], align 16
  %0 = bitcast [16 x double]* %secret to i8*
  call void @llvm.lifetime.start.p0i8(i64 128, i8* nonnull %0) #5
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 16 %0, i8* align 16 bitcast ([16 x double]* @__const.do_one_computation.secret to i8*), i64 128, i1 false)
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.body
  call void @llvm.lifetime.end.p0i8(i64 128, i8* nonnull %0) #5
  ret double %sum.1.1

for.body:                                         ; preds = %for.body, %entry
  %i.019 = phi i64 [ 0, %entry ], [ %inc.1, %for.body ]
  %sum.018 = phi double [ 0.000000e+00, %entry ], [ %sum.1.1, %for.body ]
  %arrayidx = getelementptr inbounds [16 x double], [16 x double]* %secret, i64 0, i64 %i.019
  %1 = load double, double* %arrayidx, align 16, !tbaa !2
  %arrayidx1 = getelementptr inbounds i8, i8* %data, i64 %i.019
  %2 = load i8, i8* %arrayidx1, align 1, !tbaa !6
  %conv2 = uitofp i8 %2 to double
  %mul = fmul double %1, %conv2
  store double %mul, double* %arrayidx, align 16, !tbaa !2
  %cmp5 = fcmp une double %mul, 0.000000e+00
  %3 = fsub double -0.000000e+00, %mul
  %sum.1.p = select i1 %cmp5, double %mul, double %3
  %sum.1 = fadd double %sum.018, %sum.1.p
  %inc = or i64 %i.019, 1
  %arrayidx.1 = getelementptr inbounds [16 x double], [16 x double]* %secret, i64 0, i64 %inc
  %4 = load double, double* %arrayidx.1, align 8, !tbaa !2
  %arrayidx1.1 = getelementptr inbounds i8, i8* %data, i64 %inc
  %5 = load i8, i8* %arrayidx1.1, align 1, !tbaa !6
  %conv2.1 = uitofp i8 %5 to double
  %mul.1 = fmul double %4, %conv2.1
  store double %mul.1, double* %arrayidx.1, align 8, !tbaa !2
  %cmp5.1 = fcmp une double %mul.1, 0.000000e+00
  %6 = fsub double -0.000000e+00, %mul.1
  %sum.1.p.1 = select i1 %cmp5.1, double %mul.1, double %6
  %sum.1.1 = fadd double %sum.1, %sum.1.p.1
  %inc.1 = add nuw nsw i64 %i.019, 2
  %exitcond.1 = icmp eq i64 %inc.1, 16
  br i1 %exitcond.1, label %for.cond.cleanup, label %for.body
}

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.start.p0i8(i64, i8* nocapture) #1

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i1) #1

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.end.p0i8(i64, i8* nocapture) #1

; Function Attrs: norecurse nounwind readnone uwtable
define dso_local void @init_dut() local_unnamed_addr #2 {
entry:
  ret void
}

; Function Attrs: nounwind uwtable
define dso_local void @prepare_inputs(i8* %input_data, i8* nocapture %classes) local_unnamed_addr #3 {
entry:
  tail call void @randombytes(i8* %input_data, i64 16000000) #5
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.inc
  ret void

for.body:                                         ; preds = %for.inc, %entry
  %i.011 = phi i64 [ 0, %entry ], [ %inc, %for.inc ]
  %call = tail call zeroext i8 @randombit() #5
  %arrayidx = getelementptr inbounds i8, i8* %classes, i64 %i.011
  store i8 %call, i8* %arrayidx, align 1, !tbaa !6
  %cmp2 = icmp eq i8 %call, 0
  br i1 %cmp2, label %if.then, label %for.inc

if.then:                                          ; preds = %for.body
  %mul = shl i64 %i.011, 4
  %add.ptr = getelementptr inbounds i8, i8* %input_data, i64 %mul
  tail call void @llvm.memset.p0i8.i64(i8* align 1 %add.ptr, i8 0, i64 16, i1 false)
  br label %for.inc

for.inc:                                          ; preds = %if.then, %for.body
  %inc = add nuw nsw i64 %i.011, 1
  %exitcond = icmp eq i64 %inc, 1000000
  br i1 %exitcond, label %for.cond.cleanup, label %for.body
}

declare dso_local void @randombytes(i8*, i64) local_unnamed_addr #4

declare dso_local zeroext i8 @randombit() local_unnamed_addr #4

; Function Attrs: argmemonly nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1) #1

attributes #0 = { nounwind readonly uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind }
attributes #2 = { norecurse nounwind readnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 8.0.0 (tags/RELEASE_800/final)"}
!2 = !{!3, !3, i64 0}
!3 = !{!"double", !4, i64 0}
!4 = !{!"omnipotent char", !5, i64 0}
!5 = !{!"Simple C/C++ TBAA"}
!6 = !{!4, !4, i64 0}
