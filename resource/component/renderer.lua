local Component = require "resource/component/component"
local graphics = require "src/graphics"
local resource = require "src/resource"
local utils = require "src/utils"
local world = require "src/world"

local Renderer = Component:new()

function Renderer:load()
  -- Temporary hack
  if self.__entity == "tom" then
    self.animation = resource.get("animation", "test")
    self.animation:setTag("Tag")
    self.animation:play()
  end
  local position = world.get(self.__entity, "position")
  self.x = position.x * graphics.tile_size
  self.y = position.y * graphics.tile_size
end

function Renderer:update(dt)
  local position = world.get(self.__entity, "position")
  if self.animation ~= nil then self.animation:update(dt) end
  local x = position.x * graphics.tile_size
  local y = position.y * graphics.tile_size
  self.x = utils.lerp(self.x, x, dt, self.speed)
  self.y = utils.lerp(self.y, y, dt, self.speed)
end

function Renderer:draw_actor()
  -- Draw the animation if you have one
  if self.animation ~= nil then
    self.animation:draw(self.x, self.y - 32)
  -- Else just draw your static sprite
  else
    local position = world.get(self.__entity, "position")
    local x, y = graphics.tile_to_pixel(position.x, position.y)
    love.graphics.draw(resource.get("sprite", self.sprite), x, y)
  end
end

function Renderer:get_draw_order()
  local position = world.get(self.__entity, "position")
  return position.y
end

function Renderer:get_save()
  return self:get_partial_save("sprite", "speed", "yoffset")
end

return Renderer
