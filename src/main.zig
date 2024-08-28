const std = @import("std");
const r = @import("raylib.zig");
const screen = @import("./global/screen.zig");
const b = @import("./structs/Ball.zig");
const p = @import("./structs/Paddle.zig");

pub fn main() !void {
    r.InitWindow(screen.SCREEN_WIDTH, screen.SCREEN_HEIGHT, "RayZig Window :)");
    defer r.CloseWindow();

    r.SetTargetFPS(60);

    var ball = b.Ball.init(50, 50, 32, 4);
    var p1paddle = p.Paddle.init(0, 0, p.Paddle.PADDLE_WIDTH, p.Paddle.PADDLE_HEIGHT, 4);
    var p2paddle = p.Paddle.init(screen.SCREEN_WIDTH - p.Paddle.PADDLE_WIDTH, 0, p.Paddle.PADDLE_WIDTH, p.Paddle.PADDLE_HEIGHT, 4);
    while (!r.WindowShouldClose()) {
        r.BeginDrawing();
        defer r.EndDrawing();
        r.ClearBackground(r.BLACK);

        // UPDATE
        ball.update();
        p1paddle.update_movement(r.KEY_W, r.KEY_S);
        p2paddle.update_movement(r.KEY_UP, r.KEY_DOWN);
        ball.wall_collision_detection();
        ball.paddle_collision_detection(&p1paddle);
        ball.paddle_collision_detection(&p2paddle);

        // DRAW
        ball.draw();
        p1paddle.draw();
        p2paddle.draw();
    }
}
