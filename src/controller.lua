local controller = {gamestate = require "src/gamestate",
                    resource = require "src/resource"}


function controller:load_gamestate()
  self.gamestate:load_gamestate(self)
end

function controller:next_turn()
  self:call_cluster("end")
  self.gamestate:next_turn()
  self:call_cluster("begin")
end

-- Call a given entity
function controller:call_entity(call, entity, ...)
  for component_name, _ in pairs(entity) do
    local component = self.resource.component[component_name]
    if component[call] ~= nil then
      component[call](entity, self, ...)
    end
  end
end

function controller:alter_gamestate(modification, name, params)
  self:call_cluster("anticipate", modification, name, params)
  modification(params)
  self:call_cluster("react", modification, name, params)
end

function controller:call_current(call, ...)
  self:call_entity(call, self.gamestate.entity, ...)
end

-- Call all entites in cluster
function controller:call_cluster(call, ...)
  for _, entity in pairs(self.gamestate.cluster) do
    self:call_entity(call, entity, ...)
  end
end

-- Does this entity have any actions left ?
function controller:get_action_left()
  local action = self.gamestate.entity.action
  if not action then return 0 end
  return action.left
end

return controller
