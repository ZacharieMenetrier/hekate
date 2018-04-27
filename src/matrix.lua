local utils = require "src/utils"
-- Helper for world and chunk matrices
local matrix = {}

local set_value = function(mtx, l, c, value)
  if not mtx[l] then mtx[l] = {} end
  mtx[l][c] = tonumber(value) or value
end

function matrix.read_matrix(name, type)
  local file_path = type .. "/" .. name .. "." .. type
  local str_matrix = utils.read_file(file_path)
  return matrix.str_to_matrix(str_matrix)
end

function matrix.str_to_matrix(str_matrix)
  local mtx = {}
  local l = 1
  for line in str_matrix:gmatch("[^\n]+") do
    local c = 1
    for cell in line:gmatch("%w+") do
      set_value(mtx, l, c, cell)
      c = c + 1
    end
    l = l + 1
  end
  return mtx
end

function matrix.iter_square(size)
  local li = 0
  local ci = 1
  return function()
    if li > size then
      ci = ci + 1
      li = 0
      if ci > size then
        return nil
      end
    end
    li = li + 1
    return li, ci
  end
end

function matrix.iter_matrix(mtx)
  local li = 0
  local ci = 1
  return function()
    li = li + 1
    if not mtx[li] then
      li = 1
      ci = ci + 1
      if not mtx[li][ci] then
        return nil
      end
    end
    return li, ci, mtx[li][ci]
  end
end

return matrix
