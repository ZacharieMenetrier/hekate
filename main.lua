local graphics = require "src/graphics"
local resource = require "src/resource"
local gamestate = require "src/gamestate"
local controller = require "src/controller"

gamestate:load_gamestate()

function love.update(dt)
  local action_left = controller.get_action_left(gamestate.entity)
  if action_left == 0 then
    controller.call_entity("end", gamestate.entity, gamestate, resource)
    gamestate:next_turn()
    controller.call_entity("begin", gamestate.entity, gamestate, resource)
  else
    controller.call_entity("run", gamestate.entity, gamestate, resource)
  end
end

function love.keypressed(key, scancode, isrepeat)
  controller.call_cluster("keypressed", gamestate, resource, key)
end

function love.draw()
  graphics.draw_tileset(gamestate.tilemap, resource.tileset.ascii)
  local entity = gamestate.entity
  local xpix = entity.position.x * graphics.tile_size + graphics.tile_size / 2
  local ypix = entity.position.y * graphics.tile_size + graphics.tile_size / 2
  love.graphics.circle("fill", xpix, ypix, graphics.tile_size * 0.66)
  for _, entity in ipairs(gamestate.cluster) do
    local sprite = resource.sprite["pig"]
    local xpix = entity.position.x * graphics.tile_size
    local ypix = entity.position.y * graphics.tile_size
    love.graphics.draw(sprite, xpix, ypix)
  end
  local action_left = controller.get_action_left(gamestate.entity)
  love.graphics.print(action_left, 20, 20)
end
