local parser = {}
local lines = io.lines

function parser.read_chunk(file_path)
  local chunk = {}
  x = 1
  for line in lines(file_path) do
    chunk[x] = {}
    y = 1
    for tile in line:gmatch("%w+") do
        chunk[x][y] = tile
        y = y + 1
    end
    x = x + 1
  end
  return chunk
end

return parser
