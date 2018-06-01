--- A module responsible of holding some graphical facilities.
local graphics = {}

--- The number of pixels in a row of a tile.
graphics.tile_size = 32
--- The number of pixels in a row of a quad of a tile.
graphics.quad_size = 16

--------------------------------------------------------------------------------
--private variables-------------------------------------------------------------
--------------------------------------------------------------------------------

-- The number of quads in a row of a tileset.
local quads_per_tileset = 16
-- The quads of the tileset.
local tileset_quads = {}

-- Calculate the quads for the tileset.
do
  local tileset_size = 256
  local qs = graphics.quad_size
  local ts = tileset_size
  local nq = love.graphics.newQuad
  for y = 0, quads_per_tileset - 1 do
    for x = 0, quads_per_tileset - 1 do
      local xpx = x * qs
      local ypx = y * qs
      local quad = nq(xpx, ypx, qs, qs, ts, ts)
      tileset_quads[x + y * quads_per_tileset] = quad
    end
  end
end

-- The ratio of variation for each kind of tile.
local tile_variation = {}
tile_variation[3] = 0.005
tile_variation[4] = 0
tile_variation[5] = 0
tile_variation[6] = 0.01
tile_variation[7] = 0.05


--- Return a tileset quad given the tile and its neighbour.
-- @param tile: The number representing the kind of tile to evaluate.
-- @param x: The x position of the tile.
-- @param y: The y position of the tile.
-- @param h: Is there an horizontal neighbour ?
-- @param v: Is there a vertical neighbour ?
-- @param d: Is there a diagonal neighbour ?
-- @param seed: The seed to randomize the tile.
function graphics.get_tileset_quad(tile, x, y, h, v, d, seed)
  love.math.setRandomSeed(seed)
  y = y + tile * 2
  local shift = 0
  if h and v then
    if d then
      shift = 4
      if love.math.random() < tile_variation[tile] then
        shift = shift + love.math.random(1, 3)
      end
    else
      shift = 3
    end
  end
  if h and not v then shift = 2 end
  if v and not h then shift = 1 end
  return tileset_quads[x + shift * 2 + y * quads_per_tileset]
end

--- Return the tile position given a pixel position.
-- @param x: The x in pixel.
-- @param y: The y in pixel.
-- @param scale: The scale of the camera.
function graphics.pixel_to_tile(x, y, scale)
  local tile_size = graphics.tile_size
  return math.floor(x / scale / tile_size), math.floor(y / scale / tile_size)
end

--- Return the pixel position given a tile position.
-- @param x: The x in tile.
-- @param y: The y in tile.
function graphics.tile_to_pixel(x, y)
  local tile_size = graphics.tile_size
  return math.floor(x * tile_size), math.floor(y * tile_size)
end

return graphics
