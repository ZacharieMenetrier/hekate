local utils = require "src/helper/utils"

local controller = {gamestate = require "src/gamestate",
                    resource = require "src/resource",
                    block = 0}

function controller:load_gamestate()
  self.gamestate:load_gamestate()
end

function controller:next_turn()
  self:call_cluster("end")
  self.gamestate:next_turn()
  self:call_cluster("begin")
end

-- Call a given entity
function controller:call_entity(call, entity, ...)
  local params = utils.pack(...)
  for component_name, _ in pairs(entity) do
    local snippet = self.resource.snippet[component_name]
    if snippet ~= nil and snippet[call] ~= nil then
      snippet[call](entity, self, unpack(params))
    end
  end
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

function controller:add_block()
 self.block = self.block + 1
end

function controller:remove_block()
  self.block = self.block - 1
end

function controller:is_blocked()
  return self.block > 0
end

-- Return the number of actions lefft to the current entity
function controller:get_action_left()
  local action = self.gamestate.entity.action
  if not action then return 0 end
  return action.left
end

return controller
