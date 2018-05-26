--! Import graphics methods
local graphics = require "src/graphics"
local utils = require "src/utils"

--------------------------------------------------------------------------------
--private variables-------------------------------------------------------------
--------------------------------------------------------------------------------

--! The list of all resources to fetch.
local resources = {}

--! @brief Short function to load a snippet with its file path.
--! @param file_path: string: path to file
--! @return table: key = name, value = code for object
local load_snippet = function(file_path)
  return require(string.gsub(file_path, "%..*", ""))
end

local load_font = function()
  return function(file_path) return love.graphics.newFont(file_path, 16) end
end

local load_table = function()
  return function(file_path) return utils.read_table(file_path) end
end

--! @brief Use to load a specific type of resource folder.
--! @param type: string: type of resources asked
--! @param function: function used to load resource into a table
--! @return table: key = name, value = Image
local load_type = function(type, load)
  local file_names = love.filesystem.getDirectoryItems("resource/" .. type)
  local resources_type = {}
  for _, file_name in ipairs(file_names) do
    local file_path = "resource/" .. type .. "/" .. file_name
    local name = string.gsub(file_name, "%..*", "")
    resources_type[name] = load(file_path)
  end
  return resources_type
end

--------------------------------------------------------------------------------
--public variables--------------------------------------------------------------
--------------------------------------------------------------------------------

--! @brief Automatically load all the resources folders.from
local load = function()
  -- Set the filter to nearest for pixelish effect.
  love.graphics.setDefaultFilter("nearest", "nearest")
  -- Load the sprites.
  resources.sprite = load_type("sprite", love.graphics.newImage)
  -- Load the components.
  resources.component = load_type("component", load_snippet)
  -- Load the abilities.
  resources.ability = load_type("ability", load_snippet)
  -- Load the fonts.
  resources.font = load_type("font", load_font())
  -- Load the worlds.
  resources.world = load_type("world", load_table())
  -- Load the tilemaps.
  resources.tilemap = load_type("tilemap", load_table())
end

--! @brief Return a specific resource.
--! @param type: string: type of resources asked
--! @param name: string: name of the resource
--! @return table: key = name, value = Image
local get = function(type, name)
  assert(type ~= nil, "No type of resource specified")
  assert(name ~= nil, "No name of resource specified")
  local resources_type = resources[type]
  assert(resources_type ~= nil, "No resource of type: "  .. type)
  local result = resources_type[name]
  assert(result ~= nil, "No resource: " .. type .. "/" .. name)
  return result
end

--------------------------------------------------------------------------------
--! @brief The singleton interface that could be accessed from everywhere
--! @return load
--! @return get
return {load = load,
        get = get}
