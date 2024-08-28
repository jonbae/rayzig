const std = @import("std");
const r = @import("raylib.zig");

const SCREEN_WIDTH = 960;
const SCREEN_HEIGHT = 540;

const Ball = struct {
    position: r.Vector2,
    size: r.Vector2,
    speed: r.Vector2,

    pub fn init(x: f32, y: f32, size: f32, speed: f32) Ball {
        return Ball{ .position = r.Vector2{ .x = x, .y = y }, .size = r.Vector2{ .x = size, .y = size }, .speed = r.Vector2{ .x = speed, .y = speed } };
    }

    pub fn update(self: *Ball) void {
        self.position = r.Vector2Add(self.position, self.speed);

        //check for y collisions
        if (self.position.y <= 0 or (self.position.y + self.size.y) >= SCREEN_HEIGHT) {
            self.speed.y *= -1;
        }

        // check for x collisions
        if (self.position.x <= 0 or (self.position.x + self.size.x) >= SCREEN_WIDTH) {
            self.speed.x *= -1;
        }
    }

    pub fn draw(self: *Ball) void {
        r.DrawRectangleV(self.position, self.size, r.RED);
    }
};

pub fn main() !void {
    r.InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "RayZig Window :)");
    defer r.CloseWindow();

    r.SetTargetFPS(60);

    var ball = Ball.init(0, 0, 32, 4);

    while (!r.WindowShouldClose()) {
        r.BeginDrawing();
        defer r.EndDrawing();
        r.ClearBackground(r.BLACK);

        // UPDATE
        ball.update();

        // DRAW
        ball.draw();
    }
}
