return {

    serialization_version = 1.0

    spriteSheet = "img/dotty.png",
    spriteName = "red",
    frameDuration = 0.10,

    local image = love.graphics.newImage(spriteSheet)
    local width = image:getWidth()
    local height = image:getHeight()

    animationNames = {
        "walkUp",
        "walkDown",
        "walkLeft",
        "walkRight",
        "idleUp",
        "idleDown",
        "idleLeft",
        "idleRight",
    }
   
    size = 16

    animations = {
        walkUp =  {love.graphics.newQuad(0, 0, size*3,size), width,  height },
        walkDown = {love.graphics.newQuad(0, 2, size*3, size), width,  height},
        walkLeft = {love.graphics.newQuad(0, 3, size*3, size), width,  height},
        walkRight = {love.graphics.newQuad(0, 1, size*3, size), width,  height},
        idleUp ={love.graphics.newQuad(1, 0, size,size), width,  height},
        idleDown = {love.graphics.newQuad(1, 2, size, size), width,  height},
        idleLeft = {love.graphics.newQuad(1, 3, size, size), width,  height},
        idleRight = {love.graphics.newQuad(1, 1, size, size), width,  height},
    }

} 
