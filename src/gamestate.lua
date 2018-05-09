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
  self.turn_pointer = save.turn_pointer
  self.entity = self.cluster[self.turn_pointer]
  assert(self.entity, "No entities when loading the save.")
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

-- Change the turn of the entities.
function gamestate:next_turn()
  self.turn_pointer = self.turn_pointer + 1
  if self.cluster[self.turn_pointer] == nil then
    self.turn_pointer = 1 end
  self.entity = self.cluster[self.turn_pointer]
  assert(self.entity, "No more entities in the world.")
end

return gamestate
