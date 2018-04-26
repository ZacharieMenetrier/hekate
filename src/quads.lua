local utils = require "src/utils"
local metrics = require "metrics"


local quads = {}
local tile_size = metrics.tile_size
local total_width = metrics.tile_size * metrics.tileset_size
for x, y in utils.itergrid(metrics.tileset_size) do
  local xpix = tile_size * x
  local ypix = tile_size * y
  quads[x][y] = love.graphics.newQuad(xpix, ypix, tile_size, tile_size,
                                              total_width, total_width)
end

return quads
