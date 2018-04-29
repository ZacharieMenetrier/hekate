local utils = require "src/utils/utils"
local graphics = require "src/graphics"
local resource = require "src/resource"
local world = require "src/world"
local controller = require "src/controller"

local save = utils.read_table("data/save")
local tilemap, cluster = world.read_world(save.world)
local turn_state = 1
local entity = cluster[turn_state]
local action = false


queue_action = function(new_action)
  action = new_action
end

function love.update(dt)
  if action then
    print("lol")
    action()
    action = false
    turn_state = turn_state + 1
    if not cluster[turn_state] then
      turn_state = 1
    end
    entity = cluster[turn_state]
    assert(entity)
  end
  controller.update(entity, action)
end

function love.keypressed(key, scancode, isrepeat)
  controller.keypressed(entity, key)
end

function love.draw()
  graphics.draw_tileset(tilemap, resource.tileset.ascii)
  for _, entity in ipairs(cluster) do
    local behavior = resource.behavior[entity.behavior]
    behavior.draw(entity, resource, graphics)
  end
end
