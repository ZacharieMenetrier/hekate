local utils = require "src/utils"
local world = require "src/world"

--- The super class of all components.
-- @classmod component
local Component = {}

--- Get the save of a component (may be overrided).
function Component:get_save()
  return self:get_key() .. " = " .. utils.serialize(self)
end

--- Get the save of only some values of the components.
function Component:get_partial_save(...)
  local s = self:get_key() .. " = {"
  local params = utils.pack(...)
  table.insert(params, "__name")
  table.insert(params, "__entity")
  for _, name in ipairs(params) do
    s = s .. name .. " = " .. utils.serialize(self[name]) .. ", "
  end
  return s .. "}"
end

--- Return the key of the component.
function Component:get_key()
  return self.__entity .. "__" .. self.__name
end

--- Declare a new component.
function Component:new()
  local component = {}
  setmetatable(component, self)
  self.__index = self
  return component
end

--- Base function to destroy itself.
function Component:destroy()
  world.delete(self.__entity, self.__name)
end

return Component
