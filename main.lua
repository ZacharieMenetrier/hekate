local utils = require "src/utils/utils"
local graphics = require "src/graphics"
local resource = require "src/resource"
local world = require "src/world"
local controller = require "src/controller"

local save = utils.read_table("data/save")
local tilemap, cluster = world.read_world(save.world)

local turn_state = 0
terminate = true

function love.update(dt)
  if terminate then
    turn_state = turn_state + 1
    if cluster[turn_state] == nil then turn_state = 1 end
    entity = cluster[turn_state]
    terminate = false
    controller.call_entity("run", entity, turn_state, cluster, tilemap, resource)
  end
end

function love.keypressed(key, scancode, isrepeat)
  controller.call_cluster("keypressed", cluster, turn_state, tilemap, resource, key)
end

function love.draw()
  graphics.draw_tileset(tilemap, resource.tileset.ascii)
  for _, entity in ipairs(cluster) do
    local sprite = resource.sprite["pig"]
    local xpix = entity.position.x * graphics.tile_size
    local ypix = entity.position.y * graphics.tile_size
    love.graphics.draw(sprite, xpix, ypix)
  end
end
