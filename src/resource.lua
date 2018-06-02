--- A module that is used to retrieve the resources of the game.
local resource = {}

local graphics = require "src/graphics"
local peachy = require "lib/peachy"
local utils = require "src/utils"

-- Stock the preloaded resources.
local loaded = {}

-- Short function to load a snippet.
local load_snippet = function(file_path)
  local snippet = require(string.gsub(file_path, "%..*", ""))
  return function() return snippet end
end

-- Short function to load a sprite.
local load_sprite = function(file_path)
  local sprite = love.graphics.newImage(file_path)
  return function() return sprite end
end

-- Short function to load a font.
local load_font = function(file_path)
  local font = love.graphics.newFont(file_path, 16)
  return function() return font end
end

-- Short function to load a lua-like table.
local load_table = function(file_path)
  return function() return utils.read_table(file_path) end
end

-- Short function to load an animation.
local load_animation = function(file_path)
  return function ()
    local path, file_name, extension = utils.split_file_path(file_path)
    if extension == "json" then return end
    local json = path .. "/" .. file_name .. ".json"
    local image = love.graphics.newImage(file_path)
    return peachy.new(json, image)
  end
end

--- Use to load a specific category of resource folder.
-- @param category: string: category of resources asked
-- @param load: function used to load resource into a table
-- @return table: key = name, value = Image
local load_category = function(category, load)
  local file_names = love.filesystem.getDirectoryItems("resource/" .. category)
  local resources_category = {}
  for _, file_name in ipairs(file_names) do
    local file_path = "resource/" .. category .. "/" .. file_name
    local name = string.gsub(file_name, "%..*", "")
    local resource = load(file_path)
    if resource then
      resources_category[name] = resource
    end
  end
  return resources_category
end

--- Automatically load all the resources in the resource folder.
function resource.load()
  -- Set the filter to nearest for pixelish effect.
  love.graphics.setDefaultFilter("nearest", "nearest")
  -- Load the sprites.
  loaded.sprite = load_category("sprite", load_sprite)
  -- Load the components.
  loaded.component = load_category("component", load_snippet)
  -- Load the abilities.
  loaded.ability = load_category("ability", load_snippet)
  -- Load the fonts.
  loaded.font = load_category("font", load_font)
  -- Load the worlds.
  loaded.world = load_category("world", load_table)
  -- Load the tilemaps.
  loaded.tilemap = load_category("tilemap", load_table)
  -- Load the animations.
  loaded.animation = load_category("animation", load_animation)
end

--- Return a specific resource.
-- @param category: string: Category of resources asked
-- @param name: string: Name of the resource
-- @return table: key = name, value = resource
function resource.get(category, name)
  assert(category ~= nil, "No category of resource specified")
  assert(name ~= nil, "No name of resource specified")
  local resources_category = loaded[category]
  assert(resources_category ~= nil, "No resource of category: "  .. category)
  local result = resources_category[name]
  assert(result ~= nil, "No resource: " .. category .. "/" .. name)
  return result()
end

return resource
