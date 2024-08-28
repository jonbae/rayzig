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

    pub fn wall_collision_detection(self: *Ball) void {
        //check for y collisions
        if (self.position.y <= 0 or (self.position.y + self.size.y) > screen.SCREEN_HEIGHT) {
            self.speed.y *= -1;
        }

        // check for x collisions
        if (self.position.x <= 0 or (self.position.x + self.size.x) > screen.SCREEN_WIDTH) {
            self.speed.x *= -1;
        }
    }

    pub fn paddle_collision_detection(self: *Ball, paddle: *p.Paddle) void {
        // if ((self.position.y + self.size.y) >= paddle.position.y and (paddle.position.y + paddle.size.y) >= self.position.y) {
        //     self.speed.y *= -1;
        // }
        if (((self.position.x + self.size.x) >= paddle.position.x and (self.position.y + self.size.y) >= paddle.position.y) and ((paddle.position.x + paddle.size.x) >= self.position.x and (paddle.position.y + paddle.size.y) >= self.position.y)) {
            self.speed.x *= -1;
        }
    }

    pub fn draw(self: *Ball) void {
        r.DrawRectangleV(self.position, self.size, r.RED);
    }
};
