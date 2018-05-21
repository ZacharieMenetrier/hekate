local Component = require "resource/component/component"
local controller = require "src/controller"
local resource = require "src/resource"
local graphics = require "src/graphics"
local world = require "src/world"

local Cursor = Component:new()

function Cursor:load()
  self.x = 0
  self.y = 0
  self.sprite = resource.get("sprite", "square")
end

function Cursor:update(dt)
  local camera = world.get("system", "camera")
  local xpix, ypix = camera:world_mouse()
  local x, y = graphics.pixel_to_tile(xpix, ypix)
  self.x = x
  self.y = y
end

function Cursor:mousepressed(x, y, button)
  controller.call_world("tile_pressed", self.x, self.y)
end

function Cursor:draw_cursor()
  local x, y = graphics.tile_to_pixel(self.x, self.y)
  love.graphics.draw(self.sprite, x, y)
end

return Cursor
