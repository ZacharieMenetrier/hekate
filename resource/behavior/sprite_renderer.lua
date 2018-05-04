local sprite_renderer = {}

function sprite_renderer.draw(entity, controller)
  local x = entity.sprite_renderer.x
  local y = entity.sprite_renderer.y
  local sprite = controller.resource.sprite[entity.sprite_renderer.sprite]
  love.graphics.draw(sprite, x, y)
end

local readjust = function(entity)
  entity.sprite_renderer.x = entity.position.x * 16
  entity.sprite_renderer.y = entity.position.y * 16
end

function sprite_renderer.move(entity, controller, x, y)

end

function sprite_renderer.begin(entity, controller)
  readjust(entity)
end

return sprite_renderer
