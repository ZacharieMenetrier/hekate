-- All code shown here is nowhere to be taken seriously.
-- Most for demonstration purposes, will be heavily extended at best.

local utils = require "src/utils/utils"
local world = require "src/world"
local resource = require "src/resource"
local graphics = require "src/graphics"
-- A random system
local move = require "src/system/move"


-- Read a world folder and get its tilemap and cluster.
local save = utils.read_table("data/save")
local tilemap, cluster = world.read_world(save.world)

-- Just update some random system.
local run = 0
function love.update(dt)
  run = run + dt
  -- Each second the system is updated
  if run > 1 then
    run = 0
    -- Update the system
    move.update(cluster, world.filter_cluster)
  end
end

function love.draw()
  love.graphics.scale(2, 2)
  -- Draw the tilemap first.
  graphics.draw_tileset(tilemap, resource.tileset.ascii)
  -- Draw the cluster next.
  graphics.draw_cluster(cluster, resource, world.filter_cluster)
end
