const std = @import("std");

pub fn logType() void {
    const hello = "hello";

    // Strings are pointers to null terminated arrays.
    // The syntax is like: [LENGTH:SENTINAL]
    // https://www.openmymind.net/learning_zig/language_overview_1/
    std.debug.print("hello is  type {any}\n", .{@TypeOf(hello)});

    // They can be cooerced.
    // when talking about strings, we usually mean a []const u8
    const world: []const u8 = "world";

    std.debug.print("world is type {any}\n", .{@TypeOf(world)});
}
