const std = @import("std");

pub fn include() void {}

// TODO:
// - Use a ternary and string concatenation to reduce duplication
// - Make fn generic
fn stringCompare(a: []const u8, b: []const u8) bool {
    if (std.mem.eql(u8, a, b)) {
        return true;
    } else return false;
}

test stringCompare {
    try std.testing.expect(stringCompare("Hello", "Hello"));
    try std.testing.expect(!stringCompare("World", "Hello"));
}

// This is a simplified version of std.mem.eql:
fn eql(comptime T: type, a: []const T, b: []const T) bool {
    // if they arent' the same length, the can't be equal
    if (a.len != b.len) return false;

    // for loops can iterate over multiple sources
    //  if they're the same length
    for (a, b) |a_elem, b_elem| {
        if (a_elem != b_elem) return false;
    }

    return true;
}

test eql {
    try std.testing.expect(eql(u8, "Hello", "Hello"));
    try std.testing.expect(!eql(u8, "World", "Hello"));
    try std.testing.expect(!eql(u8, "World", "Hellos"));
}

fn contains(haystack: []const u8, needle: []const u8) bool {
    outer: for (0..haystack.len) |i| {
        for (0..needle.len) |j| {
            if (haystack[i + j] != needle[j]) continue :outer;
        }
        return true;
    }
    return false;
}

test contains {
    try std.testing.expect(contains("Hello World", "llo W"));
    try std.testing.expect(!contains("Hello World", "Globe"));
}
