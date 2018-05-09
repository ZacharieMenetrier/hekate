local Action = {}

function Action.remove_action(entity, controller)
  entity.action.left = entity.action.left - 1
  if entity.action.left <= 0 then
    entity.action.left = entity.action.right
    controller:next_turn()
  end
end

return Action
