local utils = require "src/utils/utils"

--! @brief The super class of all components.
local Component = {}

--! @brief Get the save of a component (may be overrided).
function Component:get_save()
  local s = self:get_key() .. " = "
  s = s .. utils.serialize(self) .. ",\n"
  return s
end

--! @brief Get the save of only some values of the components.
function Component:get_partial_save(...)
  local s = self:get_key() .. " = {"
  local params = utils.pack(...)
  table.insert(params, "__name")
  table.insert(params, "__entity")
  for _, name in ipairs(params) do
    s = s .. name .. " = " .. utils.serialize(self[name]) .. ", "
  end
  return s .. "},\n"
end

--! @brief Return the key of the component.
function Component:get_key()
  return self.__entity .. "__" .. self.__name
end

--! @brief Make a component write itself in a world folder.
function Component:serialize(world_name)
  utils.append_file("data/world/" .. world_name, self:get_save())
end

--! @brief Declare a new component.
function Component:new()
  local o = {}
  setmetatable(o, self)
  self.__index = self
  return o
end

return Component
