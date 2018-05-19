local resource = require "src/resource"
local graphics = require "src/graphics"
local utils = require "src/utils/utils"

--------------------------------------------------------------------------------
--private variables-------------------------------------------------------------
--------------------------------------------------------------------------------

--! @brief The list of components in the world.
local components = {}

--! @brief The name of the current world.
local name = ""

--! @brief Will make a component a prototype of its snippet.
local prototype = function(component)
  print(component.__name)
  local snippet = resource.get("component", component.__name)
  setmetatable(component, {__index = snippet})
end

--! @brief Enclose a filter, ready to take a component.
local do_filter = function(filter)
  return function(component)
    if filter(component) then return component end
  end
end

--! @brief Enclose the serialization, ready to take a component.
local get_save = function(world_name)
  return function(component)
    return component:get_save(world_name)
  end
end

--! @brief Map a function over all the components.
local map = function(fun)
  assert(fun, "No function specified")
  local results = {}
  for component_id, component in pairs(components) do
    results[component_id] = fun(component)
  end
  return results
end

--------------------------------------------------------------------------------
--public variables--------------------------------------------------------------
--------------------------------------------------------------------------------

--! @brief Return all the components in the world.
local all = function()
  return components
end

--! @brief Return the component specified by its name and its entity.
local get = function(entity, component)
  assert(entity, "No entity specified")
  assert(component, "No component specified")
  local result = components[entity .. "__" .. component]
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
  name = world_name
  components = utils.read_table("data/world/" .. world_name)
  map(prototype)
end

--! @brief Serialize all the components into the world file.
local serialize = function()
  assert(name ~= "", "World not loaded yet")
  local save = map(get_save(name))
  local serialization = ""
  for _, elem in pairs(save) do
    serialization = serialization .. elem .. ",\n"
  end
  utils.write_file("data/world/" .. name, serialization)
end

--------------------------------------------------------------------------------
-- The singleton interface that could be accessed from everywhere
return {get = get,
        all = all,
        select = select,
        exists = exists,
        load = load,
        serialize = serialize}
