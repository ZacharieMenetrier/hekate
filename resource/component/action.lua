local action = {}

function action.begin(entity)
  entity.action.left = entity.action.right
end

function action.take(entity)
  entity.action.left = entity.action.left - 1
end


return action
