local Position = {}

function Position.move(entity, controller, x, y)
  local nextx = entity.position.x + x
  local nexty = entity.position.y + y
  local tile = controller.gamestate:get_tile_at(nextx, nexty)
  if tile == 1 then
    return
  end
  entity.position.x = entity.position.x + x
  entity.position.y = entity.position.y + y
end

return Position
