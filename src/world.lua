local resource = require "src/resource"
local graphics = require "src/graphics"
local utils = require "src/utils/utils"

--------------------------------------------------------------------------------
--private variables-------------------------------------------------------------
--------------------------------------------------------------------------------

-- The list of components in the world.
local components = {}

-- Will make a component a prototype of its snippet.
local prototype = function(component)
  local snippet = resource.get("component", component.__name)
  setmetatable(component, {__index = snippet})
end

--------------------------------------------------------------------------------
--public variables--------------------------------------------------------------
--------------------------------------------------------------------------------

-- Use to map a function on all the components.
local map = function(fun)
  assert(fun, "No function specified to map")
  for _, component in pairs(components) do
    fun(component)
  end
end

-- Return all components that matches the filter.
local all = function(filter)
  assert(filter, "No filter specified")
  local filtered = {}
  for component_id, component in pairs(components) do
    if filter(component) then filtered[component_id] = component end
  end
  return filtered
end

-- Return the first component that matches the filter.
local any = function(filter)
  assert(filter, "No filter specified")
  for _, component in pairs(components) do
    if filter(component) then return component end
  end
end

-- Return the component specified by its name and its entity
local get = function(entity, component)
  assert(entity, "No entity specified")
  assert(component, "No component specified")
  result = components[entity .. "__" .. component]
  assert(result, "No component: " .. entity  .. "_" .. component)
  return result
end

-- Return true if the component specified by its name and its entity exists.
local exists = function(entity, component)
  assert(entity, "No entity specified")
  assert(component, "No component specified")
  return components[entity .. "__" .. component] ~= nil
end

-- Use to set the world to a specific folder.
local load = function(world_name)
  components = utils.read_table("data/world/" .. world_name)
  map(prototype)
end

--------------------------------------------------------------------------------
-- The singleton interface that could be accessed from everywhere
return {load = load,
        map = map,
        all = all,
        any = any,
        get = get,
        exists = exists}
