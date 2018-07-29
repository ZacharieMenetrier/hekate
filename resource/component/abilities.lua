local Component = require "resource/component/component"
local resource = require "src/resource"

--- This component contains a list of abilities and can call them.
-- @classmod abilities
local Abilities = Component:new()

--- Learn an ability
function Abilities:learn_ability(ability_name)
  -- Each ability has its own lua file matching its name
  ability_to_learn = resource.get("ability",ability_name)
  self.abilities[ability_name] = ability_to_learn
  print("You have learned : " .. ability_name) -- Debug
end

--- Get an ability from the list of known ones, and call it
function Abilities:call_ability(ability_name,parameters)
  local ability_to_call = nil
  ability_to_call = self.abilities[ability_name]

  -- Remark : ability calls must always include the caster (self)
  if (ability_to_call == nil) then print("Ability not learned.")
  else
    ability_to_call(self,unpack(parameters))

    -- Print the ability and its parameters
    -- TODO print that in the interface of the game, with the caster and the parameters
    print(self.__entity.." used "..ability_name.." with the parameters : ")
    print("\t"..unpack(parameters))
  end

end

return Abilities
