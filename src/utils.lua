--- A parser/renderer for Aseprite animations in LÖVE.
-- @classmod utils
local utils = {}

--- Read a file and return a string.
function utils.read_file(file_path)
  file = io.input(file_path, "r")
  str = file:read("*all")
  file:close()
  return str
end

--- Read a lua-like file and return its table.
function utils.read_table(file_path)
  local file_exists = love.filesystem.getInfo(file_path)
  assert(file_exists, "No file found at: " .. file_path)
  local str = "return {" .. love.filesystem.read(file_path) .. "}"
  local table = loadstring(str)()
  return table
end

--- Write a string to a file.
function utils.write_file(file_path, str)
  file = io.open(file_path, "w")
  file:write(str)
  file:close()
end

--! Append a string to a file.
function utils.append_file(file_path, str)
  file = io.open(file_path, "a")
  file:write(str)
  file:close()
end

--- Pack arguments into a table.
function utils.pack(...)
  return { n = select("#", ...), ... }
end

--- Get the lerp from a to b with a delta time t and a speed s.
function utils.lerp(a, b, t, s)
  return a - (a - b) * t * s
end

--- Recursive function to serialize a table.
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

--- Pairs through a table sorted by a comparative function.
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

--- Iterate through a x and y of a matrix with width w and height h.
function utils.itermatrix(w, h)
  local xi = -1
  local yi = 0
  return function()
    if xi > w then
      yi = yi +1
      if yi > w then return nil, nil end
      xi = -1
    end
    xi = xi + 1
    return xi, yi
  end
end

--- Returns the path, filename and extension.
function utils.split_file_path(file_path)
  local p, f, e = string.match(file_path, "(.-)([^/]-([^/%.]+))$")
	return p, string.gsub(f, "%..*", ""), e
end

--- Map a function to a table.
function utils.map(fun, tab)
  assert(fun, "No function specified")
  assert(tab, "No table specified")
  local results = {}
  for id, elem in pairs(tab) do
    results[id] = fun(elem)
  end
  return results
end

return utils
