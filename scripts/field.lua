local field = {}

local doneOnce = false
local fieldColor = c_black

function field.init()
    paddle1 = cPaddle:new(1)
    paddle2 = cPaddle:new(2)

    doneOnce = true
end

function field.update()
  if not doneOnce then
    field.init()
  end
  field.doPaddleThings(paddle1)
  field.doPaddleThings(paddle2)
end

function field.draw()
  cDraw.clear(fieldColor)
  cDraw.paddle(paddle1,c_white)
  cDraw.paddle(paddle2,c_white)
end

function field.doPaddleThings(which)
  which:updateControls()
  which:controls()
  which:update()
end

return field