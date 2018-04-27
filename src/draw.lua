local draw = {}

function draw.draw_matrix(tilematrix,tileset,quads)
  for x, y, tile in tilematrix do
    love.graphics.draw(tileset, quads[tile], x * 16, y * 16)
  end
end

return draw
