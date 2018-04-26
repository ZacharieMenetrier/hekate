local utils = {}

function utils.itergrid(size)
  local xi = 0
  local yi = 1
  return function()
    xi = xi + 1
    if xi > size then
      yi = yi + 1
      if yi > size then
        return nil
      end
    end
    return xi, yi
  end
end

return utils
