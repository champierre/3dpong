--[[
    This is CS50 2019.
    Games Track
    Pong

    -- Ball Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    Represents a ball which will bounce back and forth between paddles
    and walls until it passes a left or right boundary of the screen,
    scoring a point for the opponent.
]]

Ball = Class{}

function Ball:init(x, y, z, width, height)
    self.x = x
    self.y = y
    self.z = z
    self.width = width
    self.height = height

    -- these variables are for keeping track of our velocity on both the
    -- X and Y axis, since the ball can move in two dimensions
    self.dy = math.random(2) == 1 and -100 or 100
    self.dx = math.random(2) == 1 and math.random(-80, -100) or math.random(80, 100)
    self.dz = INITIAL_DZ
end

--[[
    Expects a paddle as an argument and returns true or false, depending
    on whether their rectangles overlap.
]]
function Ball:collides(paddle)
    if self.x > paddle.x and self.x < paddle.x + paddle.width and self.y > paddle.y and self.y < paddle.y + paddle.height and self.z <= 0 then
        return true
    end

    if self.x + self.width > paddle.x and self.x + self.width < paddle.x + paddle.width and self.y > paddle.y and self.y < paddle.y + paddle.height and self.z <= 0 then
        return true
    end

    if self.x > paddle.x and self.x < paddle.x + paddle.width and self.y + self.height > paddle.y and self.y + self.height < paddle.y + paddle.height and self.z <= 0 then
        return true
    end

    if self.x + self.width > paddle.x and self.x + self.width < paddle.x + paddle.width and self.y + self.height > paddle.y and self.y + self.height < paddle.y + paddle.height and self.z <= 0 then
        return true
    end

    -- if the above aren't true, they're overlapping
    return false
end

--[[
    Places the ball in the middle of the screen, with an initial random velocity
    on both axes.
]]
function Ball:reset()
    self.x = VIRTUAL_WIDTH / 2 - 2
    self.y = VIRTUAL_HEIGHT / 2 - 2
    self.z = 0
    self.dy = math.random(2) == 1 and -100 or 100
    self.dx = math.random(-50, 50)
    self.dz = INITIAL_DZ
end

--[[
    Simply applies velocity to position, scaled by deltaTime.
]]
function Ball:update(dt)
    self.x = self.x + self.dx * dt * VELOCITY_RATIO
    self.y = self.y + self.dy * dt * VELOCITY_RATIO

    self.dz = self.dz + GRAVITY
    self.z = self.z + self.dz * dt
end

function Ball:render()
    -- Ball shade
    love.graphics.setColor(32 / 255, 32 / 255, 32 / 255, 255 / 255)
    love.graphics.rectangle(
      'fill',
      self.x + (self.width * self.z * BALL_SIZE_RATIO) / 2 - self.z * SHADE_RATIO,
      self.y + (self.height * self.z * BALL_SIZE_RATIO) / 2 + self.z * SHADE_RATIO,
      4,
      4
    )

    love.graphics.setColor((128 + self.z / 4) / 255, (128 + self.z / 4) / 255, 0 / 255, 255 / 255)
    love.graphics.rectangle(
      'fill',
      self.x,
      self.y,
      math.max(self.width, self.width * self.z * BALL_SIZE_RATIO),
      math.max(self.height, self.height * self.z * BALL_SIZE_RATIO)
    )
end
