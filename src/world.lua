local matrix = require "src/matrix"
local utils = require "src/utils"

-- Helper for world related functions.
local world = {}

-- A function that reads a world folder.
-- Return a tilemap and a cluster.
function world.read_world(name)
  -- Read the tilemap.
  local tilemap_path = "data/world/" .. name .. "/tilemap"
  local tilemap = matrix.str_to_matrix(utils.read_file(tilemap_path))
  local cluster_path = "data/world/" .. name .. "/cluster"
  -- Read the cluster.
  local str_cluster = utils.read_file(cluster_path)
  local cluster = loadstring("return {" .. str_cluster .. "}")()
  return tilemap, cluster
end

-- A local function that tells if an entity matches the given components.
local entity_match = function(entity, components)
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
    if entity_match(entity, components) then
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
