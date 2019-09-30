; ModuleID = './dut/float/dut_float.c'
source_filename = "./dut/float/dut_float.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@chunk_size = dso_local constant i64 16, align 8
@number_measurements = dso_local constant i64 1000000, align 8
@__const.do_one_computation.secret = private unnamed_addr constant [16 x double] [double 0x3FE66AE92390E143, double 0x3FCD9662CFB2C760, double 0x3FE2884492EA2770, double 0x3FD3C42999E8E218, double 0x3FD461B083434852, double 0x3FB19299B668C9E0, double 0x3FE0D2994874CD8D, double 0x3F970F8A00450920, double 0x3FEA7937857F810C, double 0x3FE1E206FB8B90DF, double 0x3FD80073E5A0E360, double 0x3FE322A72B35B79A, double 0x3FE5F0AB21E24EF5, double 0x3FE92AC07A2839F3, double 0x3FD7C8B21E74B54A, double 0x3FE695E3B5EF7391], align 16

; Function Attrs: noinline nounwind optnone uwtable
define dso_local double @do_one_computation(i8* %data) #0 {
entry:
  %data.addr = alloca i8*, align 8
  %sum = alloca double, align 8
  %secret = alloca [16 x double], align 16
  %i = alloca i64, align 8
  store i8* %data, i8** %data.addr, align 8
  store double 0.000000e+00, double* %sum, align 8
  %0 = bitcast [16 x double]* %secret to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %0, i8* align 16 bitcast ([16 x double]* @__const.do_one_computation.secret to i8*), i64 128, i1 false)
  store i64 0, i64* %i, align 8
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %1 = load i64, i64* %i, align 8
  %cmp = icmp ult i64 %1, 16
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %2 = load i64, i64* %i, align 8
  %arrayidx = getelementptr inbounds [16 x double], [16 x double]* %secret, i64 0, i64 %2
  %3 = load double, double* %arrayidx, align 8
  %4 = load i8*, i8** %data.addr, align 8
  %5 = load i64, i64* %i, align 8
  %arrayidx1 = getelementptr inbounds i8, i8* %4, i64 %5
  %6 = load i8, i8* %arrayidx1, align 1
  %conv = zext i8 %6 to i32
  %conv2 = sitofp i32 %conv to double
  %mul = fmul double %3, %conv2
  %7 = load i64, i64* %i, align 8
  %arrayidx3 = getelementptr inbounds [16 x double], [16 x double]* %secret, i64 0, i64 %7
  store double %mul, double* %arrayidx3, align 8
  %8 = load i64, i64* %i, align 8
  %arrayidx4 = getelementptr inbounds [16 x double], [16 x double]* %secret, i64 0, i64 %8
  %9 = load double, double* %arrayidx4, align 8
  %cmp5 = fcmp une double %9, 0.000000e+00
  br i1 %cmp5, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %10 = load i64, i64* %i, align 8
  %arrayidx7 = getelementptr inbounds [16 x double], [16 x double]* %secret, i64 0, i64 %10
  %11 = load double, double* %arrayidx7, align 8
  %12 = load double, double* %sum, align 8
  %add = fadd double %12, %11
  store double %add, double* %sum, align 8
  br label %if.end

if.else:                                          ; preds = %for.body
  %13 = load i64, i64* %i, align 8
  %arrayidx8 = getelementptr inbounds [16 x double], [16 x double]* %secret, i64 0, i64 %13
  %14 = load double, double* %arrayidx8, align 8
  %15 = load double, double* %sum, align 8
  %add9 = fadd double %15, %14
  store double %add9, double* %sum, align 8
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %16 = load i64, i64* %i, align 8
  %inc = add i64 %16, 1
  store i64 %inc, i64* %i, align 8
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %17 = load double, double* %sum, align 8
  ret double %17
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i1) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @init_dut() #0 {
entry:
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @prepare_inputs(i8* %input_data, i8* %classes) #0 {
entry:
  %input_data.addr = alloca i8*, align 8
  %classes.addr = alloca i8*, align 8
  %i = alloca i64, align 8
  store i8* %input_data, i8** %input_data.addr, align 8
  store i8* %classes, i8** %classes.addr, align 8
  %0 = load i8*, i8** %input_data.addr, align 8
  call void @randombytes(i8* %0, i64 16000000)
  store i64 0, i64* %i, align 8
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %1 = load i64, i64* %i, align 8
  %cmp = icmp ult i64 %1, 1000000
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %call = call zeroext i8 @randombit()
  %2 = load i8*, i8** %classes.addr, align 8
  %3 = load i64, i64* %i, align 8
  %arrayidx = getelementptr inbounds i8, i8* %2, i64 %3
  store i8 %call, i8* %arrayidx, align 1
  %4 = load i8*, i8** %classes.addr, align 8
  %5 = load i64, i64* %i, align 8
  %arrayidx1 = getelementptr inbounds i8, i8* %4, i64 %5
  %6 = load i8, i8* %arrayidx1, align 1
  %conv = zext i8 %6 to i32
  %cmp2 = icmp eq i32 %conv, 0
  br i1 %cmp2, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %7 = load i8*, i8** %input_data.addr, align 8
  %8 = load i64, i64* %i, align 8
  %mul = mul i64 %8, 16
  %add.ptr = getelementptr inbounds i8, i8* %7, i64 %mul
  call void @llvm.memset.p0i8.i64(i8* align 1 %add.ptr, i8 0, i64 16, i1 false)
  br label %if.end

if.else:                                          ; preds = %for.body
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %9 = load i64, i64* %i, align 8
  %inc = add i64 %9, 1
  store i64 %inc, i64* %i, align 8
  br label %for.cond

for.end:                                          ; preds = %for.cond
  ret void
}

declare dso_local void @randombytes(i8*, i64) #2

declare dso_local zeroext i8 @randombit() #2

; Function Attrs: argmemonly nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1) #1

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 8.0.0 (tags/RELEASE_800/final)"}
