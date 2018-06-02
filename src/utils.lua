--- Some utilities functions.
local utils = {}

--- Read a lua-like file and return its table.
-- @param file_path: The path of the file to read.
function utils.read_table(file_path)
  local file_exists = love.filesystem.getInfo(file_path)
  assert(file_exists, "No file found at: " .. file_path)
  local str = "return {" .. love.filesystem.read(file_path) .. "}"
  return loadstring(str)()
end

--- Pack arguments into a table.
function utils.pack(...)
  return { n = select("#", ...), ... }
end

--- Get the lerp from a to b with a delta time t and a speed s.
-- @param a: The a to go from.
-- @param b: The b to go to.
-- @param t: The time elapsed since last update.
-- @param s: The speed of the movement.
function utils.lerp(a, b, t, s)
  return a - (a - b) * t * s
end

--- Recursive function to serialize a table.
-- @param object: The object to serialize.
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
-- @param tab: The table to sort and iterate.
-- @param comp: A comparative function to use for sorting.
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
-- @param w: The width of the matrix.
-- @param h: The height of the matrix.
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
-- @param file_path: The path of the file.
function utils.split_file_path(file_path)
  assert(file_path, "No file path specified")
  local p, f, e = string.match(file_path, "(.-)([^/]-([^/%.]+))$")
	return p, string.gsub(f, "%..*", ""), e
end

--- Map a function to a table.
-- @param fun: The function to map.
-- @param tab: The table to map a function to.
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
