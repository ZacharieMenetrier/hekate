local Component = require "resource/component/component"
local utils = require "src/utils/utils"
local graphics = require "src/graphics"
local resource = require "src/resource"
local world = require "src/world"
local math = require "math"

--------------------------------------------------------------------------------
--private variables-------------------------------------------------------------
--------------------------------------------------------------------------------

--! @brief Draw a quad of the tilemap.
local draw_quad = function(x, y, xq, yq, tile, tileset, tilemap, xpix, ypix, xi, yi)
  -- Get the horizontal neighbour.
  local h = tilemap:get_tile(x + xq, y) == tile
  -- Get the vertical neighbour.
  local v = tilemap:get_tile(x, y + yq) == tile
  -- Get the diagonal neighbour.
  local d = tilemap:get_tile(x + xq, y + yq) == tile
  -- Get the corresponding quad.
  local quad = graphics.get_tileset_quad(tile, xi, yi, h, v, d)
  love.graphics.draw(tileset, quad, xpix, ypix)
end

--! @brief Draw a tile of the tilemap.
local draw_tile = function(x, y, tile, tileset, tilemap)
  local xpix = x * graphics.tile_size
  local ypix = y * graphics.tile_size
  -- The quad size will be used to shift the x and y in the quads.
  local qs = graphics.quad_size
  -- Draw the four quads of the tile.
  draw_quad(x, y, -1, -1, tile, tileset, tilemap, xpix, ypix, 0, 0)
  draw_quad(x, y, -1, 1, tile, tileset, tilemap, xpix, ypix + qs, 0, 1)
  draw_quad(x, y, 1, -1, tile, tileset, tilemap, xpix + qs, ypix, 1, 0)
  draw_quad(x, y, 1, 1, tile, tileset, tilemap, xpix + qs, ypix + qs, 1, 1)
end

--------------------------------------------------------------------------------
--public variables--------------------------------------------------------------
--------------------------------------------------------------------------------

local Tilemap = Component:new()

function Tilemap:load()
  self.data = utils.read_table("data/tilemap/" .. self.tilemap)
end

function Tilemap:draw_tilemap()
  local camera = world.get("system", "camera")
  local tileset = resource.get("tileset", self.tileset)
  -- Get the position of all visible tiles.
  local tiles = camera:tiles_visibles()
  -- Draw only visible tiles.
  for _, tile_position in ipairs(tiles) do
    local tile = self:get_tile(tile_position.x, tile_position.y)
    draw_tile(tile_position.x, tile_position.y, tile, tileset, self)
  end
end

function Tilemap:get_save()
  return self:get_partial_save("tileset", "tilemap")
end

function Tilemap:get_tile(x, y)
  if x < 0 then return 5 end
  if y < 0 then return 5 end
  if x >= self.data.width then return 5 end
  if y >= self.data.height then return 5 end
  return self.data.array[(x + y * self.data.width) + 1]
end

return Tilemap
