local field = {}

local doneOnce,roundStart = false,false
local fieldColor = c_black

function field.init()
    paddle1 = cPaddle:new(1)
    paddle2 = cPaddle:new(2)
    
    ball = cBall:new()
    
    doneOnce = true
end

function field.update()
  if not doneOnce then
    field.init()
  end
  field.startRound()
  paddle1:update()
  paddle2:update()
  ball:update({paddle1,paddle2})
  field.endRound()
end

function field.startRound()
  if not roundStart then
    if pl1:pressed(" ") then
      local heading = cG.rand(0,10)
      while cG.between(heading, 4,6) do
        heading = cG.rand(0,10)
      end
      ball:setHVel(heading-5)
      ball:setVVel(heading-5)
      roundStart = true
    end
  end
end

function field.endRound()
  local bX,bY = ball:getPosition("xy")
  if bX > cG.rScrn then
    paddle1:addScore(1)
    ball:reset()
    roundStart = false
  elseif bX < cG.lScrn then
    paddle2:addScore(1)
    ball:reset()
    roundStart = false
  end
end

function field.draw()
  cDraw.paddle(paddle1,c_white)
  cDraw.paddle(paddle2,c_white)
  cDraw.ball(ball,c_white)
  if paddle1 ~= nil then
    cDraw.text(paddle1:getScore(), cG.lScrn,cG.tScrn)
    cDraw.textR(paddle2:getScore(), cG.rScrn,cG.tScrn, cG.rScrn)
  end
end

return field