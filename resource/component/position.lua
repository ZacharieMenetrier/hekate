local Component = require "resource/component/component"
local controller = require "src/controller"
local graphics = require "src/graphics"

--- A component that makes an entity exists in a tile.
-- @classmod position
local Position = Component:new()

--- Return true if the entity is a the tile specified by x and y.
function Position:is_at_tile(x, y)
  if self.x == x and self.y == y then return self end
end

return Position
