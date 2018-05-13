local utils = require "src/utils/utils"
local resource = require "src/resource"
local world = require "src/world"

--------------------------------------------------------------------------------
--private variables-------------------------------------------------------------
--------------------------------------------------------------------------------

-- Enclose a call with its argument, ready to take a component.
local do_call = function(call, ...)
  params = utils.pack(...)
  return function(component)
    if component[call] == nil then return end
    return component[call](component, unpack(params))
  end
end

--------------------------------------------------------------------------------
--public variables--------------------------------------------------------------
--------------------------------------------------------------------------------

-- Call a function on all components of the world.
local call_world = function(call, ...)
  assert(call, "No call specified")
  return world.map(do_call(call, ...))
end

-- Return the fisrt non-null response from all the components of the world.
local call_any = function(call, ...)
  assert(call, "No call specified")
  return world.any(do_call(call, ...))
end

--------------------------------------------------------------------------------
-- The singleton interface that could be accessed from everywhere
return {call_world = call_world,
        question_any = question_any}
