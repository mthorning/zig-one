const std = @import("std");

pub fn include() void {}

fn List(comptime T: type) type {
    return struct {
        pos: usize,
        items: []T,
        allocator: std.mem.Allocator,

        fn init(allocator: std.mem.Allocator, length: usize) !List(T) {
            return .{
                .pos = 0,
                .allocator = allocator,
                .items = try allocator.alloc(T, length),
            };
        }
    };
}

test List {
    const expected = [_]u64{ 1, 10, 100 };

    const allocator = std.testing.allocator;
    var arr = try List(u64).init(allocator, expected.len);
    defer allocator.free(arr.items);

    for (0..expected.len) |i| {
        std.debug.print("{any}", .{expected[i]});
        arr.items[i] = expected[i];
    }

    try std.testing.expectEqualSlices(u64, &expected, arr.items);
}
