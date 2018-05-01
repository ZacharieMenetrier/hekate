local controller = {gamestate = require "src/gamestate",
                    resource = require "src/resource"}

<<<<<<< HEAD
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
=======
-- Call a given entity
function controller.call_entity(call, entity, gamestate, resource, ...)
  for component_name, _ in pairs(entity) do
    local component = resource.component[component_name]
>>>>>>> 6f765063e3883217c0f3f81f42b41d5bc8773d87
    if component ~= nil then
      if component[call] ~= nil then
        component[call](entity, self, ...)
      end
    end
  end
end

<<<<<<< HEAD
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
=======
-- Call all entites in cluster
function controller.call_cluster(call, gamestate, resource, ...)
  for _, entity in pairs(gamestate.cluster) do
    controller.call_entity(call, entity, gamestate, resource, ...)
  end
end

-- Does this entity have any actions left ?
function controller.get_action_left(entity)
  local action = entity.action
>>>>>>> 6f765063e3883217c0f3f81f42b41d5bc8773d87
  if not action then return 0 end
  return action.left
end

return controller
