//! Classifies Zig types for the MOS 6502 C ABI (llvm-mos calling convention).
//!
//! The llvm-mos C ABI passes arguments byte-by-byte through A, X, then RC2-RC15
//! for scalars/pointers, and RS1-RS7 for 16-bit pointers. Aggregates:
//!   ≤ 32 bits (4 bytes): decomposed into scalar registers (byval)
//!   >  32 bits          : passed via hidden pointer (indirect/sret)
//!
//! Reference: clang/lib/CodeGen/Targets/MOS.cpp MOSABIInfo
//!            mos-research-ai docs/02-mos-abi.md, docs/11-byval-and-scalar-abi.md

const std = @import("std");
const Type = @import("../../Type.zig");
const Zcu = @import("../../Zcu.zig");
const assert = std.debug.assert;

pub const Class = enum {
    byval,
    indirect,
};

pub fn classifyType(ty: Type, zcu: *Zcu) Class {
    assert(ty.hasRuntimeBits(zcu));
    switch (ty.zigTypeTag(zcu)) {
        .@"struct" => {
            if (ty.containerLayout(zcu) == .@"packed") return .byval;
            if (ty.bitSize(zcu) > 32) return .indirect;
            return .byval;
        },
        .@"union" => {
            if (ty.containerLayout(zcu) == .@"packed") return .byval;
            if (ty.bitSize(zcu) > 32) return .indirect;
            return .byval;
        },
        .int,
        .@"enum",
        .error_set,
        .float,
        .bool,
        => return .byval,
        .vector => {
            if (ty.bitSize(zcu) > 32) return .indirect;
            return .byval;
        },
        .optional => {
            assert(ty.isPtrLikeOptional(zcu));
            return .byval;
        },
        .pointer => {
            assert(!ty.isSlice(zcu));
            return .byval;
        },
        .error_union,
        .frame,
        .@"anyframe",
        .noreturn,
        .void,
        .type,
        .comptime_float,
        .comptime_int,
        .undefined,
        .null,
        .@"fn",
        .@"opaque",
        .enum_literal,
        .array,
        => unreachable,
    }
}
