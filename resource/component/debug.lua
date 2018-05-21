local Component = require "resource/component/component"
local controller = require "src/controller"
local resource = require "src/resource"
local graphics = require "src/graphics"
local world = require "src/world"
local utils = require "src/utils"

local Debug = Component:new()

function Debug:draw_ui()
  -- Get the cursor and the tilemap of the world.
  local cursor = world.get("system", "cursor")
  local tilemap = world.get("system", "tilemap")
  -- Set components to nil before drawing.
  local components = nil
  local x, y = cursor:cursor_position()
  local tile = tilemap:get_tile(x, y)
  local component = controller.call_world_any("is_at_tile", x, y)
  if component then
    -- Get all the components of the entity selected.
    local filter = function(c) return c.__entity == component.__entity end
    components = world.select(filter)
    -- Serialize the components.
    str = world.serialize(components)
    -- Get the font.
    local font = resource.get("font", "PixelHekate")
    -- Create a graphical text from the serialization.
    components = love.graphics.newText(font, str)
  end
  -- Set the width and the height of the background.
  local w = love.graphics.getWidth()
  local h = 32
  -- If there is components to draw then enlarge the height.
  if components then
    h = components:getHeight() + 24
  end
  -- Set the background color.
  love.graphics.setColor(0, 0, 0, 0.7)
  -- Draw the background
  love.graphics.rectangle("fill", 0, 0, w, h)
  -- Reset the color.
  love.graphics.setColor(1, 1, 1, 1)
  -- Draw the fps.
  love.graphics.print(love.timer.getFPS() .. " fps", 12, 12)
  -- Draw the tile.
  love.graphics.print("tile : " .. tile, 96 + 12, 12)
  -- If there is components, draw them.
  if components then
    love.graphics.draw(components, 96 * 2 + 12, 12)
  end
end

return Debug
