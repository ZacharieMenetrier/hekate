local Component = require "resource/component/component"
local controller = require "src/controller"
local resource = require "src/resource"
local graphics = require "src/graphics"
local utils = require "src/utils/utils"
local world = require "src/world"
local math = require "math"

--------------------------------------------------------------------------------
--private variables-------------------------------------------------------------
--------------------------------------------------------------------------------

--! @brief Draw all the entities with their responses for render function.
local draw_depth = function()
  local renders = controller.call_world("render")
  local sorted = {}
  for _, render in pairs(renders) do table.insert(sorted, render) end
  table.sort(sorted, function(a, b) return a.z < b.z end)
  for _, render in pairs(sorted) do
    local sprite = render.sprite
    love.graphics.draw(sprite, render.x, render.y, 0, 1, 1, 1, 32)
  end
end

local create_grid = function()
  local grid = love.graphics.newSpriteBatch(resource.get("sprite", "grid"), 4096)
  local w = love.graphics.getWidth()
  local h = love.graphics.getHeight()
  for x = 0, (w / graphics.scale) + graphics.tile_size, graphics.tile_size  do
    for y = 0, (h / graphics.scale) + graphics.tile_size, graphics.tile_size do
      grid:add(x, y)
    end
  end
  return grid
end

--------------------------------------------------------------------------------
--public variables--------------------------------------------------------------
--------------------------------------------------------------------------------

local Camera = Component:new()

function Camera:load()
  self.lockx = 0
  self.locky = 0
  self.grid = create_grid()
  self.alpha = 0
end

function Camera:world_mouse()
  return self.x + love.mouse.getX(), self.y + love.mouse.getY()
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
  local xshift = math.floor(self.x / graphics.scale / graphics.tile_size)
  local yshift = math.floor(self.y / graphics.scale / graphics.tile_size)
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
  local x1 = self.x - graphics.tile_size
  local y1 = self.y - graphics.tile_size
  local x2 = self.x + w
  local y2 = self.y + h
  local xpix = x * graphics.tile_size
  local ypix = y * graphics.tile_size
  return xpix > x1 and xpix < x2 and ypix > y1 and ypix < y2
end

function Camera:update(dt)
  if love.keyboard.isDown("g") then self.alpha = 1 else self.alpha = 0 end
  if not love.mouse.isDown(2) then return end
  local xdiff = self.lockx - love.mouse.getX()
  local ydiff = self.locky - love.mouse.getY()
  self.x = self.x + xdiff
  self.y = self.y + ydiff
  self.lockx = love.mouse.getX()
  self.locky = love.mouse.getY()
end

function Camera:resize()
  self.grid = create_grid()
end

function Camera:draw()
  love.graphics.translate(-self.x / graphics.scale, -self.y / graphics.scale)
  controller.call_world("draw_tilemap")
  local cursor = world.get("system", "cursor")
  cursor:draw_cursor()
  local x = math.floor(self.x / graphics.scale / graphics.tile_size) * graphics.tile_size
  local y = math.floor(self.y / graphics.scale / graphics.tile_size) * graphics.tile_size
  love.graphics.setColor(1, 1, 1, self.alpha)
  love.graphics.draw(self.grid, x, y)
  love.graphics.setColor(1, 1, 1, 1)
  draw_depth()
end

function Camera:get_save()
  return self:get_partial_save("x", "y")
end

return Camera
