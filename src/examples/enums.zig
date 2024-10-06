const std = @import("std");

// Very similar to structs
pub const Stage = enum {
    validate,
    awaiting_confirmation,
    confirmed,
    err,

    // Enums can have functions
    fn isComplete(self: Stage) bool {
        // can use . instead of Stage as it is inferred from type
        return self == .confirmed or self == .err;
    }

    pub fn printTagName(self: Stage) void {
        const tag_name = @tagName(self);
        std.debug.print("This enum is {s}\n", .{tag_name});
    }
};
