local matrix = require "src/matrix"
--------------------------------------------------------------------------------
local tile_size = 16
local total_width = 16
local tileset_size = 16
local total_width = 256
--------------------------------------------------------------------------------

-- This is kind of a system in the sense it will iterate the entities
-- and perform some action if they contains a sprite and a position component.
local graphics = {}


-- Creation of the quads for the tileset
-- For now it is not very modular.
-- Maybe tileset and quads should be defined by importation of a tileset.
local quads = {}
for x, y in matrix.iter_square(tileset_size) do
  local xpix = tile_size * (x - 1)
  local ypix = tile_size * (y - 1)
  local index = (x - 1) + (y - 1) * tile_size
  quads[index] = love.graphics.newQuad(xpix, ypix, tile_size, tile_size,
                                       total_width, total_width)
end

-- Draw a tilemap with a given tileset.
-- Maybe the tilemap should be an entity too.
function graphics.draw_tileset(tilemap, tileset)
  for x, y, tile in matrix.iter_matrix(tilemap) do
    local xpix = tile_size * (x - 1)
    local ypix = tile_size * (y - 1)
    love.graphics.draw(tileset, quads[tile], xpix, ypix)
  end
end

-- Draw the sprites of the entities.
-- This part totally act like a system.
function graphics.draw_cluster(cluster, loader, filter)
  for entity in filter(cluster, {"sprite", "position"}) do
    local sprite = loader.sprite[entity.sprite.name]
    local position = entity.position
    love.graphics.draw(sprite, position.x * tile_size, position.y * tile_size)
  end
end

return graphics
