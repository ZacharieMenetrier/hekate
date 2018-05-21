local Component = require "resource/component/component"
local controller = require "src/controller"
local resource = require "src/resource"
local graphics = require "src/graphics"
local utils = require "src/utils/utils"
local world = require "src/world"
local math = require "math"

--------------------------------------------------------------------------------
--private variables-------------------------------------------------------------
--------------------------------------------------------------------------------

--! Call draw on every actor depending on its draw order.
local draw_actors = function()
  -- Get the draw order of each component that has one.
  local orders = controller.call_world("get_draw_order")
  -- The comparing function for the order.
  local comp =  function(a, b) return a < b end
  -- Iterate sorted by the order.
  for component_id, _ in utils.sort_pairs(orders, comp) do
    -- Call draw actor on the component.
    local drawer = world.get_by_key(component_id)
    drawer:draw_actor()
  end
end


--------------------------------------------------------------------------------
--public variables--------------------------------------------------------------
--------------------------------------------------------------------------------

--! A camera is in charge to redistribute the draw call to the entities.
local Camera = Component:new()

--! Load the camera
function Camera:load()
  self.lockx = 0
  self.locky = 0
  self.grid = self:create_grid()
end

--! Return the x and y position of the mouse in the world pixel-coordinate.
function Camera:world_mouse()
  return self.x + love.mouse.getX(), self.y + love.mouse.getY()
end

--! Catch the mouse to move the camera.
function Camera:mousepressed(x, y, button)
  if button ~= 2 then return end
  self.lockx = x
  self.locky = y
end

--! Return an iterator of the tile visibles in the world.
function Camera:tiles_visibles()
  local tiles = {}
  -- Some self-explanatory shortcuts.
  local ts = graphics.tile_size
  local s = self.scale
  local w = love.graphics.getWidth() / s / ts
  local h = love.graphics.getHeight() / s / ts
  -- The translation in term of tiles.
  local x_translate = math.floor(self.x / s / ts)
  local y_translate = math.floor(self.y / s / ts)
  -- Get a matrix iterator with width and height.
  local itermatrix = utils.itermatrix(w, h)
  -- Enclose the iterator.
  return function()
    -- Iterate through the matrix.
    local xi, yi = itermatrix()
    if not xi then return end
    -- Shift the x and y by the camera's translation.
    local x = xi + x_translate
    local y = yi + y_translate
    return x, y
  end
end

--! Update the camera.
function Camera:update(dt)
  -- If the "g" key is pressed then draw the grid.
  if love.keyboard.isDown("g") then
    self.alpha = 1 else self.alpha = 0
  end
  -- If the right click is not pressed then exit.
  if not love.mouse.isDown(2) then return end
  -- The difference from the last frame.
  local xdiff = self.lockx - love.mouse.getX()
  local ydiff = self.locky - love.mouse.getY()
  -- Set the x and y of the camera.
  self.x = self.x + xdiff
  self.y = self.y + ydiff
  -- Set the lock of the x and y for the next frame.
  self.lockx = love.mouse.getX()
  self.locky = love.mouse.getY()
end

--! If the screen is resized then recreate the grid.
function Camera:resize()
  self.grid = self:create_grid()
end

--! Return a spritebatch with the grid of the screen size.
function Camera:create_grid()
  -- The sprite of the grid.
  local sprite = resource.get("sprite", "grid")
  -- Some self-explanatory shortcuts.
  local ts = graphics.tile_size
  local s = self.scale
  local w = love.graphics.getWidth()
  local h = love.graphics.getHeight()
  -- The number of cells to be displayed.
  local cell_number = (h / s / ts) * (w / s / ts)
  -- Create the spritebatch.
  local grid = love.graphics.newSpriteBatch(sprite, cell_number)
  for x = 0, (w / s) + ts, ts  do
    for y = 0, (h / s) + ts, ts do
      grid:add(x, y)
    end
  end
  return grid
end

--! Draw the grid of the camera.
function Camera:draw_grid()
  -- Beginning of the grid draw.
  -- Some self-explanatory shortcuts.
  local ts = graphics.tile_size
  local s = self.scale
  -- Get the x and y of the camera.
  local x = math.floor(self.x / s / ts) * ts
  local y = math.floor(self.y / s / ts) * ts
  -- Draw the grid.
  love.graphics.setColor(1, 1, 1, self.alpha)
  love.graphics.draw(self.grid, x, y)
  love.graphics.setColor(1, 1, 1, 1)
end

--! The draw of the camera will redistribute the draw for the actors.
function Camera:draw()
  love.graphics.scale(self.scale, self.scale)
  -- Translate the world's graphics.
  love.graphics.translate(-self.x / self.scale, -self.y / self.scale)
  -- Call draw tilemap on the world.
  controller.call_world("draw_tilemap")
  -- Get the cursor.
  local cursor = world.get("system", "cursor")
  -- Draw the cursor.
  cursor:draw_cursor()
  -- Draw the grid.
  self:draw_grid()
  -- Draw the actors of the world
  draw_actors()
end

--! Return the save of the camera.
function Camera:get_save()
  return self:get_partial_save("x", "y")
end

return Camera
