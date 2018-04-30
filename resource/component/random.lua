local random = {}

function random.run(entity, turn_state, cluster, tilemap, resource)
  resource.component.position.move(entity, 0, 1)
  terminate = true
end

return random
