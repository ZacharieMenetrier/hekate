local matrix = require "src/helper/matrix"
--------------------------------------------------------------------------------

-- This is kind of a system in the sense it will iterate the entities
-- and perform some action if they contains a sprite and a position component.
local graphics = {}

graphics.tile_size = 16
graphics.tileset_size = 16

-- Creation of the quads for the tileset
-- For now it is not very modular.
-- Maybe tileset and quads should be defined by importation of a tileset.
local quads = {}
local tile_size = graphics.tile_size
local tileset_size = graphics.tileset_size
local total_width = tile_size * tileset_size
for x, y in matrix.iter_square(tileset_size) do
  local xpix = tile_size * (x - 1)
  local ypix = tile_size * (y - 1)
  local index = (x - 1) + (y - 1) * tile_size
  quads[index] = love.graphics.newQuad(xpix, ypix, tile_size, tile_size,
                                       total_width, total_width)
end

function graphics.debug(controller)
  local entity = controller.gamestate.entity
  local xpix = entity.position.x * graphics.tile_size + graphics.tile_size / 2
  local ypix = entity.position.y * graphics.tile_size + graphics.tile_size / 2
  love.graphics.circle("fill", xpix, ypix, graphics.tile_size * 0.66)
  -- Draw the action lefts
  local action_left = controller:get_action_left()
  love.graphics.print(action_left, 20, 20)
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

return graphics
