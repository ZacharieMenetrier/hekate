local graphics = require "src/graphics"
local resource = require "src/resource"
local world = require "src/world"

--------------------------------------------------------------------------------

local Renderer = {}

function Renderer:draw()
  local position = world.get(self.__entity, "position")
  local sprite = resource.get("sprite", self.sprite)
  local x = position.x * graphics.tile_size
  local y = position.y * graphics.tile_size
  love.graphics.draw(sprite, x, y)
end

return Renderer
