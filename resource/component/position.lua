local position = {}

function position.move(entity, controller, x, y)

  modification = function(params)
    params.entity.position.x = params.entity.position.x + params.x
    params.entity.position.y = params.entity.position.y + params.y
  end

  params = { entity = entity, x = x, y = y}
  controller:alter_gamestate(modification, "move", params)
end

return position
