--------------------------------------------------------------------------------
--public variables--------------------------------------------------------------
--------------------------------------------------------------------------------

local tile_size = 32

-- Use to get the quads of a specific tileset.
local get_quads = function(tileset)
  assert(tileset, "No tileset specified")
  local width = tileset:getWidth()
  local height = tileset:getHeight()
  local tile_width = width / tile_size
  local tile_height = height / tile_size
  local quads = {}
  for y = 0, tile_height do
    for x = 0, tile_width do
      local xpix = x * tile_size
      local ypix = y * tile_size
      local index = (x + y * tile_width) + 1
      quads[index] = love.graphics.newQuad(xpix, ypix,
                                           tile_size, tile_size,
                                           width, height)
    end
  end
  return quads
end

-- Use to draw a tilemap given a tileset.
local draw_tilemap = function(tilemap, tileset)
  assert(tilemap, "No tilemap specified")
  assert(tileset, "No tileset specified")
  assert(tilemap.array, "The tilemap has no array associed")
  assert(tilemap.height, "The tilemap has no height associed")
  assert(tilemap.width, "The tilemap has no width associed")
  for y = 0, tilemap.height - 1 do
    for x = 0, tilemap.width - 1 do
      local xpix = x * tile_size
      local ypix = y * tile_size
      local index = (x + y * tilemap.width) + 1
      local tile = tilemap.array[index]
      assert(tile, "No tile described at: " .. x .. ", " .. y .. " = " .. index)
      assert(tileset.quads[tile], "No quads for tileset: " .. tile)
      love.graphics.draw(tileset.sprite, tileset.quads[tile], xpix, ypix)
    end
  end
end

-- Debug draw some stuffs in a top bar.
local debug = function()
  love.graphics.setColor(0, 0, 0, 0.8)
  love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), 25)
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.print(love.timer.getFPS(), 4, 4)
end

--------------------------------------------------------------------------------
-- The singleton interface that could be accessed from everywhere
return {tile_size = tile_size,
        get_quads = get_quads,
        draw_tilemap = draw_tilemap,
        debug = debug}
