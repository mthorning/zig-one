const std = @import("std");

pub fn include() void {}

fn loopAndSwitch() void {
    // Fill an array using a for loop over a range
    var arr: [9]usize = undefined;
    for (0..9) |i| {
        arr[i] = i + 1;
    }

    for (arr) |el| {
        switch (el) {
            1, 2 => std.debug.print(", 1 or 2", .{}),
            // switch range uses 3 dots but a range (above) only uses 2
            // because switch ranges are inclusive of both ends of range
            // wheras a normal range excludes the upper bound.
            3...5 => std.debug.print(", 3-5", .{}),
            6 => std.debug.print(", 6", .{}),
            else => if (el % 2 == 0) std.debug.print(", must be 8", .{}) else std.debug.print(", 7 or 9", .{}),
        }
    }
    std.debug.print("\n", .{});
}

fn whileLoop() void {
    var i: usize = 1;
    // You can add the iterator here instead of
    // in the body of the while
    while (i <= 10) : (i += 1) {
        if (i % 2 == 0) {
            std.debug.print(" {d}", .{i});
        }
    }
    std.debug.print("\n", .{});
}

// Break and continue can target labelled loops:
fn labelsExample() void {
    outer: for (1..10) |i| {
        for (i..10) |j| {
            if (i * j > (i + i + j + j)) continue :outer; // will continue the outer loop
            std.debug.print("{d} + {d} >= {d} * {d}\n", .{ i + i, j + j, i, j });
        }
    }
}

// TODO: fix this!
// Break can be used to return a value from a block kindof like a switch:
// pub fn breakRtnValue(tea_vote: usize, coffee_vote: usize) void {
//     const personality_analysis = blk: {
//         if (tea_vote > coffee_vote) break :blk "sane";
//         if (tea_vote == coffee_vote) break :blk "whatever";
//         if (tea_vote < coffee_vote) break :blk "dangerous";
//     };
//     std.debug.print("{s}", .{personality_analysis});
// }

// TODO: make generic
fn indexOf(haystack: []const u32, needle: u32) ?usize {

    // to get index you pass a range as second arg to for:
    for (haystack, 0..) |el, i| {
        if (el == needle) return i;
    }
    return null;
}

test indexOf {
    const haystack = [_]u32{ 1, 2, 3 };
    try std.testing.expect(indexOf(&haystack, 2) == 1);
}
