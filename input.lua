function getInput(dt)
  if love.keyboard.isDown("up")  then
    moveMap(0, -0.2 * tileW * dt)
  end
  if love.keyboard.isDown("down")  then
    moveMap(0, 0.2 * tileW * dt)
  end
  if love.keyboard.isDown("left")  then
    moveMap(0.2 * tileW * dt, 0)
  end
  if love.keyboard.isDown("right")  then
    moveMap(-0.2 * tileW * dt, 0)
  end
end 
