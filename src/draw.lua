local matrix = require "src/matrix"
local draw = {}

function draw.draw_matrix(tilematrix, tileset, quads)
  for x, y, tile in matrix.iter_matrix(tilematrix) do
    love.graphics.draw(tileset, quads[tile], (x - 1) * 16, (y - 1) * 16)
  end
end

-- Actors
function draw.draw_actor(act, sprite)
  full_quad = love.graphics.newQuad(0, 0, 16, 16, sprite:getDimensions())
  love.graphics.draw(sprite, full_quad, act.x * 16, act.y * 16)
end

function draw.draw_actor_name(act)
  love.graphics.print(act.name, act.x*16, act.y*16 -16)
end


return draw
