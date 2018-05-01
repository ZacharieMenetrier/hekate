local graphics = require "src/graphics"
local controller = require "src/controller"

controller:load_gamestate()

function love.update(dt)
  local action_left = controller:get_action_left()
  if action_left == 0 then
    controller:next_turn()
  else
    controller:call_current("run")
  end
end

function love.keypressed(key, scancode, isrepeat)
  controller:call_cluster("keypressed", key)
end

function love.draw()
  graphics.draw_tileset(controller.gamestate.tilemap, controller.resource.tileset.ascii)
  local entity = controller.gamestate.entity
  local xpix = entity.position.x * graphics.tile_size + graphics.tile_size / 2
  local ypix = entity.position.y * graphics.tile_size + graphics.tile_size / 2
  love.graphics.circle("fill", xpix, ypix, graphics.tile_size * 0.66)
  for _, entity in ipairs(controller.gamestate.cluster) do
    local sprite = controller.resource.sprite["pig"]
    local xpix = entity.position.x * graphics.tile_size
    local ypix = entity.position.y * graphics.tile_size
    love.graphics.draw(sprite, xpix, ypix)
  end
  local action_left = controller:get_action_left()
  love.graphics.print(action_left, 20, 20)
end
