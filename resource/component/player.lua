local player = {}

function player.keypressed(entity, controller, key)
  if controller.gamestate.entity ~= entity then return end
  if key == "up" then
    controller.resource.component.position.move(entity, controller, 0, -1)
    controller.resource.component.action.take(entity)
  end
  if key == "down" then
    controller.resource.component.position.move(entity, controller, 0, 1)
    controller.resource.component.action.take(entity)
  end
  if key == "left" then
    controller.resource.component.position.move(entity, controller, -1, 0)
    controller.resource.component.action.take(entity)
  end
  if key == "right" then
    controller.resource.component.position.move(entity, controller, 1, 0)
    controller.resource.component.action.take(entity)
  end
end

return player
