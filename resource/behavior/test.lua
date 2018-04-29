local test = {}

function test.draw(entity, resource, graphics)
  resource.component.sprite.draw(entity, resource, graphics)
end

return test
