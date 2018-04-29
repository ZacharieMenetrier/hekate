local sprite = {}

function sprite.draw(entity, resource, graphics)
  local position = entity.position
  local xpix = (position.x - 1) * graphics.tile_size
  local ypix = (position.y - 1) * graphics.tile_size
  local image = resource.sprite[entity.sprite]
  love.graphics.draw(image, xpix, ypix)
end


return sprite
