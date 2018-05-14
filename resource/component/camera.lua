local controller = require "src/controller"
local graphics = require "src/graphics"
local utils = require "src/utils/utils"

--------------------------------------------------------------------------------

local Camera = {}

function Camera:load()
  self.lockx = 0
  self.locky = 0
  self.drag = false
end

function Camera:mousepressed(x, y, button)
  if button ~= 2 then return end
  self.lockx = x
  self.locky = y
end

function Camera:update(dt)
  if not love.mouse.isDown(2) then return end
  local xdiff = self.lockx - love.mouse.getX()
  local ydiff = self.locky - love.mouse.getY()
  self.x = self.x + xdiff
  self.y = self.y + ydiff
  self.lockx = love.mouse.getX()
  self.locky = love.mouse.getY()
end

function Camera:early_draw()
  love.graphics.translate(-self.x, -self.y)
end

function Camera:draw()
  local renders = controller.call_world("render")
  local sorted = {}
  for _, render in pairs(renders) do table.insert(sorted, render) end
  table.sort(sorted, function(a, b) return a.z < b.z end)
  for _, render in pairs(sorted) do
    love.graphics.draw(unpack(render.params))
  end
end

return Camera
