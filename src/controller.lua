local utils = require "src/helper/utils"

local controller = {gamestate = require "src/gamestate",
                    resource = require "src/resource"}

function controller:load_gamestate()
  self.gamestate:load_gamestate()
end

function controller:get_components(id)
  return self.gamestate.cluster[id]
end

-- Call a given entity
function controller:call_entity(call, id, ...)
  local components = self.gamestate.cluster[id]
  for component_name, component in pairs(components) do
    local snippet = self.resource.snippet[component_name]
    if snippet ~= nil and snippet[call] ~= nil then
      this = { id = id, components = components }
      snippet[call](this, self, ...)
    end
  end
end

-- Call all entites in cluster
function controller:call_cluster(call, ...)
  for id, _ in pairs(self.gamestate.cluster) do
    self:call_entity(call, id, ...)
  end
end

return controller
