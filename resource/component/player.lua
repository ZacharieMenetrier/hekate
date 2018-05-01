local player = {}

function player.keypressed(entity, gamestate, resource, key)
  if gamestate.entity ~= entity then return end
  if key == "up" then
    resource.component.position.move(entity, 0, -1)
    resource.component.action.take(entity)
  end
  if key == "down" then
    resource.component.position.move(entity, 0, 1)
    resource.component.action.take(entity)
  end
  if key == "left" then
    resource.component.position.move(entity, -1, 0)
    resource.component.action.take(entity)
  end
  if key == "right" then
    resource.component.position.move(entity, 1, 0)
    resource.component.action.take(entity)
  end
end

return player
