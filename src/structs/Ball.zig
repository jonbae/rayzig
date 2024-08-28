const r = @import("raylib.zig");
const screen = @import("../global/screen.zig");

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
        if (self.position.y <= 0 or (self.position.y + self.size.y) > screen.SCREEN_HEIGHT) {
            self.speed.y *= -1;
        }

        // check for x collisions
        if (self.position.x <= 0 or (self.position.x + self.size.x) > screen.SCREEN_WIDTH) {
            self.speed.x *= -1;
        }
    }

    pub fn draw(self: *Ball) void {
        r.DrawRectangleV(self.position, self.size, r.RED);
    }
};
