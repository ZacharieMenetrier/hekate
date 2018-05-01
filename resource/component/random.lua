local random = {}

function random.run(entity, gamestate, resource)
  local x = love.math.random(-1, 1)
  local y = love.math.random(-1, 1)
  resource.component.position.move(entity, x, y)
  resource.component.action.take(entity)
end

return random
