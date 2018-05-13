local resource = require "src/resource"
local graphics = require "src/graphics"
local utils = require "src/utils/utils"

local Tilemap = {}

function Tilemap:load()
  self.data = utils.read_table("data/tilemap/" .. self.name)
end

function Tilemap:draw_layer_0()
  local tileset = resource.get("tileset", self.tileset)
  graphics.draw_tilemap(self.data, tileset)
end

return Tilemap
