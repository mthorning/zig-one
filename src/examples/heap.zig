const std = @import("std");
const Allocator = std.mem.Allocator;

pub fn include() void {}

fn allocateMemory() !void {

    // Notice PascalCase - GeneralPurposeAllocator returns a (struct) type.
    // This line is the same as:
    //   const T = std.heap.GeneralPurposeAllocator(.{});
    //   var gpa = T{};
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    // alloc/free allocates an array in memory, for single items use create/destory
    var arr = try allocator.alloc(usize, try getRandomCount());
    defer allocator.free(arr);

    for (0..arr.len) |i| {
        arr[i] = i;
    }
    std.debug.print("{any}\n", .{arr});
}

fn getRandomCount() !u8 {
    var seed: u64 = undefined;
    try std.posix.getrandom(std.mem.asBytes(&seed));
    var random = std.Random.DefaultPrng.init(seed);
    return random.random().uintAtMost(u8, 5) + 5;
}

fn toLowerCase(allocator: Allocator, str: []const u8) ![]const u8 {
    // Notice that memory is allocated here but will need to be freed
    // by the caller
    var result = try allocator.alloc(u8, str.len);

    for (str, 0..) |c, i| {
        result[i] = switch (c) {
            'A'...'Z' => c + 32,
            else => c,
        };
    }
    return result;
}

test toLowerCase {
    const allocator = std.testing.allocator;

    const result_one = try toLowerCase(allocator, "HeLLo");
    defer allocator.free(result_one);
    try std.testing.expectEqualSlices(u8, result_one, "hello");

    const result_two = try toLowerCase(allocator, "AaZz");
    defer allocator.free(result_two);
    try std.testing.expectEqualSlices(u8, result_two, "aazz");
}

fn toUpperCase(allocator: Allocator, str: []const u8) ![]const u8 {
    // Notice that memory is allocated here but will need to be freed
    // by the caller
    var result = try allocator.alloc(u8, str.len);

    for (str, 0..) |c, i| {
        result[i] = switch (c) {
            'a'...'z' => c - 32,
            else => c,
        };
    }
    return result;
}

test toUpperCase {
    const allocator = std.testing.allocator;

    const result_one = try toUpperCase(allocator, "AaZz");
    defer allocator.free(result_one);

    try std.testing.expectEqualSlices(u8, result_one, "AAZZ");
}

const HeapUser = struct {
    power: i32,
    allocator: std.mem.Allocator,

    fn init(allocator: std.mem.Allocator, power: i32) !*HeapUser {
        const user = try allocator.create(HeapUser);
        user.* = .{ .power = power, .allocator = allocator };
        return user;
    }

    fn explain(self: *HeapUser) ![]const u8 {
        return std.fmt.allocPrint(self.allocator, "Power is {d}", .{self.power});
    }
};

test "HeapUser" {
    const allocator = std.testing.allocator;

    const heap_user = try HeapUser.init(allocator, 100);
    defer allocator.destroy(heap_user);
    try std.testing.expectEqual(heap_user.power, 100);

    const explanation = try heap_user.explain();
    defer allocator.free(explanation);
    try std.testing.expectEqualSlices(u8, explanation, "Power is 100");
}
