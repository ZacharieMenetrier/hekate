local utils = require "src/utils"
local resource = require "src/resource"
local world = require "src/world"

--------------------------------------------------------------------------------
--private variables-------------------------------------------------------------
--------------------------------------------------------------------------------

--! @brief Enclose a call with its argument, ready to take a component.
local do_call = function(call, ...)
  params = utils.pack(...)
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

-- Call a function on aa cluster of components.
local call_cluster = function(call, cluster, ...)
  assert(call, "No call specified")
  assert(cluster, "No cluster specified")
  assert(type(call) == "string", "The call is not a string")
  return map(do_call(call, ...), cluster)
end

-- Return the fisrt non-null response from a cluster of components.
local call_any = function(call, cluster, ...)
  assert(call, "No call specified")
  assert(cluster, "No cluster specified")
  assert(type(call) == "string", "The call is not a string")
  return any(do_call(call, ...), cluster)
end

local call_world = function(call, ...)
  return call_cluster(call, world.all(), ...)
end

local call_world_any = function(call, ...)
  return call_any(call, world.all(), ...)
end

--------------------------------------------------------------------------------
-- The singleton interface that could be accessed from everywhere
return {call_cluster = call_cluster,
        call_any = call_any,
        call_world = call_world,
        call_world_any = call_world_any}
