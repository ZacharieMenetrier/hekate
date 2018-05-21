local resource = require "src/resource"
local graphics = require "src/graphics"
local utils = require "src/utils/utils"

--------------------------------------------------------------------------------
--private variables-------------------------------------------------------------
--------------------------------------------------------------------------------

--! The list of components in the world.
local components = {}

--! The name of the current world.
local name = ""

--! Will make a component a prototype of its snippet.
local prototype = function(component)
  local snippet = resource.get("component", component.__name)
  assert(type(snippet) == "table", component.__name .. " is invalid")
  setmetatable(component, {__index = snippet})
end

--! Enclose a filter, ready to take a component.
local do_filter = function(filter)
  return function(component)
    if filter(component) then return component end
  end
end

--! Enclose the serialization, ready to take a component.
local get_save = function(world_name)
  return function(component)
    return component:get_save(world_name)
  end
end

--------------------------------------------------------------------------------
--public variables--------------------------------------------------------------
--------------------------------------------------------------------------------

--! Return all the components that match the filter.
local select = function(filter)
  assert(filter, "No filter specified")
  return utils.map(do_filter(filter), components)
end

--! Return all the components in the world.
local all = function()
  return select(function(c) return true end)
end

--! Add a new component to the world.
local add = function(component)
  assert(component, "No component specified")
  components[component:get_key()] = component
end

--! Delete a component.
local delete = function(entity, component)
  assert(entity, "No entity specified")
  assert(component, "No component specified")
  local result = components[entity .. "__" .. component]
  assert(result, "No component: " .. entity  .. "_" .. component)
  components[entity .. "__" .. component] = nil
end

--! Return the component specified by its name and its entity.
local get = function(entity, component)
  assert(entity, "No entity specified")
  assert(component, "No component specified")
  local result = components[entity .. "__" .. component]
  assert(result, "No component: " .. entity  .. "_" .. component)
  return result
end

--! Return the component specified by its key.
local get_by_key = function(key)
  assert(key, "No key specified")
  local result = components[key]
  assert(result, "No component: " .. key)
  return result
end

--! Return true if the component specified by its name and its entity exists.
local exists = function(entity, component)
  assert(entity, "No entity specified")
  assert(component, "No component specified")
  return components[entity .. "__" .. component] ~= nil
end

--! Use to set the world to a specific folder.
local load = function(world_name)
  assert(world_name, "No world name specified")
  name = world_name
  components = utils.read_table("data/world/" .. world_name)
  utils.map(prototype, components)
end

--! Serialize all the components into the world file.
local serialize = function(cluster)
  assert(cluster, "No cluster specified")
  local save = utils.map(get_save(name), cluster)
  local serialization = ""
  for _, elem in pairs(save) do
    serialization = serialization .. elem .. ",\n"
  end
  return serialization
end

--------------------------------------------------------------------------------
-- The singleton interface that could be accessed from everywhere
return {get = get,
        get_by_key = get_by_key,
        add = add,
        all = all,
        select = select,
        exists = exists,
        load = load,
        delete = delete,
        serialize = serialize}
