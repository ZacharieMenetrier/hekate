local PlayerInput = {}

function PlayerInput.turn_keypressed(this, controller, key)
  local x = 0
  local y = 0
  if key == "up" then y = - 1 end
  if key == "down" then y = 1 end
  if key == "left" then x = - 1 end
  if key == "right" then x = 1 end
  if x ~= 0 or y ~= 0 then
    controller:call_entity("move", this.id, x, y)
    controller:call_entity("remove_action", this.id)
  end
end

return PlayerInput
