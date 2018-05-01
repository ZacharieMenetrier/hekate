local controller = {gamestate = require "src/gamestate",
                    resource = require "src/resource"}

function controller:load_gamestate()
  self.gamestate:load_gamestate()
end

function controller:next_turn()
  self:call_cluster("end")
  self.gamestate:next_turn()
  self:call_cluster("begin")
end

function controller:call_entity(call, entity, ...)
  for component_name, _ in pairs(self.gamestate.entity) do
    local component = self.resource.component[component_name]
    if component ~= nil then
      if component[call] ~= nil then
        component[call](entity, self, ...)
      end
    end
  end
end

function controller:call_current(call, ...)
  self:call_entity(call, self.gamestate.entity, ...)
end

function controller:call_cluster(call, ...)
  for _, entity in pairs(self.gamestate.cluster) do
    self:call_entity(call, entity, ...)
  end
end

function controller:get_action_left()
  local action = self.gamestate.entity.action
  if not action then return 0 end
  return action.left
end

return controller
