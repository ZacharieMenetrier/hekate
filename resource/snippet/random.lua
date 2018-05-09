local Random = {}

function Random.update(entity, controller)
  if controller.gamestate.entity ~= entity then return end
  local x = love.math.random(-1, 1)
  local y = love.math.random(-1, 1)
  controller:call_entity("move", entity, x, y)
  controller:call_entity("remove_action", entity)
end

return Random
