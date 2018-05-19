local Component = require "resource/component/component"
local resource = require "src/resource"
local graphics = require "src/graphics"
local utils = require "src/utils/utils"

--------------------------------------------------------------------------------

local Tilemap = Component:new()

function Tilemap:load()
  self.data = utils.read_table("data/tilemap/" .. self.tilemap)
end

function Tilemap:draw_tilemap()
  local tileset = resource.get("tileset", self.tileset)
  graphics.draw_tilemap(self.data, tileset)
end

function Tilemap:get_save()
  return self:get_partial_save("tileset", "tilemap")
end

return Tilemap
