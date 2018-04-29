ai = {}


-- This is the main hub function, the AI will then call other functions to help
-- it decide which order to give
function ai.give_order_to_entity(entity)
  return ai.simple_move(entity) -- For now simple move only
end

--------------------------- AI DECISION FUNCTIONS ------------------------------

function ai.simple_move(entity)
  local action = function()
    entity.position.y = entity.position.y + 1
  end
  return action
end




return ai
