local parser = require "src/parser"
local test = parser.read_chunk("chunk/test.chunk")
local utils = require "src/utils"

function love.draw()
  love.graphics.print(love.timer.getFPS(), 10, 10)
end
