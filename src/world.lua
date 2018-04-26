local parser =require "src/parser"
local utils = require "src/utils"
local metrics = require "src/metrics"
--------------------------------------------------------------------------------
local read_matrix = parser.read_matrix
local iter_matrix = utils.iter_matrix
local chunk_size = metrics.chunk_size
--------------------------------------------------------------------------------

local world = {}

function world.parse_world(file_path)
  world_matrix = read_matrix(file_path)
  tile_matrix = {}
  for x, y, value in iter_matrix(world_matrix) do
    local x_tile = (x - 1) * chunk_size
    local y_tile = (y - 1) * chunk_size
    chunk = read_matrix("world/chunk/" .. value .. ".chunk")
    for x, y in iter_square(chunk_size) do
      tile_matrix[x][y] =
  end
end
