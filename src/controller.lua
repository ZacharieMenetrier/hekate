local controller = {}



-- The controller manages the action queue
local queue = require "src/utils/queue"
local action_queue = queue.new()

function controller.queue_action(new_action)
  -- For now the controller automatically pushes actions, later it will perform checks
  queue.push_action_last(action_queue, new_action)
end

function controller.get_pending_action()
  return queue.pop_first_action(action_queue)
end


--
-- function controller.update(entity)
--   local team = entity.team
--   if team == "computer" then
--     local action = function()
--       entity.position.y = entity.position.y + 1
--     end
--     queue_action(action)
--   end
-- end


-------------------------- BELOW : dealing with human input --------------------


function controller.keypressed(entity, key)
  local team = entity.team
  if team == "player" then
    if key == "space" then
      local action = function()
        entity.position.x = entity.position.x + 1
      end
      controller.queue_action(action)
    end
  end
end

return controller
