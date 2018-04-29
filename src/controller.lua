local controller = {}

-- The controller has access to queue_action and will add new actions to it when
-- its functions are called.

function controller.update(entity)
  print(queue_action)
  local team = entity.team
  if team == "computer" then
    local action = function()
      entity.position.y = entity.position.y + 1
    end
    queue_action(action)
  end
end

function controller.keypressed(entity, key)
  local team = entity.team
  if team == "player" then
    if key == "space" then
      local action = function()
        entity.position.x = entity.position.x + 1
      end
      queue_action(action)
    end
  end
end

return controller
