-- This component contains a list of abilities and can call them.

local Component = require "resource/component/component"

--------------------------------------------------------------------------------

local Abilities = Component:new()

-- @brief Learn an ability
function Abilities:learn_ability(ability_name)
  -- Query the ability file
  ability_to_learn = require ("resource/ability/" .. ability_name)

  self.abilities[ability_name] = ability_to_learn
  print("You have learned : " .. ability_name) -- Debug
end

-- @brief Query an ability and call it
function Abilities:call_ability(ability_name,parameters)
  local ability_to_call = self.abilities[ability_name]
  -- Call the ability.
  ability_to_call(self,unpack(parameters))
end


return Abilities
