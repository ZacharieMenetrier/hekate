local world = require "src/data"
local utils = require "src/helper/utils"
local resource = require "src/resource"

local gamestate = {}

-- Load the gamestate given by the save file.
function gamestate:load_gamestate()
  local save = utils.read_table("data/save")
  local tilemap, cluster = world.read_world(save.world)
  self.tilemap = tilemap
  self.cluster = cluster
end

-- Return the tile at some position.
function gamestate:get_tile_at(x, y)
  return self.tilemap[x + 1][y + 1]
end

function gamestate:is_solid_at(x, y)
  if self:get_tile_at(x, y) == 1 then return true end
  for _, entity in pairs(self.cluster) do
    local body = entity.body
    if body ~= nil then
      if entity.position.x == x and entity.position.y == y then
        return true
      end
    end
  end
  return false
end

return gamestate
