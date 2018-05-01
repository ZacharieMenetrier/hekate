local controller = {}

-- Call a given entity
function controller.call_entity(call, entity, gamestate, resource, ...)
  for component_name, _ in pairs(entity) do
    local component = resource.component[component_name]
    if component ~= nil then
      if component[call] ~= nil then
        component[call](entity, gamestate, resource, ...)
      end
    end
  end
end

-- Call all entites in cluster
function controller.call_cluster(call, gamestate, resource, ...)
  for _, entity in pairs(gamestate.cluster) do
    controller.call_entity(call, entity, gamestate, resource, ...)
  end
end

-- Does this entity have any actions left ?
function controller.get_action_left(entity)
  local action = entity.action
  if not action then return 0 end
  return action.left
end

return controller
