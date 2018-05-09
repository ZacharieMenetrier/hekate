local graphics = require "src/graphics"

local Renderer = {}

function Renderer.update(entity, controller, dt)
  local position = entity.position
  local renderer = entity.renderer
  local speed = renderer.speed
  local idealx = position.x * graphics.tile_size
  local idealy = position.y * graphics.tile_size
  local x = renderer.x
  local y = renderer.y
  renderer.x = x - (x - idealx) * dt * speed
  renderer.y = y - (y - idealy) * dt * speed

end

function Renderer.draw(entity, controller)
  print("55")
  local renderer = entity.renderer
  local sprite = controller.resource.sprite[renderer.sprite]
  love.graphics.draw(sprite, renderer.x, renderer.y)
end

return Renderer
