local ball = {}

function ball:new(id)
  local x,y = cG.hmScrn,cG.vmScrn
  local radius = 10

  local self = {
    x=x,
    y=y,
    radius = radius,
    bounceCount = 0,
    edges = {
      left = x-radius,
      top = y-radius,
      bottom = y+radius,
      right = x+radius
    },
    sprite = "ball",

    vvel = 0,
    hvel = 0
  }

  local refactorVertices = function()
    local x,y = self.x,self.y
    local radius = self.radius
    self.edges = {
      left = x-radius,
      top = y-radius,
      bottom = y+radius,
      right = x+radius
    }
  end

  local getPosition = function(me,kind)
    local kind = kind or "edges"
    if kind == "xy" then
      return self.x,self.y
    elseif kind == "radius" then
      return self.radius
    else
      return self.edges
    end
  end

  local setPosition = function(me,newX,newY)
    self.y = newY
    self.x = newX
    refactorVertices()
  end
  
  local updatePosition = function()
    self.y = self.y - self.vvel
    self.x = self.x + self.hvel
    refactorVertices()
  end
  
  local setVerticalVelocity = function(me, VV)
    local VV = VV or me
    self.vvel = VV
  end
  
  local setHorizontalVelocity = function(me, HV)
    local HV = HV or me
    self.hvel = HV
  end
  
  local bounce = function(paddle,engAmt,pY)
    local pY = pY or nil
    if paddle ~= nil then
      setHorizontalVelocity(cG.uu(-self.hvel))
    end
    setVerticalVelocity(engAmt)
  end

  local checkCollisions = function(me,pdls)
    for n,paddle in pairs(pdls) do
      local coll,engAmt,pY = cCollision.ball(me,paddle)
      if coll then
        bounce(paddle,engAmt,pY)
      end
    end
    if self.edges.bottom >= cG.bScrn or self.edges.top <= cG.tScrn then
      bounce(nil,-self.vvel)
    end
  end

  local update = function(me,pdls)
    checkCollisions(me,pdls)
    updatePosition()
  end
  
  local reset = function(me)
    setVerticalVelocity(0)
    setHorizontalVelocity(0)
    bounceCount = 0
    updatePosition()
    me:setPosition(cG.hmScrn,cG.vmScrn)
  end
  
  return {
    update = update,
    reset = reset,
    getPosition = getPosition,
    setPosition = setPosition,
    setHVel = setHorizontalVelocity,
    setVVel = setVerticalVelocity
  }
end

return ball