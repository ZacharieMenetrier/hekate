local matrix = require "src/utils/matrix"
local utils = require "src/utils/utils"

-- Helper for world related functions.
local world = {}

-- A function that reads a world folder.
-- Return a tilemap and a cluster.
function world.read_world(name)
  -- Read the tilemap.
  local tilemap_path = "data/world/" .. name .. "/tilemap"
  local tilemap = matrix.str_to_matrix(utils.read_file(tilemap_path))
  -- Read the cluster.
  local cluster_path = "data/world/" .. name .. "/cluster"
  local cluster = utils.read_table(cluster_path)
  return tilemap, cluster
end

-- A local function that tells if an entity matches the given components.
local entity_contains = function(entity, components)
  for _, component in ipairs(components) do
    if not entity[component] then return false end
  end
  return true
end

-- TODO Surely there is a lot of room for improvement here.
-- Creating a new table each time is not the most efficient.

-- Iterate through all the given entities
-- that contains the specified components.
function world.filter_cluster(cluster, components)
  local filtered= {}
  -- Filtering first.
  for _, entity in pairs(cluster) do
    if entity_contains(entity, components) then
      table.insert(filtered, entity)
    end
  end
  -- Iterating then.
  i = 0
  return function()
    i = i + 1
    return filtered[i]
  end
end

return world
