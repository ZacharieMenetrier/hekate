love.graphics.setDefaultFilter("nearest", "nearest")

local resource = {}

resource.sprite = {}
resource.tileset = {}
resource.component = {}

local stock_resource = function(type, aquiring)
  local resource_names = love.filesystem.getDirectoryItems("resource/" .. type)
  for _, resource_name in ipairs(resource_names) do
    local file_path = "resource/" .. type .. "/" .. resource_name
    local file_name = string.gsub(resource_name, "%..*", "")
    resource[type][file_name] = aquiring(file_path)
  end
end

local aquire_component = function(file_path)
  return require(string.gsub(file_path, "%..*", ""))
end

stock_resource("sprite", love.graphics.newImage)
stock_resource("tileset", love.graphics.newImage)
stock_resource("component", aquire_component)

return resource
