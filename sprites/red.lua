
local spriteSheet = "img/Dotty_2x.png"
local image = love.graphics.newImage(spriteSheet)
local width = image:getWidth()
local height = image:getHeight()
local size = 100
local tileW = 70
local tileH = 105
local leftOffset = 16
local downOffset = 9
local upOffset = -6

return {


    w = tileW,
    h = tileH,
    serialization_version = 1.0,

    spriteName = "red",
    frameDuration = 0.10,

    spriteSheet  = spriteSheet, 

    animationNames = {
        "walkUp",
        "walkDown",
        "walkLeft",
        "walkRight",
        "idleUp",
        "idleDown",
        "idleLeft",
        "idleRight",
    },
   


    animations = {
        walkUp =  {
            love.graphics.newQuad(0, 0 - upOffset, tileW, tileH, width,  height ),
            love.graphics.newQuad(tileW, 0 - upOffset, tileW, tileH, width,  height ),
            love.graphics.newQuad(2*tileW, 0 - upOffset, tileW, tileH, width,  height ),
        },
        walkDown = {
            love.graphics.newQuad(0, 2*tileH - downOffset, tileW, tileH, width,  height),
            love.graphics.newQuad(tileW, 2*tileH - downOffset, tileW, tileH, width,  height),
            love.graphics.newQuad(tileW*2, 2*tileH - downOffset, tileW, tileH, width,  height),
        
        },
        walkLeft = {
            love.graphics.newQuad(0, 3*tileH - leftOffset, tileW, tileH, width,  height),
            love.graphics.newQuad(tileW, 3*tileH - leftOffset, tileW, tileH, width,  height),
            love.graphics.newQuad(tileW*2, 3*tileH - leftOffset, tileW, tileH, width,  height),
        },
        walkRight = {
            love.graphics.newQuad(0, tileH, tileW, tileH, width,  height),
            love.graphics.newQuad(tileW, tileH, tileW, tileH, width,  height),
            love.graphics.newQuad(tileW*2, tileH, tileW, tileH, width,  height),
        },
        idleUp ={
            love.graphics.newQuad(tileW, 0 - upOffset, tileW, tileH, width,  height)
        },
        idleDown = {
            love.graphics.newQuad(tileW, tileH*2 - downOffset, tileW, tileH, width,  height)
        },
        idleLeft = {
            love.graphics.newQuad(tileW, 3*tileH - leftOffset, tileW, tileH, width,  height)
    },
        idleRight = {
            love.graphics.newQuad(tileW, tileH, tileW, tileH, width,  height)
    },
    }

} 
