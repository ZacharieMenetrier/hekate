local Component = require "resource/component/component"
local world = require "src/world"
local graphics = require "src/graphics"

--------------------------------------------------------------------------------

--! @brief A system component to process player input
-- Remember, this component is only here to interpret input into orders,
-- send those to the Player component for execution
local Interface = Component:new()



--! @brief Selecting an entity with a left click of the mouse
function Interface:mousepressed(x, y, button)
  if button == 1 then

    local camera = world.get("system", "camera")
    clicked_x_tile = math.floor((x + camera.x) / (graphics.tile_size * graphics.scale))
    clicked_y_tile = math.floor((y + camera.y) / (graphics.tile_size * graphics.scale))


    -- TODO Separate entity selection and tile selection
    print("X = " .. clicked_x_tile .. " , Y = ".. clicked_y_tile)
    filter_pos = function(c) if (c.__name == "position" and c.x == clicked_x_tile and c.y == clicked_y_tile) then return true end end

    -- Get the position component that has this tile
    position_on_tile = world.select(filter_pos)
    for i,c in pairs(position_on_tile) do self.selected_entity = c.__entity end

    -- TODO Add a keybinding to unselect

  end
end




--! @brief UI drawing function to be called in the main loop. Main wrapper.
function Interface:draw_ui()

  -- Infos about selected
  if self.selected_entity ~= nil then
    if world.exists(self.selected_entity, "vitals") then
      local vitals = world.get(self.selected_entity, "vitals")
      self.draw_ui_vitals(vitals,posx,posy)
    end
  end

end


--------------------------------------------------------------------------------
-- UI components

function Interface.draw_ui_vitals(vitals,posx,posy)
  if vitals ~= nil then
    love.graphics.print("---- ".. vitals.name .. " ----",100,80)
    love.graphics.print("Health : ".. vitals.hp,100,100)
    love.graphics.print("Armor : ".. vitals.armor,100,120)
    love.graphics.print("R : ".. vitals.red_wp,100,140)
    love.graphics.print("G : ".. vitals.green_wp,150,140)
    love.graphics.print("B : ".. vitals.blue_wp,200,140)
  end
end


return Interface
