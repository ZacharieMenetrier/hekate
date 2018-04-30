local position = {}

function position.move(entity, x, y)
  entity.position.x = entity.position.x + x
  entity.position.y = entity.position.y + y
end

return position
