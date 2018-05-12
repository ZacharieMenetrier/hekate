local graphics = require "src/graphics"

--------------------------------------------------------------------------------
--private variables-------------------------------------------------------------
--------------------------------------------------------------------------------

-- The list of all resources to fetch.
local resources = {}

-- Short function to load a snippet with its file path.
local load_snippet = function(file_path)
  return require(string.gsub(file_path, "%..*", ""))
end

local load_tileset = function(file_path)
  local sprite = love.graphics.newImage(file_path)
  local quads = graphics.get_quads(sprite)
  return {sprite = sprite, quads = quads}
end

-- Used to load a specific type of resource folder.
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

-- Automatically load all the resources folders.
local load = function()
  resources.sprite = load_type("sprite", love.graphics.newImage)
  resources.tileset = load_type("tileset", load_tileset)
  resources.component = load_type("component", load_snippet)
end

-- Return a specific resource.
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
-- The singleton interface that could be accessed from everywhere
return {load = load,
        get = get}
