local Random = {}

function Random.update(entity, controller)
  if controller.gamestate.entity ~= entity then return end
  if controller:is_blocked() then return end
  if love.math.random(0, 1) == 1 then
    local x = love.math.random(-1, 1)
    local y = love.math.random(-1, 1)
    controller:call_entity("move", entity, x, y)
  else
    controller:call_entity("tilt", entity)
  end
  controller:call_entity("remove_action", entity)
end



return Random
