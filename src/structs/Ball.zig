const r = @import("../raylib.zig");
const screen = @import("../global/screen.zig");
const p = @import("./Paddle.zig");

pub const Ball = struct {
    position: r.Vector2,
    size: r.Vector2,
    speed: r.Vector2,

    pub fn init(x: f32, y: f32, size: f32, speed: f32) Ball {
        return Ball{ .position = r.Vector2{ .x = x, .y = y }, .size = r.Vector2{ .x = size, .y = size }, .speed = r.Vector2{ .x = speed, .y = speed } };
    }

    pub fn update(self: *Ball) void {
        self.position = r.Vector2Add(self.position, self.speed);
    }

    pub fn reset(self: *Ball) void {
        self.position = r.Vector2{ .x = 50, .y = 50 };
    }

    pub fn tb_wall_collision_detection(self: *Ball) bool {
        //check for y collisions
        return self.position.y <= 0 or (self.position.y + self.size.y) > screen.SCREEN_HEIGHT;
    }

    pub fn lr_wall_collision_dectection(self: *Ball) bool {
        // check for x collisions
        return self.position.x <= 0 or (self.position.x + self.size.x) > screen.SCREEN_WIDTH;
    }

    pub fn paddle_collision_detection(self: *Ball, paddle: *p.Paddle) bool {
        // if ((self.position.y + self.size.y) >= paddle.position.y and (paddle.position.y + paddle.size.y) >= self.position.y) {
        //     self.speed.y *= -1;
        // }
        return ((self.position.x + self.size.x) >= paddle.position.x and (self.position.y + self.size.y) >= paddle.position.y) and ((paddle.position.x + paddle.size.x) >= self.position.x and (paddle.position.y + paddle.size.y) >= self.position.y);
    }

    pub fn draw(self: *Ball) void {
        r.DrawRectangleV(self.position, self.size, r.RED);
    }
};
