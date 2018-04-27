love.graphics.setDefaultFilter("nearest", "nearest" )

local resource = {}

-- Two different resources, the sprites and the tilesets.
resource.sprite = {}
resource.tileset = {}

resource.sprite.pig = love.graphics.newImage("resource/sprite/pig.png")
resource.sprite.plus = love.graphics.newImage("resource/sprite/plus.png")
resource.tileset.ascii = love.graphics.newImage("resource/tileset/ascii.png")
return resource
