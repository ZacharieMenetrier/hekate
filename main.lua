local controller = require "src/controller"
local resource = require "src/resource"
local camera = require "src/camera"
local world = require "src/world"

--------------------------------------------------------------------------------

function love.load(arg)
  love.graphics.setDefaultFilter("nearest", "nearest")
  resource.load()
  world.load("test")
  controller.call_world("load")
end

--------------------------------------------------------------------------------

function love.update(dt)
  camera.update(dt)
  controller.call_world("update", dt)
end

--------------------------------------------------------------------------------

function love.keypressed(key, scancode, isrepeat)
  controller.call_world("keypressed", key, scancode, isrepeat)
end

--------------------------------------------------------------------------------

function love.draw()
  camera.draw()
  world.draw_tilemap()
  controller.call_world("draw")
end
