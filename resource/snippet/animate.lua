local graphics = require "src/graphics"
local Animate = {}

function Animate.load(entity, controller)
  local animate = entity.animate
  animate.time = 0
  animate.x = entity.position.x * graphics.tile_size
  animate.y = entity.position.y * graphics.tile_size
end

local move = function(entity, controller, dt)
  local animate = entity.animate
  local position = entity.position
  local idealx = position.x * graphics.tile_size
  local idealy = position.y * graphics.tile_size
  animate.x = animate.x - (animate.x - idealx) * dt * animate.speed
  animate.y = animate.y - (animate.y - idealy) * dt * animate.speed
end

local tilt = function(entity, controller, dt)
  local animate = entity.animate
  if animate.tilt ~= nil and animate.tilt > 0 then
    animate.tilt = animate.tilt - dt * 10
    if animate.tilt < 0 then controller:remove_block(1) end
  end
  animate.x = animate.x + math.sin(animate.tilt or 0) * 0.2
end

function Animate.tilt(entity, controller)
  controller:add_block(1)
  entity.animate.tilt = 10
end

function Animate.update(entity, controller, dt)
  entity.animate.time = entity.animate.time + dt
  move(entity, controller, dt)
  tilt(entity, controller, dt)
end

function Animate.draw(entity, controller)
  local animate = entity.animate
  local sprite = controller.resource.sprite[animate.sprite]
  love.graphics.draw(sprite, animate.x, animate.y)
end


return Animate
