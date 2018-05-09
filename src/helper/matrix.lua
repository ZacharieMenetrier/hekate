-- Helper for all kind of matrices
local matrix = {}

-- A local function that sets a value in a matrix.
local set_value = function(mtx, l, c, value)
  if not mtx[l] then mtx[l] = {} end
  mtx[l][c] = tonumber(value) or value
end

-- Parse a space separated string and return a matrix.
function matrix.str_to_matrix(str_matrix)
  local mtx = {}
  local l = 1
  for line in str_matrix:gmatch("[^\n]+") do
    local c = 1
    for cell in line:gmatch("%w+") do
      set_value(mtx, c, l, cell)
      c = c + 1
    end
    l = l + 1
  end
  return mtx
end

-- Iterate through a virtual squared matrix.
-- Return a line and a column at each iteration.
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

-- Iterate through a given matrix.
-- Return a line, a column and the value of the cell at each iteration.
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
