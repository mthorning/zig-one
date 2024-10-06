const std = @import("std");

fn getArray() [5]i32 {
    // we already saw this .{...} syntax with structs
    // it works with arrays too
    var a: [5]i32 = .{ 1, 2, 3, 4, 5 };

    // Or you can use the array literal syntax
    a = [5]i32{ 1, 2, 3, 4, 5 };

    // use _ to let the compiler infer the length
    a = [_]i32{ 1, 2, 3, 4, 5 };

    return a;
}

// TODO:
// - Pass in a pointer to an array to slice into
// - Loops over the slice and print every element
fn printSlice(start: usize, end: usize) void {
    const arr = getArray();
    const slice = arr[start..end];
    std.debug.print("Slice is {any}\n", .{slice});
}
