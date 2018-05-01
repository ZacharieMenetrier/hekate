local queue = require "src/utils/queue"

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

function visualize.visualize_one()
  action_to_visualize = queue.pop_first_action(visualizer.visual_queue)
  for k,v in ipairs(t) do k(v) end -- Run the visual actions
  return action_to_visualize
end

function visualizer.visualize_all()
  while queue.is_queue_not_empty(visualizer.visual_queue) do visualize.visualize_one() end
end

return visualizer
