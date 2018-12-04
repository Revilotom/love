require "mapFunctions"
require "input"
require "AnimateSprite"

midX = love.graphics.getWidth()/2 +160
midY = love.graphics.getHeight()/2 - 20

local fullscreen = false
local dir
local newdir


function love.load()
    love.window.setMode(1200, 800, {resizable=true, vsync=true, minwidth=400, minheight=300})
    loadMap("maps/blah.lua")
    updateTilesetBatch(0, 0)
    player = GetInstance ("sprites/dotty.lua")
    player.currentAnimation = "idleDown"
end

function love.draw()
    drawMap()
	love.graphics.print("FPS: "..love.timer.getFPS(), 10, 20)
    DrawInstance(player, midX, midY)
end


function love.update(dt)

    oldir = newdir
    newdir = getInput(dt)
    SwitchAnimation(player, oldir, newdir) 
    UpdateInstance(player, dt)
end

