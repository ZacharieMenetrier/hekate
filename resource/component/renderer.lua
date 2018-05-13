local graphics = require "src/graphics"
local resource = require "src/resource"
local utils = require "src/utils/utils"
local world = require "src/world"

--------------------------------------------------------------------------------

local Renderer = {}

function Renderer:load()
  local position = world.get(self.__entity, "position")
  self.x = position.x * graphics.tile_size
  self.y = position.y * graphics.tile_size
end

function Renderer:update(dt)
  local position = world.get(self.__entity, "position")
  local x = position.x * graphics.tile_size
  local y = position.y * graphics.tile_size
  self.x = utils.lerp(self.x, x, dt, self.speed)
  self.y = utils.lerp(self.y, y, dt, self.speed)
end

function Renderer:draw_layer_1()
  local sprite = resource.get("sprite", self.sprite)
  love.graphics.draw(sprite, self.x, self.y)
end

return Renderer
