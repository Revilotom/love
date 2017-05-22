function getInput(dt)
  if love.keyboard.isDown("up")  then
    moveMap(0, -0.2 * tileW * dt)
    return 0
  end
  if love.keyboard.isDown("down")  then
    moveMap(0, 0.2 * tileW * dt)
    return 2 
  end
  if love.keyboard.isDown("left")  then
    moveMap(0.2 * tileW * dt, 0)
    return 3
  end
  if love.keyboard.isDown("right")  then
    moveMap(-0.2 * tileW * dt, 0)
    return 1 
  end
  return -1
end


function love.keyreleased(key)
    if key == "escape" then
	    fullscreen  = not fullscreen
	    love.window.setFullscreen(fullscreen, "desktop")
        updateTilesetBatch( 0,0)
    end
end
