local graphics = require "src/graphics"
local controller = require "src/controller"

function love.load(arg)
  controller:load_gamestate()
end

function love.update(dt)
  controller:call_cluster("update", dt)
end

function love.keypressed(key, scancode, isrepeat)
  controller:call_cluster("keypressed", key)
end

function love.draw()
  love.graphics.scale(2, 2)
  graphics.draw_tileset(controller.gamestate.tilemap, controller.resource.tileset.ascii)
  graphics.debug(controller)
  controller:call_cluster("draw")
end
