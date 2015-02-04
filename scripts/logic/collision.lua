local collision = {}

function collision.basic(obj1, obj2)
  local coll = false
  local verts1 = obj1:getVerts()
  local verts2 = obj2:getVerts()

  local obj1L, obj1R = verts1[1], verts1[7]
  local obj2L, obj2R = verts2[1], verts2[7]

  local obj1T, obj1B = verts1[2], verts1[4]
  local obj2T, obj2B = verts2[2], verts2[4]

  if cG.between(obj1L, obj2L,obj2R) or cG.between(obj1R, obj2L,obj2R) then
    if cG.between(obj1T, obj2T,obj2B) or cG.between(obj1B, obj2T,obj2B) then
      coll = true
    end
  end

  return coll
end

function collision.ball(ball,paddle)
  local coll = false
  local ballEdges = ball:getPosition("edges")
  local paddleEdges = paddle:getPosition("edges")
  local ballX, ballY = ball:getPosition("xy")
  local paddleX, paddleY = paddle:getPosition("xy")
  
  local ballT, ballB = ballEdges["top"], ballEdges["bottom"]
  local ballL, ballR = ballEdges["left"], ballEdges["right"]
  
  local paddleT, paddleB = paddleEdges["top"], paddleEdges["bottom"]
  local paddleL, paddleR = paddleEdges["left"], paddleEdges["right"]


  if cG.between(ballT, paddleT,paddleB) or cG.between(ballB, paddleT,paddleB) then
    if cG.between(ballL, paddleL,paddleR) or cG.between(ballR, paddleL,paddleR) then
      coll = true
    end
  end
  if coll then
    local englishAmount = (paddleY - ballY)/4
    return coll,englishAmount,paddleY
  end
  return coll
end

return collision
