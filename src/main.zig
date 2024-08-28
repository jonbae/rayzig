const std = @import("std");
const r = @import("raylib.zig");
const screen = @import("../global/screen.zig");
const ball_struct = @import("./structs/Ball.zig");
const paddle_struct = @import("./structs/Paddle.zig");

pub fn main() !void {
    r.InitWindow(screen.SCREEN_WIDTH, screen.SCREEN_HEIGHT, "RayZig Window :)");
    defer r.CloseWindow();

    r.SetTargetFPS(60);

    var ball = ball_struct.Ball.init(0, 0, 32, 4);
    var paddle = paddle_struct.Paddle.init(0, 0, paddle_struct.PADDLE_WIDTH, paddle_struct.PADDLE_HEIGHT, 4);
    while (!r.WindowShouldClose()) {
        r.BeginDrawing();
        defer r.EndDrawing();
        r.ClearBackground(r.BLACK);

        // UPDATE
        ball.update();
        paddle.update();

        // DRAW
        ball.draw();
        paddle.draw();
    }
}
