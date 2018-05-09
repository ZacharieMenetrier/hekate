local Player = {}

function Player.keypressed(entity, controller, key)
  if controller.gamestate.entity ~= entity then return end
  local x = 0
  local y = 0
  if key == "up" then y = - 1 end
  if key == "down" then y = 1 end
  if key == "left" then x = - 1 end
  if key == "right" then x = 1 end
  if x ~= 0 or y ~= 0 then
    controller:call_entity("move", entity, x, y)
    controller:call_entity("remove_action", entity)
  end
end

return Player
