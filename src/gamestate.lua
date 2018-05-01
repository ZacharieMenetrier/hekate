local world = require "src/world"
local utils = require "src/utils/utils"

local gamestate = {}

function gamestate:load_gamestate()
  local save = utils.read_table("data/save")
  local tilemap, cluster = world.read_world(save.world)
  self.tilemap = tilemap
  self.cluster = cluster
  self.turn_pointer = save.turn_pointer
  self.entity = self.cluster[self.turn_pointer]
  assert(self.entity, "No entities when loading the save.")
end

-- Tell the gamestate that the next entity should become its active entiry
function gamestate:next_turn()
  self.turn_pointer = self.turn_pointer + 1
  if self.cluster[self.turn_pointer] == nil then
    self.turn_pointer = 1 end
  self.entity = self.cluster[self.turn_pointer]
  assert(self.entity, "No more entities in the world.")
end

return gamestate
