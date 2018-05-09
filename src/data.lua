local matrix = require "src/helper/matrix"
local utils = require "src/helper/utils"

local data = {}

-- Return a tilemap and a cluster for a given data.
function data.read_world(name)
  -- Read the tilemap.
  local tilemap_path = "data/world/" .. name .. "/tilemap"
  local tilemap = matrix.str_to_matrix(utils.read_file(tilemap_path))
  -- Read the cluster.
  local cluster_path = "data/world/" .. name .. "/cluster"
  local cluster = utils.read_table(cluster_path)
  return tilemap, cluster
end

return data
