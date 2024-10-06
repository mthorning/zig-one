const std = @import("std");

pub fn include() void {}

const TimestampType = enum {
    unix,
    datetime,
};

// Finally, the enum type of a tagged union can be inferred.
// Instead of defining a TimestampType, we could have done:
//   const Timestamp = union(enum) {
const Timestamp = union(TimestampType) {
    unix: i32,
    datetime: DateTime,

    const DateTime = struct {
        year: u16,
        month: u8,
        day: u8,
        hour: u8,
        minute: u8,
        second: u8,
    };

    pub fn seconds(self: Timestamp) u16 {
        switch (self) {
            .datetime => |dt| return dt.second,
            .unix => |ts| {
                const seconds_since_midnight: i32 = @rem(ts, 86400);
                return @intCast(@rem(seconds_since_midnight, 60));
            },
        }
    }
};

test Timestamp {
    const ts = Timestamp{ .unix = 1728217801 };
    try std.testing.expectEqual(ts.seconds(), 1);
}
