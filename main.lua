local controller = require "src/controller"
local resource = require "src/resource"
local graphics = require "src/graphics"
local world = require "src/world"

--------------------------------------------------------------------------------

function love.load(arg)
  resource.load()
  world.load("test")
  controller.call_world("load")
  love.graphics.setNewFont("resource/font/PixelHekate.ttf", 16)
end

--------------------------------------------------------------------------------

function love.update(dt)
  controller.call_world("update", dt)
end

--------------------------------------------------------------------------------

function love.keypressed(key, scancode, isrepeat)
  if key == "p" then
    local c = world.get("bob", "renderer")
    c:destroy()
  end
  controller.call_world("keypressed", key, scancode, isrepeat)
end

--------------------------------------------------------------------------------

function love.mousepressed(x, y, button, isTouch)
  controller.call_world("mousepressed", x, y, button, isTouch)
end

--------------------------------------------------------------------------------

function love.wheelmoved(x, y)
  controller.call_world("wheelmoved", x, y)
end

--------------------------------------------------------------------------------

function love.resize(w, h)
  controller.call_world("resize", w, h)
end

--------------------------------------------------------------------------------

function love.draw()
  love.graphics.push()
  love.graphics.scale(graphics.scale, graphics.scale)
  controller.call_world("draw")
  love.graphics.pop()
  controller.call_world("draw_ui")
  love.graphics.print(love.timer.getFPS())
end
