local Component = require "resource/component/component"

--------------------------------------------------------------------------------

--! @brief Vital stats for an entity (HP, etc.)
local Vitals = Component:new()

function Vitals:heal(k)
  self.hp = self.hp + k
end

function Vitals:take_damage(k)
  if self.armor >= k then dmg = 0
  else dmg = k - self.armor end
  self.hp = self.hp - dmg
end

function Vitals:modify_resource(color,k)
  if color == 'red' then self.red_wp = self.red_wp + k end
  if color == 'green' then self.green_wp = self.green_wp + k end
  if color == 'blue' then self.blue_wp = self.blue_wp + k end
end

return Vitals
