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

-- Enclose a call to an entity with its argument, ready to take a component.
local do_call_entity = function(call, entity, ...)
  params = utils.pack(...)
  return function(component)
    if component[call] == nil then return end
    if component.__entity ~= entity then return end
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
local call_world_any = function(call, ...)
  assert(call, "No call specified")
  return world.any(do_call(call, ...))
end

-- Call a function on all components of the entity.
local call_entity = function(call, entity, ...)
  assert(call, "No call specified")
  assert(entity, "No entity specified")
  return world.map(do_call_entity(call, entity, ...))
end

-- Return the first non-null response from all the components of an entity.
local call_entity_any = function(call, entity, ...)
  assert(call, "No call specified")
  assert(entity, "No entity specified")
  return world.any(do_call_entity(call, entity, ...))
end

--------------------------------------------------------------------------------
-- The singleton interface that could be accessed from everywhere
return {call_world = call_world,
        call_world_any = call_world_any,
        call_entity = call_entity,
        call_entity_any = call_entity_any}
