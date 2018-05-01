local random = {}

function random.run(entity, controller)
  local x = love.math.random(-1, 1)
  local y = love.math.random(-1, 1)
  controller.resource.component.position.move(entity, x, y)
  controller.resource.component.action.take(entity)
end

return random
