local world = require "src/world"

local Player = {}

function Player:keypressed(key)
  local position = world.get(self.__entity, "position")
  if key == "z" then position:move(0, -1) end
  if key == "s" then position:move(0, 1) end
  if key == "q" then position:move(-1, 0) end
  if key == "d" then position:move(1, 0) end
end

return Player
