local Referee = {}

local change_turn = function(referee)
  local number, name = next(referee.recruit, referee.current_player_number)
  return number or next(referee.recruit, nil)
end

local get_current_player_id = function(referee)
  local current_player_number = referee.current_player_number
  return referee.recruit[current_player_number]
end

function Referee.update(this, controller)
  local referee = this.components.referee
  local current_player_id = get_current_player_id(referee)
  local current_player = controller:get_components(current_player_id).player
  if current_player.action_left > 0 then
    controller:call_entity("turn_update", current_player_id)
  else
    referee.current_player_number = change_turn(referee)
    current_player_id = get_current_player_id(referee)
    controller:call_entity("refill_actions", current_player_id)
  end
end

function Referee.keypressed(this, controller, key)
  local referee = this.components.referee
  local current_player_id = get_current_player_id(referee)
  local current_player = controller:get_components(current_player_id).player
  if current_player.action_left <= 0 then return end
  controller:call_entity("turn_keypressed", current_player_id, key)
end

return Referee
