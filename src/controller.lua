local world = require "src/world"
local resource = require "src/resource"
local utils = require "src/utils/utils"

--------------------------------------------------------------------------------
--private variables-------------------------------------------------------------
--------------------------------------------------------------------------------

local do_call = function(call, ...)
  params = utils.pack(...)
  return function(component)
    if component[call] == nil then return end
    component[call](component, unpack(params))
  end
end

--------------------------------------------------------------------------------
--public variables--------------------------------------------------------------
--------------------------------------------------------------------------------

local call_world = function(call, ...)
  assert(call, "No call specified")
  world.map(do_call(call, ...))
end

--------------------------------------------------------------------------------
return {call_world = call_world}
