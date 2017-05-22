tilecollider = require "tilecollider"

tileH = 0
tileW = 0


local tileTable, tileset, quads, tileSetw, tileSeth, tilesetBatch, mapW, mapH
local mapX = 0
local mapY = 0
local handler = nil
local playerX
local playerY


function isResolvable(side, tile, x, y)



    -- print("checking for collision at", x, y, tile)


    if tile == '#' then
        if y == playerY then
            if side == "right" then
                    print("!!!!", x, y)
                    return true
                end
            end


            if side == "left" then
                if x <= playerX then
                    print("adasdas")
                    return true
                end
            end
        end
end
function getTile(x, y)

    if x > mapW or y > mapH or y <=0 or x <= 0 then
        -- print ("out of bounds", x, y)
        return nil
    else
        return tileTable[x][y]
    end
end

function loadMap(path)
    love.filesystem.load(path)()
end

function carryOn(dx, dy)


    mapX = mapX + dx
    mapY = mapY + dy
end 
function moveMap(dx, dy)


    playerX = math.ceil(midX/tileW + mapX)
    playerY = math.ceil(midY/tileW +  mapY)
    newX = math.ceil(handler:rightResolve(playerX*tileW, playerY*tileH, 70, 105)/tileW)


    print("newX", newX, "playerX", playerX)

    olddX = dx

    if newX ~= playerX then
        if dx < 0 then dx = 0 end
    end

    newX = math.ceil(handler:leftResolve(playerX*tileW, playerY*tileH, 70, 105)/tileW)

    if newX ~= playerX then
        if dx > 0 then dx = 0 else dx = olddX end
    end

    carryOn(dx, dy) 





    -- screenWidth = love.graphics.getWidth()/tileW;
    -- screenHeight = love.graphics.getHeight()/tileH;
    -- print("screen width " .. screenWidth)
    -- print("screen height " .. screenHeight) 
    -- print("mapx " .. mapX)
    -- print("mapy " .. mapY)

    -- print("map width " .. mapW)
    -- print("map height " .. mapH)

    -- ylim = screenHeight - mapH + mapY
    -- xlim = screenWidth - mapW + mapX
    -- print("xlim is " .. xlim)
    -- print("ylim is " .. ylim)

    -- if (mapW - mapX > screenWidth or mapW - mapX < 0 or mapH - mapY > screenHeight or mapH + mapY < 0) then
    --     updateTilesetBatch(screenWidth, xlim, ylim)
    -- end
end


function updateTilesetBatch( xlim, ylim)
    tilesetBatch:clear()

    for y=1, mapH  do
        for x=1, mapW + xlim do
            -- print("xlim is " .. xlim)
            -- print("ylim is " .. ylim)
            -- print("coords: " ..  math.floor(x).. " , " .. math.floor(y))
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

    handler = tilecollider(getTile, tileW, tileH, isResolvable) 
end

function drawMap()
    love.graphics.draw(tilesetBatch,  math.floor(-(mapX)*tileW), math.floor(-(mapY)*tileW))
end
