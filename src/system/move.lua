-- This is not a real system but just a demonstration.
local move = {}

-- The list of components that are necessary for an entity to have
-- in order to be processed by this particular system.
local components = {"move", "position"}




-- Called each time the game-state is updated.
-- Each system must have this kind of delegated loop.
-- All the entities are passed each time.
function move.update(cluster, filter, dx,dy)
  moves_performed = {}
  -- Iterate and filter the entities for looping only over those
  -- that contain the necessary components.
  for entity in filter(cluster, components) do
    -- Do some stuff on the entity's components.
    local pos = entity.position
    pos.x = pos.x + dx
    pos.y = pos.y + dy

    -- Return details on the action performed so it can be visualized later
    table.insert(moves_performed,{pos.x, pos.y, dx, dy})
  end
  return moves_performed
end



-- Each system must have a visualizer than can be called, because each system
-- exists only in gameplay and must be visualized by the player
function move.visualize(x,y,dx,dy)
  love.graphics.line( (x+0.5)*16, (y+0.5)*16, (x+0.5-dx)*16,(y+0.5-dy)*16)
  -- TODO unhardcode the tilesize
end



return move
