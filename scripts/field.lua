local field = {}

local doneOnce = false

function field.init()
    paddle1 = cPaddle:new(1)
    paddle2 = cPaddle:new(2)

    doneOnce = true
end

function field.update()
  if not doneOnce then
    field.init()
  end
end

function field.draw()
  cDraw.paddle(paddle1,c_white)
  cDraw.paddle(paddle2,c_white)
end

return field