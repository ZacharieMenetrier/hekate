local world = require "src/world"

--------------------------------------------------------------------------------

function move(caster,dx,dy)
  local position = world.get(caster.__entity, "position")
  position.x = position.x + dx
  position.y = position.y + dy
end

return move
