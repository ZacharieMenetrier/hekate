local Component = require "resource/component/component"
local controller = require "src/controller"
local resource = require "src/resource"
local graphics = require "src/graphics"
local world = require "src/world"

--- The cursor is keeping track of the mouse in tile coordinates.
-- @classmod cursor
local Cursor = Component:new()

--- Load the cursor.
function Cursor:load()
  self.sprite = resource.get("sprite", "square")
end

--- Update the cursor.
function Cursor:update(dt)
  local camera = world.get("system", "camera")
  local xpix, ypix = camera:mouse_to_world_pixel()
  local x, y = graphics.pixel_to_tile(xpix, ypix, camera.scale)
  self.x = x
  self.y = y
end

--- Get the cursor position.
function Cursor:cursor_position()
  return self.x, self.y
end

--- Transform a mouse pressed in a tile pressed.
function Cursor:mousepressed(x, y, button)
  controller.call_world("tile_pressed", self.x, self.y, button)
end

--- Draw the cursor.
function Cursor:draw_cursor()
  local x, y = graphics.tile_to_pixel(self.x, self.y)
  love.graphics.draw(self.sprite, x, y)
end

return Cursor
