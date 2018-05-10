local RandomInput = {}

function RandomInput.turn_update(this, controller)
  local x = love.math.random(-1, 1)
  local y = love.math.random(-1, 1)
  controller:call_entity("move", this.id, x, y)
  controller:call_entity("remove_action", this.id)
end

return RandomInput
