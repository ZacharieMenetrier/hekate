local utils = require "src/utils/utils"
local graphics = require "src/graphics"
local resource = require "src/resource"
local world = require "src/world"
local controller = require "src/controller"

local queue = require "src/utils/queue"

local save = utils.read_table("data/save")
local tilemap, cluster = world.read_world(save.world)
local turn_state = 1
local entity = cluster[turn_state]
local action = queue.new()

queue_action = function(new_action)
  queue.push_action_last(action, new_action)
end

function love.update(dt)
  -- If the action queue is not empty
  pending_action = queue.pop_first_action(action)
  if pending_action then
    pending_action() -- Perform the action
    pending_action = false -- No pending actions anymore
    turn_state = turn_state + 1
    if not cluster[turn_state] then
      turn_state = 1
    end
    entity = cluster[turn_state]
    assert(entity)
  end
  --controller.update(entity, action)
  controller.update(entity)
end

function love.keypressed(key, scancode, isrepeat)
  controller.keypressed(entity, key)
end

function love.draw()
  graphics.draw_tileset(tilemap, resource.tileset.ascii)
  for _, entity in ipairs(cluster) do
    local sprite = resource.sprite[entity.sprite]
    local xpix = entity.position.x * graphics.tile_size
    local ypix = entity.position.y * graphics.tile_size
    love.graphics.draw(sprite, xpix, ypix)
  end
end
