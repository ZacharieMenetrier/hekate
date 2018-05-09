local Position = {}

function Position.move(entity, controller, x, y)
  local nextx = entity.position.x + x
  local nexty = entity.position.y + y
  if controller.gamestate:is_solid_at(nextx, nexty) then return end
  entity.position.x = entity.position.x + x
  entity.position.y = entity.position.y + y
end

return Position
