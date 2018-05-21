local utils = {}

--! @brief Read a file and return a string.
function utils.read_file(file_path)
  file = io.input(file_path, "r")
  str = file:read("*all")
  file:close()
  return str
end

--! @brief Read a lua-like file and return its table.
function utils.read_table(file_path)
  local file_exists = love.filesystem.getInfo(file_path)
  assert(file_exists, "No file found at: " .. file_path)
  local str = "return {" .. utils.read_file(file_path) .. "}"
  local table = loadstring(str)()
  return table
end

--! @biref Write a string to a file.
function utils.write_file(file_path, str)
  file = io.open(file_path, "w")
  file:write(str)
  file:close()
end

--! @biref Append a string to a file.
function utils.append_file(file_path, str)
  file = io.open(file_path, "a")
  file:write(str)
  file:close()
end

--! @brief Pack arguments into a table.
function utils.pack(...)
  return { n = select("#", ...), ... }
end

--! @brief Get the lerp from a to b with a delta time t and a speed s.
function utils.lerp(a, b, t, s)
  return a - (a - b) * t * s
end

--! @brief Recursive function to serialize a table.
utils.serialize = function(object)
  value_type = type(object)
  if value_type ~= "table" then
    if value_type == "string" then return '"' .. object .. '"' end
    return tostring(object)
  end
  s = "{ "
  for elem_id, elem in pairs(object) do
    s = s .. elem_id .. " = " .. utils.serialize(elem) .. ", "
  end
  return s .. " }"
end

function utils.sort_pairs(tab, comp)
   local sorted = {}
   for id, elem in pairs(tab) do table.insert(sorted, {id = id, elem = elem}) end
   table.sort(sorted, function(a, b) return comp(a.elem, b.elem) end)
   local j = 0
   return function()
     j = j + 1
     local k = sorted[j]
     if k ~= nil then
        return k.id, tab[k.id]
     end
   end
end

return utils
