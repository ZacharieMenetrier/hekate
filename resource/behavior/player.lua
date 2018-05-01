local player = {}

function player.keypressed(entity, controller, key)
  if controller.gamestate.entity ~= entity then return end
  if key == "up" then
    controller:call_entity("move", entity, 0, -1)
    controller:call_entity("take", entity)
  end
  if key == "down" then
    controller:call_entity("move", entity, 0, 1)
    controller:call_entity("take", entity)
  end
  if key == "left" then
    controller:call_entity("move", entity, -1, 0)
    controller:call_entity("take", entity)
  end
  if key == "right" then
    controller:call_entity("move", entity, 1, 0)
    controller:call_entity("take", entity)
  end
end

return player
