local Position = {}

function Position:move(x, y)
  self.x = self.x + x
  self.y = self.y + y
end

return Position
