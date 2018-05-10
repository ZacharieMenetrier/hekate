local graphics = require "src/graphics"
local Animate = {}

function Animate.load(this, controller)
  local animate = this.components.animate
  animate.x = this.components.position.x * graphics.tile_size
  animate.y = this.components.position.y * graphics.tile_size
end

local move = function(this, dt)
  local animate = this.components.animate
  local idealx = this.components.position.x * graphics.tile_size
  local idealy = this.components.position.y * graphics.tile_size
  animate.x = animate.x - (animate.x - idealx) * dt * animate.speed
  animate.y = animate.y - (animate.y - idealy) * dt * animate.speed
end


function Animate.update(this, controller, dt)
  move(this, dt)
end

function Animate.draw(this, controller)
  local animate = this.components.animate
  local sprite = controller.resource.sprite[animate.sprite]
  love.graphics.draw(sprite, animate.x, animate.y)
end


return Animate
