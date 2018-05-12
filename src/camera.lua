local graphics = require "src/graphics"
local utils = require "src/utils/utils"
local world = require "src/world"

--------------------------------------------------------------------------------
--private variables-------------------------------------------------------------
--------------------------------------------------------------------------------

local x = 0
local y = 0
local speed = 4
local smooth = 5

local x_target = 0
local y_target = 0

--------------------------------------------------------------------------------
--public variables--------------------------------------------------------------
--------------------------------------------------------------------------------

-- Update the camera position.
local update = function(dt)
  x_input, y_input = utils.input_axe()
  x_target = x_target + x_input * speed
  y_target = y_target + y_input * speed
  x = utils.lerp(x, x_target, dt, smooth)
  y = utils.lerp(y, y_target, dt, smooth)
end

local draw = function()
  love.graphics.translate(-x, -y)
end

return {update = update,
        draw = draw}
