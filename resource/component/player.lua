local player = {}

function player.keypressed(entity, turn_state, cluster, tilemap, resource, key)
  if entity ~= cluster[turn_state] then return end
  if key == "space" then
    resource.component.position.move(entity, 1, 1)
    terminate = true
  end
end

return player
