//===----- SemaMOS.h --------- MOS target-specific routines ---*- C++ -*---===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
/// \file
/// This file declares semantic analysis functions specific to MOS.
///
//===----------------------------------------------------------------------===//

#ifndef LLVM_CLANG_SEMA_SEMAMOS_H
#define LLVM_CLANG_SEMA_SEMAMOS_H

#include "clang/AST/DeclBase.h"
#include "clang/Sema/SemaBase.h"

namespace clang {
class ParsedAttr;

class SemaMOS : public SemaBase {
public:
  SemaMOS(Sema &S);

  void handleInterruptAttr(Decl *D, const ParsedAttr &AL);
  void handleInterruptNorecurseAttr(Decl *D, const ParsedAttr &AL);
  void handleInterruptNoISRAttr(Decl *D, const ParsedAttr &AL);
};

} // namespace clang

#endif // LLVM_CLANG_SEMA_SEMAMOS_H
