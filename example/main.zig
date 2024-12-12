const std = @import("std");
const Prompt = @import("prompter").Prompt;

fn three_len_val(str: []const u8) bool {
    return str.len == 3;
}

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    const stdout_w = std.io.getStdOut().writer();

    var p = Prompt.init(allocator);

    const input_1 = try p.string("Write something", "Default");
    defer allocator.free(input_1);
    try stdout_w.print("{s}\n", .{input_1});

    const input_2 = try p.stringValidated("Write a string with length = 3", null, three_len_val);
    defer allocator.free(input_2);
    try stdout_w.print("{s}\n", .{input_2});
}
