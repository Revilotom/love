tileH = 0
tileW = 0

local tileTable, tileset, quads, tileSetw, tileSeth, tilesetBatch, mapW, mapH
local mapX = 0
local mapY = 0


function collide(side, tile, x, y)

    if tile == '#' then
        return true
    end
end


function getTile(x, y)

    if x > mapW or y > mapH or y <=0 or x <= 0 then
        return nil
    else
        return tileTable[math.ceil(x)][math.ceil(y)]
    end
end

function loadMap(path)
    love.filesystem.load(path)()
end


function moveMap(dx, dy)


    playerX = midX/tileW + mapX
    playerY = midY/tileW +  mapY


    if dx < 0 then
        if collide("right", getTile(playerX-0.9, playerY), playerX-0.9, playerY) or
            collide("right", getTile(playerX-0.9, playerY+1.8), playerX-0.9, playerY+1.8)or
            collide("right", getTile(playerX-0.9, playerY+1), playerX-0.9, playerY+1)then
            dx = 0
        end
    end

    if dx > 0 then
        if collide ("left", getTile(playerX+1, playerY), playerX+1, playerY) or  
            collide ("left", getTile(playerX+1, playerY+1.8), playerX+1, playerY+1.8)or 
            collide("left", getTile(playerX+1, playerY+1), playerX+1, playerY+1)then
            dx = 0
        end
    end

    if dy > 0 then
        if collide("down", getTile(playerX, playerY+2), playerX, playerY+2) or 
            collide("down", getTile(playerX+0.6, playerY+2), playerX+0.6, playerY+2) or 
            collide("down", getTile(playerX-0.6, playerY+2), playerX-0.6, playerY+2) then 
            dy = 0
        end
    end

    if dy < 0 then
        if collide("up", getTile(playerX, playerY-0.2), playerX, playerY-0.2) or
            collide("up", getTile(playerX+0.6, playerY-0.2), playerX+0.6, playerY-0.2) or
            collide("up", getTile(playerX-0.6, playerY-0.2), playerX-0.6, playerY-0.2) then
            dy = 0
        end
    end

    mapX = mapX + dx
    mapY = mapY + dy
end


function updateTilesetBatch( xlim, ylim)
    tilesetBatch:clear()

    for y=1, mapH  do
        for x=1, mapW + xlim do
            tilesetBatch:add(quads[tileTable[x][y]], x * tileW, y * tileH) 
        end
    end

    print("tiles being rendered: " .. tilesetBatch:getCount())
end


function newMap(w, h, tileSetPath, quadInfo, tileString)

    tileW = w
    tileH = h

    tileTable = {} 
    tileset = love.graphics.newImage(tileSetPath)

    tileSetw, tileSeth = tileset:getWidth(), tileset:getHeight()
    width  = #(tileString:match("[^\n]+"))
    for x = 1, width, 1 do tileTable[x] = {} end
    local rowi, coli = 1,1
    for row in tileString:gmatch("[^\n]+") do
        assert(#row == width, "Map is not aligned: width of row " .. tostring(rowi) .. " should be " .. tostring(width) .. ", but is: " .. tostring(#row))
        coli = 1
        for character in row:gmatch(".") do
            tileTable[coli][rowi] = character
            coli = coli + 1
        end
        rowi = rowi +1
    end

    mapH = rowi-1
    mapW = coli-1

    quads = {}
    for _, info in ipairs (quadInfo) do 
        quads[info[1]] = love.graphics.newQuad(info[2], info[3], tileW, tileH, tileSetw, tileSeth )
    end

    tilesetBatch = love.graphics.newSpriteBatch(tileset, tileSetw * tileSeth)

end

function drawMap()
    love.graphics.draw(tilesetBatch,  math.floor(-(mapX)*tileW), math.floor(-(mapY)*tileW))
end
