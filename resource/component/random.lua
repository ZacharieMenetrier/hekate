local random = {}

function random.run(entity, controller)
  local x = love.math.random(-1, 1)
  local y = love.math.random(-1, 1)
  controller.resource.component.position.move(entity, controller, x, y)
  controller.resource.component.action.take(entity)
end

function random.react(entity, controller, modification, name, params)
  if name == "move" then
    if entity ~= params.entity then
      local x = love.math.random(-1, 1)
      local y = love.math.random(-1, 1)
      controller.resource.component.position.move(entity, controller, x, y)
    end
  end
end

return random
