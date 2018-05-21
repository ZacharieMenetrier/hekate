local Component = require "resource/component/component"
local world = require "src/world"
local graphics = require "src/graphics"

--------------------------------------------------------------------------------

--! @brief A system component to process player input
-- Remember, this component is only here to interpret input into orders,
-- send those to the Player component for execution
local Interface = Component:new()



--! @brief Selecting an entity with a left click of the mouse
function Interface:tile_pressed(x,y)
  print("X = " .. x .. " , Y = ".. y)
  filter_pos = function(c) if (c.__name == "position" and c.x == x and c.y == y) then return true end end

  -- Get the position component that has this tile
  position_on_tile = world.select(filter_pos)
  if next(position_on_tile) == nil then self.selected_entity = nil end
  for _,c in pairs(position_on_tile) do
    self.selected_entity = c.__entity
  end
end




--! @brief UI drawing function to be called in the main loop. Main wrapper.
function Interface:draw_ui()

  -- Infos about selected
  if self.selected_entity ~= nil then
    if world.exists(self.selected_entity, "vitals") then
      local vitals = world.get(self.selected_entity, "vitals")
      local abilities = world.get(self.selected_entity, "abilities")
      self.draw_ui_vitals(vitals,100,100)
      self.draw_ui_abilties(abilities,100,300)
    end
  end

end


--------------------------------------------------------------------------------
-- UI components

function Interface.draw_ui_vitals(vitals,posx,posy)
  if vitals ~= nil then
    love.graphics.print("---- ".. vitals.name .. " ----",posx,posy)
    love.graphics.print("Health : ".. vitals.hp,posx,posy+20)
    love.graphics.print("Armor : ".. vitals.armor,posx,posy+40)
    love.graphics.print("R : ".. vitals.red_wp,posx,posy+60)
    love.graphics.print("G : ".. vitals.green_wp,posx+50,posy+60)
    love.graphics.print("B : ".. vitals.blue_wp,posx+100,posy+60)
  end
end

function Interface.draw_ui_abilties(abilities,posx,posy)
  love.graphics.print("-- Abilities -- ",posx,posy-20)
  local posdelta = 0
  for a,_ in pairs(abilities.abilities) do
    love.graphics.print(a,posx,posy+posdelta)
    posdelta = posdelta + 20
  end
end

return Interface
