local utils = require "src/utils/utils"
local graphics = require "src/graphics"
local resource = require "src/resource"
local world = require "src/world"
local controller = require "src/controller"



local ai = require "resource/ai"

local save = utils.read_table("data/save")
local tilemap, cluster = world.read_world(save.world)
local turn_state = 1
local entity = cluster[turn_state]



function love.update(dt)

  -- TODO Move all of this to the controller, because love.update is called at
  -- each frame ! Here there should only be a function that calls for the controller
  -- to update itself. This way the game can keep drawing while the controller
  -- processes the actions.

  -- If the current entity belong the to the AI, tell it that it can make a move
  if entity.team == "computer" then
    ai_action = ai.give_order_to_entity(entity)
    controller.queue_action(ai_action)
  end

  ------- PROCESSING THE ACTION QUEUE ------
  pending_action = controller.get_pending_action() -- False if there is no pending action
  -- If the action queue is not empty
  if pending_action then
    pending_action() -- Perform the action
    pending_action = nil -- Discard that particular pending action

    -- Advance the turn state
    turn_state = turn_state + 1
    if not cluster[turn_state] then
      turn_state = 1
    end

    -- Get the next entity
    entity = cluster[turn_state]
    assert(entity)
  end

  --controller.update(entity)
  love.timer.sleep(1) -- Slow it just to visualize the steps, we'll remove that later
end

function love.keypressed(key, scancode, isrepeat)
  -- When a key is pressed, tell the controller that a human action is coming
  -- TODO make this subject to the same rules as the AI.
  controller.keypressed(entity, key)
end

function love.draw()

  love.graphics.print("Current initiative : "..turn_state,40,40)
  love.graphics.print("Current unit controlled by  : "..entity.team,40,60)

  graphics.draw_tileset(tilemap, resource.tileset.ascii)
  for _, entity in ipairs(cluster) do
    local sprite = resource.sprite[entity.sprite]
    local xpix = entity.position.x * graphics.tile_size
    local ypix = entity.position.y * graphics.tile_size
    love.graphics.draw(sprite, xpix, ypix)
  end
end
