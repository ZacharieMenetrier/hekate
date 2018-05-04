local position = {}

function position.move(entity, controller, x, y)
  if controller:get_tile_at(entity.position.x + x, entity.position.y + y) == 1 then
    return
  end
  entity.position.x = entity.position.x + x
  entity.position.y = entity.position.y + y
end

return position
