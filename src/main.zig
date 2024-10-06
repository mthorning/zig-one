const std = @import("std");

const user = @import("examples/struct.zig").include;
const loops = @import("examples/loop-and-switch.zig").include;
const heap = @import("examples/heap.zig").include;
const stringCompare = @import("examples/string-compare.zig").include;
const timestampUnion = @import("examples/tagged-unions.zig").include;
const pointer = @import("examples/pointers.zig").include;

// This is required so that tests in example files are
// built and run
test {
    std.testing.refAllDecls(@This());
}

// It's also important that a function from the same
// module is run so that the build file compiles them
// and runs the tests. Here we'll just call an empty fn
// in each (called `include`):
fn includeAllTests() void {
    user();
    loops();
    heap();
    stringCompare();
    timestampUnion();
    pointer();
}

pub fn main() !void {
    includeAllTests();
}
