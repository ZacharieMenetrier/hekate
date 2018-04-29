love.graphics.setDefaultFilter("nearest", "nearest" )

local resource = {}

resource.sprite = {}
resource.tileset = {}
resource.component = {}

resource.sprite.pig = love.graphics.newImage("resource/sprite/pig.png")
resource.sprite.plus = love.graphics.newImage("resource/sprite/plus.png")

resource.tileset.ascii = love.graphics.newImage("resource/tileset/ascii.png")

resource.component.sprite = require "resource/component/sprite"

return resource
