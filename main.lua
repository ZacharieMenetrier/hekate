local controller = require "src/controller"
local resource = require "src/resource"
local graphics = require "src/graphics"
local world = require "src/world"

--------------------------------------------------------------------------------

function love.load(arg)
  resource.load()
  world.load("test")
  controller.call_world("load")
end

--------------------------------------------------------------------------------

function love.update(dt)
  controller.call_world("update", dt)
end

--------------------------------------------------------------------------------

function love.keypressed(key, scancode, isrepeat)
  controller.call_world("keypressed", key, scancode, isrepeat)
end

--------------------------------------------------------------------------------

function love.mousepressed(x, y, button, isTouch)
  controller.call_world("mousepressed", x, y, button, isTouch)
end

--------------------------------------------------------------------------------

function love.draw()
  love.graphics.push()
  controller.call_world("prepare_draw")
  controller.call_world("draw_layer_0")
  controller.call_world("draw_layer_1")
  love.graphics.pop()
  controller.call_world("draw_ui")
  graphics.debug()
end
