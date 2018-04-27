local matrix = require "src/matrix"
local quads = require "src/quads"
local loader = require "src/loader"
local chunk = matrix.read_matrix("test", "chunk")

local draw = require "src/draw"
function love.draw()
  tilematrix = matrix.iter_matrix(chunk)
  draw.draw_matrix(tilematrix,loader.tileset,quads)
  love.graphics.print(love.timer.getFPS(), 10, 10)
end
