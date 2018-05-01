local graphics = require "src/graphics"
local controller = require "src/controller"

controller:load_gamestate()

function love.update(dt)
  -- Does the current entity have actions left ?
  local action_left = controller:get_action_left()
  -- If not, move on to the next entity
  if action_left == 0 then
    controller:next_turn()
  -- Otherwise, tell the entity to call "run" on its component.
  else
    controller:call_current("run")
  end
end

function love.keypressed(key, scancode, isrepeat)
  controller:call_cluster("keypressed", key)
end

function love.draw()
  -- Draw the tilemap
  graphics.draw_tileset(controller.gamestate.tilemap, controller.resource.tileset.ascii)
  local entity = controller.gamestate.entity
  local xpix = entity.position.x * graphics.tile_size + graphics.tile_size / 2
  local ypix = entity.position.y * graphics.tile_size + graphics.tile_size / 2
  -- Draw a circle around the current entity
  love.graphics.circle("fill", xpix, ypix, graphics.tile_size * 0.66)
  -- Draw the entities
  for _, entity in ipairs(controller.gamestate.cluster) do
    local sprite = controller.resource.sprite["pig"]
    local xpix = entity.position.x * graphics.tile_size
    local ypix = entity.position.y * graphics.tile_size
    love.graphics.draw(sprite, xpix, ypix)
  end
  -- Draw the action lefts
  local action_left = controller:get_action_left()
  love.graphics.print(action_left, 20, 20)
end
