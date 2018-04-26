local utils = require "src/utils"
-- Helper for world and chunk matrices
local matrix = {}

local set_value = function(mtx, x, y, value)
  if not mtx[x] then mtx[x] = {} end
  mtx[x][y] = tonumber(value) or value
end

function matrix.read_matrix(name, type)
  local file_path = type .. "/" .. name .. "." .. type
  local str_matrix = utils.read_file(file_path)
  return matrix.str_to_matrix(str_matrix)
end

function matrix.str_to_matrix(str_matrix)
  local mtx = {}
  local y = 0
  for line in str_matrix:gmatch("[^\n]+") do
    local x = 0
    for cell in line:gmatch("%w+") do
      set_value(mtx, x, y, cell)
      x = x + 1
    end
    y = y + 1
  end
  return mtx
end

function matrix.iter_square(size)
  local xi = -1
  local yi = 0
  return function()
    if xi > size then
      yi = yi + 1
      xi = -1
      if yi > size then
        return nil
      end
    end
    xi = xi + 1
    return xi, yi
  end
end

function matrix.iter_matrix(mtx)
  local xi = -1
  local yi = 0
  return function()
    xi = xi + 1
    if mtx[xi] == nil then
      xi = 0
      yi = yi + 1
      if mtx[xi][yi] == nil then
        return nil
      end
    end
    return xi, yi, mtx[xi][yi]
  end
end

return matrix
