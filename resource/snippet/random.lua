local Random = {}

function Random.run(entity, controller)
  local x = love.math.random(-1, 1)
  local y = love.math.random(-1, 1)
  controller:call_entity("move", entity, x, y)
  controller:call_entity("remove_action", entity)
end

function Random.react(entity, controller, modification, name, params)
  if name == "move" then
    if entity ~= params.entity then
      local x = love.math.random(-1, 1)
      local y = love.math.random(-1, 1)
      controller:call_entity("move", entity, x, y)
      controller:call_entity("remove_action", entity)
    end
  end
end

return Random
