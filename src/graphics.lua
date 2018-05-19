--------------------------------------------------------------------------------
--private variables--------------------------------------------------------------
--------------------------------------------------------------------------------

local scale = 2
local tile_size = 32
local quads_per_tileset = 16
local tileset_size = 256
local quad_size = 16
local tileset_quads = {}


local nq = love.graphics.newQuad
for y = 0, quads_per_tileset - 1 do
  for x = 0, quads_per_tileset - 1 do
    local xpx = x * quad_size
    local ypx = y * quad_size
    local quad = nq(xpx, ypx, quad_size, quad_size, tileset_size, tileset_size)
    tileset_quads[x + y * quads_per_tileset] = quad
  end
end

--------------------------------------------------------------------------------
--public variables--------------------------------------------------------------
--------------------------------------------------------------------------------

local get_tileset_quad = function(tile, xq, yq, h, v, d)
  local y = tile * 2
  local x = (xq + 1) / 2
  local y = y + (yq + 1) / 2
  local shift = 0
  if h and v and d then shift = 4 end
  if h and v and not d then shift = 3 end
  if h and not v then shift = 2 end
  if v and not h then shift = 1 end
  return tileset_quads[x + shift * 2 + y * quads_per_tileset]
end

--------------------------------------------------------------------------------
-- The singleton interface that could be accessed from everywhere.
return {tile_size = tile_size,
        scale = scale,
        quad_size = quad_size,
        get_tileset_quad = get_tileset_quad}
