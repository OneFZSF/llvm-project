; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve < %s 2>%t | FileCheck %s
; RUN: FileCheck --check-prefix=WARN --allow-empty %s <%t

; If this check fails please read test/CodeGen/AArch64/README for instructions on how to resolve it.
; WARN-NOT: warning

;
; PTEST
;

define i1 @ptest_any(<vscale x 16 x i1> %pg, <vscale x 16 x i1> %a) {
; CHECK-LABEL: ptest_any:
; CHECK: ptest p0, p1.b
; CHECK-NEXT: cset w0, ne
; CHECK-NEXT: ret
  %out = call i1 @llvm.aarch64.sve.ptest.any(<vscale x 16 x i1> %pg, <vscale x 16 x i1> %a)
  ret i1 %out
}

define i1 @ptest_first(<vscale x 16 x i1> %pg, <vscale x 16 x i1> %a) {
; CHECK-LABEL: ptest_first:
; CHECK: ptest p0, p1.b
; CHECK-NEXT: cset w0, mi
; CHECK-NEXT: ret
  %out = call i1 @llvm.aarch64.sve.ptest.first(<vscale x 16 x i1> %pg, <vscale x 16 x i1> %a)
  ret i1 %out
}

define i1 @ptest_last(<vscale x 16 x i1> %pg, <vscale x 16 x i1> %a) {
; CHECK-LABEL: ptest_last:
; CHECK: ptest p0, p1.b
; CHECK-NEXT: cset w0, lo
; CHECK-NEXT: ret
  %out = call i1 @llvm.aarch64.sve.ptest.last(<vscale x 16 x i1> %pg, <vscale x 16 x i1> %a)
  ret i1 %out
}

declare i1 @llvm.aarch64.sve.ptest.any(<vscale x 16 x i1> %pg, <vscale x 16 x i1> %a)
declare i1 @llvm.aarch64.sve.ptest.first(<vscale x 16 x i1> %pg, <vscale x 16 x i1> %a)
declare i1 @llvm.aarch64.sve.ptest.last(<vscale x 16 x i1> %pg, <vscale x 16 x i1> %a)
