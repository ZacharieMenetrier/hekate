-- public
local scale = 2
-- public
local tile_size = 32
-- public
local quad_size = 16

--------------------------------------------------------------------------------
--private variables-------------------------------------------------------------
--------------------------------------------------------------------------------

local quads_per_tileset = 16
local tileset_quads = {}

-- Calculate the quads for the tileset.
do
  local tileset_size = 256
  local qs = quad_size
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

--------------------------------------------------------------------------------
--public variables--------------------------------------------------------------
--------------------------------------------------------------------------------

--! @brief Return a tileset quad given the tile and its neighbour.
local get_tileset_quad = function(tile, x, y, h, v, d, seed)
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

local pixel_to_tile = function(x, y)
  return math.floor(x / scale / tile_size), math.floor(y / scale / tile_size)
end

local tile_to_pixel = function(x, y)
  return math.floor(x * tile_size), math.floor(y * tile_size)
end

--------------------------------------------------------------------------------
-- The singleton interface that could be accessed from everywhere.
return {tile_size = tile_size,
        scale = scale,
        quad_size = quad_size,
        tile_to_pixel = tile_to_pixel,
        pixel_to_tile = pixel_to_tile,
        get_tileset_quad = get_tileset_quad}
