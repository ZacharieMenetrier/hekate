local Component = require "resource/component/component"
local world = require "src/world"

--- This components marks entities that are controlled by the player.
-- It is responsible for order execution.
-- @classmod player
local Player = Component:new()

-- TODO Move this to interface and instead have the Player component call abilities
-- TODO This will be barebones : the player component is simply equivalent to the
-- AI component. It just marks entities that are controlled by the player, and
-- simply relays ability parameters from the interface.
-- As such, we need to query interface component when we do something.




function Player:keypressed(key)

  -- Query the interface component
  -- NOTE will be useful in the future when Player takes its proper role as relay
  -- of orders *from* the interface
  local interface = world.get_by_key("system__interface")

  -- Query player abilities
  local abilities = world.get(self.__entity, "abilities")

  -- Learn move when the 'L' key is pressed
  if key == "l" then
    abilities:learn_ability("move")
    abilities:learn_ability("shoot")
  end

  -- Then you can happily move
  local position = world.get(self.__entity, "position")
  if key == "z" then abilities:call_ability("move",{0,-1}) end
  if key == "s" then abilities:call_ability("move",{0,1}) end
  if key == "q" then abilities:call_ability("move",{-1,0}) end
  if key == "d" then abilities:call_ability("move",{1,0}) end

  -- Shoot the target when t is pressed
  if key == "t" then
    -- get the current target in the interface
    target = interface.selected_target
    if (target == nil) then print("No target selected.")
    else
      print(target)
      abilities:call_ability("shoot",{target,2})
    end
  end


end




return Player
