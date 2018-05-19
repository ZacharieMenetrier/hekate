local Component = require "resource/component/component"
local world = require "src/world"

--------------------------------------------------------------------------------

local Player = Component:new()

function Player:keypressed(key)

  -- Query player abilities
  local abilities = world.get(self.__entity, "abilities")

  -- Learn move when the 'L' key is pressed
  if key == "l" then abilities:learn_ability("move") end

  -- Then you can happily move
  local position = world.get(self.__entity, "position")
  if key == "z" then abilities:call_ability("move",{0,-1}) end
  if key == "s" then abilities:call_ability("move",{0,1}) end
  if key == "q" then abilities:call_ability("move",{-1,0}) end
  if key == "d" then abilities:call_ability("move",{1,0}) end
end

return Player
