local matrix = require "src/matrix"
local quads = require "src/quads"
local loader = require "src/loader"
local chunk = matrix.read_matrix("test", "chunk")

function love.draw()
  for x, y, tile in matrix.iter_matrix(chunk) do
    love.graphics.draw(loader.tileset, quads[tile], x * 16, y * 16)
  end
  love.graphics.print(love.timer.getFPS(), 10, 10)
end
