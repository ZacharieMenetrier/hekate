local world = require "src/world"

--------------------------------------------------------------------------------

function shoot(caster,target,dmg)
  local target_vitals = world.get(target, "vitals")
  -- if target, shoot, otherwise print "no targfet !"
  -- Here will go LOS checks I think
  target_vitals:take_damage(dmg)
end

return shoot
