--- The controller is a module that is used to make call on components.
local controller = {}

local utils = require "src/utils"
local resource = require "src/resource"
local world = require "src/world"

--------------------------------------------------------------------------------
--private variables-------------------------------------------------------------
--------------------------------------------------------------------------------

-- Enclose a call with its argument, ready to take a component.
local do_call = function(call, ...)
  local params = utils.pack(...)
  return function(component)
    if component[call] == nil then return end
    return component[call](component, unpack(params))
  end
end

-- Return the first non-null result from the components.
local any = function(fun, cluster)
  assert(fun, "No function specified to map")
  for _, component in pairs(cluster) do
    local result = fun(component)
    if result then return result end
  end
end

-- Call and return all the results of all the components in the cluster.
local map = function(fun, cluster)
  assert(fun, "No function specified to map")
  local results = {}
  for component_id, component in pairs(cluster) do
    local result = fun(component)
    if result ~= nil then results[component_id] = result end
  end
  return results
end

--------------------------------------------------------------------------------
--public variables--------------------------------------------------------------
--------------------------------------------------------------------------------

--- Call a function on a cluster of components.
-- @param call: A string that specify the command to execute.
-- @param cluster: The cluster of components.
function controller.call_cluster(call, cluster, ...)
  assert(call, "No call specified")
  assert(cluster, "No cluster specified")
  assert(type(cluster) == "table", "The cluster is not a table")
  assert(type(call) == "string", "The call is not a string")
  return map(do_call(call, ...), cluster)
end

--- Return the fisrt non-null response from a cluster of components.
-- @param call: A string that specify the command to execute.
-- @param cluster: The cluster of components.
function controller.call_any(call, cluster, ...)
  assert(call, "No call specified")
  assert(cluster, "No cluster specified")
  assert(type(cluster) == "table", "The cluster is not a table")
  assert(type(call) == "string", "The call is not a string")
  return any(do_call(call, ...), cluster)
end

--- Call a function on all the world's components.
-- @param call: A string that specify the command to execute.
function controller.call_world(call, ...)
  return controller.call_cluster(call, world.all(), ...)
end

--- Return the fisrt non-null response from the components of the world.
-- @param call: A string that specify the command to execute.
function controller.call_world_any(call, ...)
  return controller.call_any(call, world.all(), ...)
end

return controller
