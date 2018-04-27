-- This is not a real system but just a demonstration.
local move = {}

-- The list of components that are necessary for an entity to have
-- in order to be processed by this particular system.
local components = {"move", "position"}

-- Called each time the game-state is updated.
-- Each system must have this kind of delegated loop.
-- All the entities are passed each time.
function move.update(cluster, filter)
  -- Iterate and filter the entities for looping only over those
  -- that contain the necessary components.
  for entity in filter(cluster, components) do
    -- Do some stuff on the entity's components.
    local position = entity.position
    local x = love.math.random(-1, 1)
    local y = love.math.random(-1, 1)
    position.x = position.x + x
    position.y = position.y + y
  end
end


return move
