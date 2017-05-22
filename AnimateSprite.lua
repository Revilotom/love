local managerVersion = 1.0 

spriteBank = {}
imageBank = {}

function LoadSprite(spriteDef)
    if spriteDef == nil then return nil end

    local defFile = loadfile (spriteDef)

    if defFile == nil then

        print("attempt to load an invalid file: " .. spriteDef)

        return nil
    end



    local oldSprite = spriteBank[spriteDef]
    spriteBank [spriteDef] = defFile()
    
    if spriteBank[spriteDef].serialization_version ~= ManagerVersion then
        print("attempt to load file with incompatible versions" .. spiteDef)
        print("Expected version" .. ManagerVersion .. " got version " .. spriteBank[spriteDef].serialization_version .. " .")
        spriteBank[spriteDef] = oldSprite

        return spriteBank[spriteDef]

    end

    local spriteSheet = spritebank[spriteDef].spriteSheet

    local oldImage = imageBank [spriteSheet]
    imageBank[spriteSheet] = love.graphics.newImage(spriteSheet)


    if imageBank[spriteSheet] == nil then
        imageBank[spriteSheet] = oldimage
        spriteBank[spriteDef] = oldSprite

        print("Failed loading sprite "..spriteDef..", invalid image path ("..spriteSheet..").")
    end

    return spriteBank[spriteDef]
end

function GetInstance(spriteDef)
    if spriteDef == nil then return nul end

    if spriteBank[spriteDef] == nil then 
        
        if LoadSprite (spriteDef) == nil then return nil end
        
    end


    return {
        sprite = spriteBank[spriteDef],
        currentAnimation = spriteBank[spriteDef].animationsNames[1],
        currentFrame = 1,
        elapsedTime = 0,
        sizeScale = 1,
        timeScale = 1,
        rotation = 0,
        filpH = 1,
        flipV = 1,
    }

end


function UpdateInstance(s, dt)
    s.elapsedTime = s.elapsedTime +dt

    if s.elapsedTime > s.sprite.frameDuration * spr.timeScale then
        if s.currentFrame < #s.sprite.animations[s.currentAnimation] then
            s.currentFrame = s.currentFrame + 1
        else
            s.currentFrame = 1
        end

        s.elapsedTime = 0
    end
end

function DrawInstance (s, x, y)

    love.graphics.draw(
    imageBank[s.sprite.spriteSheet],
    s.sprite.animations[s.currentAnimation][s.currentFrame],
    x,
    y,
    s.rotation,
    s.sizeScale,
    s.sizeScale,
    flipH,
    flipV)

end

