require("requires")

function love.load()
  cInit.init()
end

function love.focus(f)
  gamePaused = not f
end

function love.update(dt)
  if gamePaused then
    return
  end
  if not playing then
    if MM then
      cMainMenu.update()
    end
  --  if options then
  --    optionsMenu.update()
  --  end
  --else
  --  gameField.update()
  elseif playing then
    cField.update()
  end
end

function love.draw()
  cDraw.clear(c_black)
  if gamePaused then
    local t,l,b,r = 0,0,640,480
    cDraw.poly("fill", {t,l, b,l, b,r, t,r}, {97,97,97,97})
    return
  end
  
  if not playing then
    if MM then
      cMainMenu.draw()
    end
  --  if options then
  --    optionsMenu.draw()
  --  end
  --else
  --  gameField.draw()
  elseif playing then
    cField.draw()
  end
end

function love.keypressed(key)
  if key == "escape" then
    love.event.push("quit")
  end
end
