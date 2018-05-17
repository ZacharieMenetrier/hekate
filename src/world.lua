local resource = require "src/resource"
local graphics = require "src/graphics"
local utils = require "src/utils/utils"

--------------------------------------------------------------------------------
--private variables-------------------------------------------------------------
--------------------------------------------------------------------------------

--! @brief The list of components in the world.
local components = {}

--! @brief Will make a component a prototype of its snippet.
local prototype = function(component)
  local snippet = resource.get("component", component.__name)
  setmetatable(component, {__index = snippet})
end

-- Enclose a filter ready to take a component.
local do_filter = function(filter)
  return function(component)
    if filter(component) then return component end
  end
end

local map = function(fun)
  assert(fun, "No function specified")
  for _, component in pairs(components) do
    fun(component)
  end
end

--------------------------------------------------------------------------------
--public variables--------------------------------------------------------------
--------------------------------------------------------------------------------

-- Return all the components in the world.
local all = function()
  return components
end

-- Return the component specified by its name and its entity.
local get = function(entity, component)
  assert(entity, "No entity specified")
  assert(component, "No component specified")
  result = components[entity .. "__" .. component]
  assert(result, "No component: " .. entity  .. "_" .. component)
  return result
end

--! @brief Return all the components that match the filter.
local select = function(filter)
  assert(filter, "No filter specified")
  return map(do_filter(filter))
end

--! @brief Return true if the component specified by its name and its entity exists.
local exists = function(entity, component)
  assert(entity, "No entity specified")
  assert(component, "No component specified")
  return components[entity .. "__" .. component] ~= nil
end

--! @brief Use to set the world to a specific folder.
local load = function(world_name)
  assert(world_name, "No world name specified")
  components = utils.read_table("data/world/" .. world_name)
  map(prototype, components)
end

--------------------------------------------------------------------------------
-- The singleton interface that could be accessed from everywhere
return {get = get,
        all = all,
        select = select,
        exists = exists,
        load = load}
