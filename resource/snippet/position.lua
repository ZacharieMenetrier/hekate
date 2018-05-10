local Position = {}

function Position.move(this, controller, x, y)
  local position = this.components.position
  local nextx = position.x + x
  local nexty = position.y + y
  if controller.gamestate:is_solid_at(nextx, nexty) then return end
  position.x = position.x + x
  position.y = position.y + y
end

return Position
