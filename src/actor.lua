local actor = {}

function actor.create_actor(myname,myx,myy)
  act = {name = myname, x = myx, y = myy}
  return act
end

return actor
