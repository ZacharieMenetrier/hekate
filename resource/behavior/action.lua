local action = {}

function action.begin(entity)
  entity.action.left = entity.action.right
end

function action.remove_action(entity)
  entity.action.left = entity.action.left - 1
end

return action
