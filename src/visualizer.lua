local queue = require "src/utils/queue"
local graphics = require "src/graphics"

local visualizer = {}


-- The visualizer contains a queue of actions to visualize. These are
-- function calls, and will be called as-is.

-- TODO pass the visualizer as argument in controller calls so entites can add
-- things to this queue when they are called, OR modify it (ie. for combos)

visualizer.visual_queue = queue.new()

function visualizer.add_visualisation(visual_call)
  -- Visual call should be a table of the form {function(args)}
  queue.push_action_last(visualizer.visual_queue, visual_call)
end


-- This will be called by love.draw
-- TODO find out precisely when : once all visual actions have been drawn,
-- the regular entity drawing will resume and ensure we start from a clean slate

function visualizer.visualize_one()
  action_to_visualize = queue.pop_first_action(visualizer.visual_queue)
  for k,v in ipairs(t) do k(v) end -- Run the visual actions
  return action_to_visualize
end

function visualizer.visualize_all()
  while queue.is_queue_not_empty(visualizer.visual_queue) do visualize.visualize_one() end
end


------------------------- ROOT VISUAL FUNCTIONS --------------------------------
-- Draw the world, no relation to the action queue

function visualizer.draw_world(controller)
  -- Draw the tilemap
  graphics.draw_tileset(controller.gamestate.tilemap, controller.resource.tileset.ascii)

  -- Draw the entities
  for _, entity in ipairs(controller.gamestate.cluster) do
    local sprite = controller.resource.sprite["pig"]
    local xpix = entity.position.x * graphics.tile_size
    local ypix = entity.position.y * graphics.tile_size
    love.graphics.draw(sprite, xpix, ypix)
  end
end


function visualizer.draw_interface(controller)
  -- If the interface is the first thing you draw, call graphics.init
  graphics.init()

  -- Draw a circle around the current entity
  local entity = controller.gamestate.entity
  local xpix = entity.position.x * graphics.tile_size + graphics.tile_size / 2
  local ypix = entity.position.y * graphics.tile_size + graphics.tile_size / 2
  love.graphics.circle("fill", xpix, ypix, graphics.tile_size * 0.66)

  -- Draw the action lefts
  local action_left = controller:get_action_left()
  love.graphics.print(action_left, 20, 20)
end





return visualizer
