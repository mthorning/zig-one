const std = @import("std");

pub fn include() void {}

// TODO: Change age to dob and calculate age
pub const User = struct {
    name: []const u8,
    age: u32,

    pub fn init(name: []const u8, age: u32) User {
        // You can use . instead of User, zig will infer
        // from the return type of the fn
        return .{
            .name = name,
            .age = age,
        };
    }

    pub fn print(user: User) void {
        std.debug.print("Hello {s}, you are {d} years old.\n", .{ user.name, user.age });
    }
};

test "User struct" {
    const user = User.init("Matt", 40);

    try std.testing.expectEqual(user.name, "Matt");
    try std.testing.expectEqual(user.age, 40);
}
