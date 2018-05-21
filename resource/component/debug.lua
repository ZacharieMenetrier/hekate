local Component = require "resource/component/component"
local controller = require "src/controller"
local resource = require "src/resource"
local graphics = require "src/graphics"
local world = require "src/world"
local utils = require "src/utils"

local Debug = Component:new()

function Debug:load()
  self.tile = "nil"
end

function Debug:draw_ui()
  local components = nil
  local cursor = world.get("system", "cursor")
  local tilemap = world.get("system", "tilemap")
  local xc, yc = cursor:cursor_position()
  self.tile = tilemap:get_tile(xc, yc)
  local res = controller.call_world_any("is_at_tile", xc, yc)
  if res then
    components = world.select(function(c) return c.__entity == res.__entity end)
    components = world.serialize(components)
    components = love.graphics.newText(resource.get("font", "PixelHekate") , components )
  end
  love.graphics.setColor(0, 0, 0, 0.7)
  local w = love.graphics.getWidth()
  local height = 32
  if components then
    height = components:getHeight() + 24
  end
  love.graphics.rectangle("fill", 0, 0, w, height)
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.print(love.timer.getFPS() .. " fps", 12, 12)
  love.graphics.print("tile : " .. self.tile, 96 + 12, 12)
  if components then
    love.graphics.draw(components, 96 * 2 + 12, 12)
  end
end

return Debug
