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
  -- Make the call effective
  for component_name, _ in pairs(entity) do
    local behavior = self.resource.behavior[component_name]
    if behavior[call] ~= nil then
      behavior[call](entity, self, ...)
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

-- Return the number of actions lefft to the current entity
function controller:get_action_left()
  local action = self.gamestate.entity.action
  if not action then return 0 end
  return action.left
end

function controller:get_tile_at(x, y)
  return self.gamestate.tilemap[x + 1][y + 1]
end

return controller
