local collision = {}

function collision.basic(obj1, obj2, adv)
  local adv = adv or false
  local BC = false
  local final = false
  local verts1 = obj1:getVerts()
  local verts2 = obj2:getVerts()

  local obj1L, obj1R = verts1[1], verts1[7]
  local obj2L, obj2R = verts2[1], verts2[7]

  local obj1T, obj1B = verts1[2], verts1[4]
  local obj2T, obj2B = verts2[2], verts2[4]

  if cG.between(obj1L, obj2L,obj2R) or cG.between(obj1R, obj2L,obj2R) then
    if cG.between(obj1T, obj2T,obj2B) or cG.between(obj1B, obj2T,obj2B) then
      BC = true
    end
  end

  if adv then
    if BC then
      final = collision.precise(obj1, obj2)
    end
  else
    final = BC
  end

  return final
end

function collision.precise(obj1, obj2)

end

function collision.sided(obj1, obj2)
  local xb1,yb1 = obj1:getPosition("bounds")
  local L1,R1,T1,B1 = xb1.left,xb1.right,yb1.top,yb1.bottom
  local xb2,yb2 = obj2:getPosition("bounds")
  local L2,R2,T2,B2 = xb1.left,xb1.right,yb1.top,yb1.bottom

  local obj1L, obj1R = verts1[1], verts1[7]
  local obj2L, obj2R = verts2[1], verts2[7]

  local obj1T, obj1B = verts1[2], verts1[4]
  local obj2T, obj2B = verts2[2], verts2[4]
end

return collision
