local init = {}

function init.init()
  init.colors()
  init.text()
  init.controls()
  init.level()
end

function init.colors()
  c_white = {255,255,255,255}
  c_black = {0,0,0,255}
  c_red = {255,0,0,255}
  c_green = {0,255,0,255}
  c_blue = {0,0,255,255}
  c_bkg = c_black
end

function init.text()
  local defFont = love.graphics.newFont(30)
  fontH = defFont:getHeight() or 10
  font = {}
  font["defFont10"] = defFont
  cDraw.setFont("defFont", 10)
end

function init.controls()
  love.keyboard.setKeyRepeat(true)
  pl1 = cControls:newKB(1)
  pl2 = cControls:newKB(2)
  mouse = cControls:newM()
end

function init.level()
  playing = false
  MM = true
end

return init
