local random = {}

function random.run(entity, turn_state, cluster, tilemap, resource)
  local x = love.math.random(-1, 1)
  local y = love.math.random(-1, 1)
  resource.component.position.move(entity, x, y)
  terminate = true
end

return random
