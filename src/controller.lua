local controller = {}

function controller.call_entity(call, entity, turn_state, cluster, tilemap, resource, ...)
  for component_name, _ in pairs(entity) do
    local component = resource.component[component_name]
    if component ~= nil then
      if component[call] ~= nil then
        component[call](entity, turn_state, cluster, tilemap, resource, ...)
      end
    end
  end
end

function controller.call_cluster(call, cluster, turn_state, tilemap, resource, ...)
  for _, entity in pairs(cluster) do
    controller.call_entity(call, entity, turn_state, cluster, tilemap, resource, ...)
  end
end

return controller
