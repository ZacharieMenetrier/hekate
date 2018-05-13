local controller = require "src/controller"
local graphics = require "src/graphics"

local Position = {}

function Position:to_pixel()
  local half_tile = graphics.tile_size / 2
  local x = self.x * graphics.tile_size - half_tile
  local y = self.y * graphics.tile_size - half_tile
  return x, y
end

function Position:move(x, y)
  self.x = self.x + x
  self.y = self.y + y
end

return Position
