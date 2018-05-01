local player = {}

function player.keypressed(entity, turn_state, cluster, tilemap, resource, key)
  if entity ~= cluster[turn_state] then return end
  if key == "up" then
    resource.component.position.move(entity, 0, -1)
    terminate = true
  end
  if key == "down" then
    resource.component.position.move(entity, 0, 1)
    terminate = true
  end
  if key == "left" then
    resource.component.position.move(entity, -1, 0)
    terminate = true
  end
  if key == "right" then
    resource.component.position.move(entity, 1, 0)
    terminate = true
  end
end

return player
