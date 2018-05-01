local graphics = require "src/graphics"
local controller = require "src/controller"
local visualizer = require "src/visualizer"

controller:load_gamestate()

function love.update(dt)
  -- Does the current entity have actions left ?
  local action_left = controller:get_action_left()
  -- If not, move on to the next entity
  if action_left == 0 then
    controller:next_turn()
  -- Otherwise, tell the entity to call "run" on its component.
  else
    controller:call_current("run")
  end
end

function love.keypressed(key, scancode, isrepeat)
  controller:call_cluster("keypressed", key)
end

function love.draw()
  visualizer.draw_interface(controller)
  visualizer.draw_world(controller)
end
