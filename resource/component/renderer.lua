local Component = require "resource/component/component"
local graphics = require "src/graphics"
local resource = require "src/resource"
local utils = require "src/utils"
local world = require "src/world"

--------------------------------------------------------------------------------

local Renderer = Component:new()

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

function Renderer:draw_actor()
  local sprite = resource.get("sprite", self.sprite)
  love.graphics.draw(sprite, self.x, self.y - 32)
end

function Renderer:get_draw_order()
  local sprite = resource.get("sprite", self.sprite)
  local position = world.get(self.__entity, "position")
  return position.y
end

function Renderer:get_save()
  return self:get_partial_save("sprite", "speed", "yoffset")
end

return Renderer
