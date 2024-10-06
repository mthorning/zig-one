const std = @import("std");

pub fn optional() void {
    const name: ?[]const u8 = "Leto";
    // .? is used to access the value behind the optional type:
    std.debug.print("{s}\n", .{name.?});

    const home: ?[]const u8 = null;
    // But we'll get a runtime panic if we use .? on a null.
    // An if statement can safely unwrap an optional:
    if (home) |h| {
        std.debug.print("Home: {s}\n", .{h});
    } else {
        std.debug.print("No home\n");
    }
    // or can use orelse
    const h = home orelse return;
    std.debug.print("Home: {s}\n", .{h});
}
