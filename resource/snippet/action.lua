local Action = {}

function Action.begin(entity)
  entity.action.left = entity.action.right
end

function Action.remove_action(entity)
  entity.action.left = entity.action.left - 1
end

return Action
