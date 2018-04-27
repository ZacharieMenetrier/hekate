local utils = require "src/utils"
local matrix = require "src/matrix"

local actor = {}

function actor.create_actor(name, x, y)
  local actor = {}
  actor.name = name
  actor.x = x
  actor.y = y
  return actor
end

function actor.move_actor(act, dx, dy)
  act.x = act.x + dx
  act.y = act.y + dy
end

-- Read actor list
function actor.read_actors(name)
  local actor_matrix = matrix.read_matrix(name, "actors")
  local actors = {}
  for x, y in pairs(actor_matrix) do
    table.insert(actors, actor.create_actor(unpack(actor_matrix[x])))
  end
  return actors
end

return actor
