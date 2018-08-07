local world = require "src/world"

--------------------------------------------------------------------------------

function shoot(caster,target,dmg)
  local target_vitals = world.get(target, "vitals")
  -- Here will go LOS checks I think
  target_vitals:take_damage(dmg)
end

return shoot
