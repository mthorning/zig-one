const std = @import("std");

pub fn include() void {}

const User = struct {
    id: u64,
    power: i32,

    // If you change the type to a pointer then zig
    // will know to pass a reference to the struct
    fn incrementPower(self: *User) void {
        self.power += 1;
    }
};

fn printMemAddresses() void {
    const user = User{
        .id = 1,
        .power = 100,
    };
    // & is the address-of operator it returns a pointer to the variable
    // the pointer is of type *User
    std.debug.print("{*}\n{*}\n{*}\n", .{ &user, &user.id, &user.power });
}

test User {
    var user = User{ .id = 1, .power = 100 };
    try std.testing.expectEqual(user.power, 100);

    user.incrementPower();
    try std.testing.expectEqual(user.power, 101);
}
