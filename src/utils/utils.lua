local utils = {}

-- Read a file and return a string.
function utils.read_file(file_path)
  file = io.input(file_path, "r")
  str = file:read("*all")
  file:close()
  return str
end

-- Read a lua-like file and return its table
function utils.read_table(file_path)
  local str = "return {" .. utils.read_file(file_path) .. "}"
  local table = loadstring(str)()
  return table
end

return utils
