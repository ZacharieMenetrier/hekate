local Player = {}

function Player.remove_action(this, controller)
  local player = this.components.player
  player.action_left = player.action_left - 1
end

function Player.refill_actions(this, controller)
  local player = this.components.player
  player.action_left = player.action_right
end

return Player
