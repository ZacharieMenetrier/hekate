local Component = require "resource/component/component"
local utils = require "src/utils/utils"
local graphics = require "src/graphics"
local resource = require "src/resource"
local math = require "math"

--------------------------------------------------------------------------------
--private variables-------------------------------------------------------------
--------------------------------------------------------------------------------

local draw_quad = function(xtile, ytile, xquad, yquad, tile, tileset, tilemap)
  local xpix = xtile * graphics.tile_size
  local ypix = ytile * graphics.tile_size
  xpix = xpix + ((xquad + 1) / 2) * graphics.quad_size
  ypix = ypix + ((yquad + 1) / 2) * graphics.quad_size
  local h = tilemap:get_tile(xtile + xquad, ytile) == tile
  local v = tilemap:get_tile(xtile, ytile + yquad) == tile
  local d = tilemap:get_tile(xtile + xquad, ytile + yquad) == tile
  local quad = graphics.get_tileset_quad(tile, xquad, yquad, h, v, d)
  love.graphics.draw(tileset, quad, xpix, ypix)
end

local draw_tile = function(xtile, ytile, tile, tileset, tilemap)
  for y = -1, 1, 2 do
    for x = -1, 1, 2 do
      draw_quad(xtile, ytile, x, y, tile, tileset, tilemap)
    end
  end
end

--------------------------------------------------------------------------------
--public variables--------------------------------------------------------------
--------------------------------------------------------------------------------

local Tilemap = Component:new()

function Tilemap:load()
  self.data = utils.read_table("data/tilemap/" .. self.tilemap)
end

function Tilemap:draw_tilemap()
  local tileset = resource.get("tileset", self.tileset)
  for index, tile in ipairs(self.data.array) do
    index = index - 1
    local x = index % self.data.width
    local y = math.floor(index / self.data.height)
    draw_tile(x, y, tile, tileset, self)
  end
end

function Tilemap:get_save()
  return self:get_partial_save("tileset", "tilemap")
end

function Tilemap:get_tile(x, y)
  return self.data.array[(x + y * self.data.width) + 1]
end

return Tilemap
