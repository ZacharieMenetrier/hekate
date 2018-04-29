local matrix = require "src/utils/matrix"
local utils = require "src/utils/utils"

local world = {}

-- Return a tilemap and a cluster for a given world.
function world.read_world(name)
  -- Read the tilemap.
  local tilemap_path = "data/world/" .. name .. "/tilemap"
  local tilemap = matrix.str_to_matrix(utils.read_file(tilemap_path))
  -- Read the cluster.
  local cluster_path = "data/world/" .. name .. "/cluster"
  local cluster = utils.read_table(cluster_path)
  return tilemap, cluster
end

return world
