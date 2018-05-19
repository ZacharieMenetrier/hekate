local Component = require "resource/component/component"
local controller = require "src/controller"
local graphics = require "src/graphics"
local utils = require "src/utils/utils"
local math = require "math"

--------------------------------------------------------------------------------
--private variables-------------------------------------------------------------
--------------------------------------------------------------------------------

local draw_depth = function()
  local renders = controller.call_world("render")
  local sorted = {}
  for _, render in pairs(renders) do table.insert(sorted, render) end
  table.sort(sorted, function(a, b) return a.z < b.z end)
  for _, render in pairs(sorted) do
    local sprite = render.sprite
    love.graphics.draw(sprite, render.x, render.y - render.yoffset)
  end
end

--------------------------------------------------------------------------------
--public variables--------------------------------------------------------------
--------------------------------------------------------------------------------

local Camera = Component:new()

function Camera:load()
  self.lockx = 0
  self.locky = 0
  self.drag = false
end

function Camera:mousepressed(x, y, button)
  if button ~= 2 then return end
  self.lockx = x
  self.locky = y
end

function Camera:tiles_visibles()
  local tiles = {}
  local w = love.graphics.getWidth() / graphics.scale / graphics.tile_size
  local h = love.graphics.getHeight() / graphics.scale / graphics.tile_size
  local xshift = math.floor(self.x / graphics.tile_size)
  local yshift = math.floor(self.y / graphics.tile_size)
  for y = 0, h + 1 do
    for x = 0, w + 1 do
      local xshifted = x + xshift
      local yshifted = y + yshift
      table.insert(tiles, {x = xshifted, y = yshifted})
    end
  end
  return tiles
end

function Camera:is_tile_visible(x, y)
  local w = love.graphics.getWidth() / graphics.scale
  local h = love.graphics.getHeight() / graphics.scale
  local x1 = self.x - 32
  local y1 = self.y - 32
  local x2 = self.x + w
  local y2 = self.y + h
  local xpix = x * graphics.tile_size
  local ypix = y * graphics.tile_size
  return xpix > x1 and xpix < x2 and ypix > y1 and ypix < y2
end

function Camera:update(dt)
  if not love.mouse.isDown(2) then return end
  local xdiff = self.lockx - love.mouse.getX()
  local ydiff = self.locky - love.mouse.getY()
  self.x = self.x + xdiff
  self.y = self.y + ydiff
  self.lockx = love.mouse.getX()
  self.locky = love.mouse.getY()
end

function Camera:draw()
  love.graphics.translate(-self.x, -self.y)
  controller.call_world("draw_tilemap")
  draw_depth()
end

function Camera:get_save()
  return self:get_partial_save("x", "y")
end

return Camera
