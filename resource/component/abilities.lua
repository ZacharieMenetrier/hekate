local Component = require "resource/component/component"

--------------------------------------------------------------------------------

--! @brief This component contains a list of abilities and can call them.
local Abilities = Component:new()

--! @brief Learn an ability
function Abilities:learn_ability(ability_name)
  -- Each ability has its own lua file matching its name
  ability_to_learn = require ("resource/ability/" .. ability_name)
  self.abilities[ability_name] = ability_to_learn
  print("You have learned : " .. ability_name) -- Debug
end

--! @brief Get an ability from the list of known ones, and call it
function Abilities:call_ability(ability_name,parameters)
  local ability_to_call = nil
  ability_to_call = self.abilities[ability_name]

  -- Remark : ability calls must always include the caster (self)
  if (ability_to_call == nil) then print("Ability not learned.")
  else ability_to_call(self,unpack(parameters)) end
end

return Abilities
