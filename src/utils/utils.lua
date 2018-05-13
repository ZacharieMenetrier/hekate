local utils = {}

-- Read a file and return a string.
function utils.read_file(file_path)
  file = io.input(file_path, "r")
  str = file:read("*all")
  file:close()
  return str
end

-- Read a lua-like file and return its table.
function utils.read_table(file_path)
  local file_exists = love.filesystem.getInfo(file_path)
  assert(file_exists, "No file found at: " .. file_path)
  local str = "return {" .. utils.read_file(file_path) .. "}"
  local table = loadstring(str)()
  return table
end

-- Pack arguments into a table.
function utils.pack(...)
  return { n = select("#", ...), ... }
end

function utils.lerp(a, b, t, s)
  return a - (a - b) * t * s
end

function utils.input_axe()
  local x = 0
  local y = 0
  if love.keyboard.isDown("down") then y = y + 1 end
  if love.keyboard.isDown("up") then y = y - 1 end
  if love.keyboard.isDown("left") then x = x - 1 end
  if love.keyboard.isDown("right") then x = x + 1 end
  return x, y
end

return utils
