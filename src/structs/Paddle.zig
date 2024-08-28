const r = @import("../raylib.zig");
const screen = @import("../global/screen.zig");

pub const Paddle = struct {
    position: r.Vector2,
    size: r.Vector2,
    speed: f32,

    pub const PADDLE_WIDTH = 30;
    pub const PADDLE_HEIGHT = 100;

    pub fn init(x: f32, y: f32, width: f32, height: f32, speed: f32) Paddle {
        return Paddle{ .position = r.Vector2{ .x = x, .y = y }, .size = r.Vector2{ .x = width, .y = height }, .speed = speed };
    }

    pub fn update_movement(self: *Paddle, up: i16, down: i16) void {
        if (r.IsKeyDown(up) and self.position.y > 0) {
            self.position.y -= self.speed;
        }
        if (r.IsKeyDown(down) and (self.position.y + PADDLE_HEIGHT) < screen.SCREEN_HEIGHT) {
            self.position.y += self.speed;
        }
    }

    pub fn draw(self: *Paddle) void {
        r.DrawRectangleV(self.position, self.size, r.WHITE);
    }
};
