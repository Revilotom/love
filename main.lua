require "mapFunctions"
require "input"
require "AnimateSprite"

fullscreen = false
player = nil

function love.load()
    love.window.setMode(1200, 800, {resizable=true, vsync=true, minwidth=400, minheight=300})
    loadMap("maps/blah.lua")
    updateTilesetBatch(0, 0)
    player = GetInstance ("sprites/red.lua")

end

function love.draw()

    drawMap()
	love.graphics.print("FPS: "..love.timer.getFPS(), 10, 20)
    DrawInstance(player, 50, 50)
end


function love.update(dt)
    getInput(dt)
    print(player)
    UpdateInstance(player, dt)
end

function love.keyreleased(key)
    if key == "escape" then
	    fullscreen  = not fullscreen
	    love.window.setFullscreen(fullscreen, "desktop")
        updateTilesetBatch( 0,0)
    end
end
