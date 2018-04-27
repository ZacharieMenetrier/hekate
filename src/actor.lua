utils = require "src/utils"

local actor = {}

function actor.create_actor(myname,myx,myy)
  act = {name = myname, x = myx, y = myy}
  return act
end


-- Read actor list
function actor.read_actors(name, type)
  local file_path = type .. "/" .. name .. "." .. type
  local str_actors = utils.read_file(file_path)
  return actor.str_to_actorslist(str_actors)
end

function actor.str_to_actorslist(str_actors)
  local actlist = {}
  i=1
  for line in str_actors:gmatch("[^\n]+") do

    args = {}
    for cell in line:gmatch("%w+") do
      table.insert(args, cell)
    end

    actlist[i] = actor.create_actor(unpack(args))
    i = i + 1
  end
  return actlist
end


return actor
