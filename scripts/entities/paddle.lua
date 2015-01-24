local paddle = {}

function paddle:new(id)
  local pos
  local x,y = 0,cG.hmScrn
  local width,height = 5,25

  if id == 1 then
    x = cG.lScrn +10
    pos = "left"
  elseif id == 2 then
    x = cG.rScrn -10
    pos = "right"
  else
    x = 0
    pos = nil
  end

  local self = {
    id=id,
    pos=pos,
    x=x,
    y=y,
    width= width,
    height = height,
    verts = {
      x,y-(height/2),
      x,y+(height/2),
      x+width,y+(height/2),
      x+width,y-(height/2)
    },
    xBound = {
      left=x,
      right=x+width
    },
    yBound = {
      top=y-(height/2),
      bottom=y+(height/2)
    },
    sprite = "paddle",

    vvel = 0
  }

  local refactorVertices = function()
    local ov = self.verts
    local x,y = self.x,self.y
    local width,height = self.width,self.height
    self.verts = {
      x,y-(height/2),
      x,y+(height/2),
      x+width,y+(height/2),
      x+width,y-(height/2)
    }
    self.xBound = {
      left=x,
      right=x+width
    }
    self.yBound = {
      top=y-(height/2),
      bottom=y+(height/2)
    }
  end

  local getPosition = function(me,kind)
    --local kind = kind or "verts"
    --if kind == "xy" then
    --  return self.x,self.y
    --elseif kind == "verts" then
    --  return self.verts
    --elseif kind == "bounds" then
    --  return self.xBound,self.yBound
    --else
      return self.verts
    --end
  end

  local setPosition = function(me,dY)
    self.y = self.y+dY
    refactorVertices()
  end

  local setVerticalVelocity = function(me,VV)
    self.vvel = VV
  end

  local update = function(me)
    local ty = self.y

    ty = ty+self.vvel

    self.y = ty
  end

  local controls = function(me)
    local kb
    if self.id == 1 then
      kb = paddle1
    else
      kb = paddle2
    end
    if(kb:pressed("up") or kb:pressed("right")) and self.y>cG.tScrn then
      me:setVVel(5)
    elseif(kb:pressed("down") or kb:pressed("left")) and self.y<cG.bScrn then
      me:setVVel(-5)
    else
      me:setVVel(0)
    end
  end

  return {
    update = update,
    controls = controls,
    getPosition = getPosition,
    setPosition = setPosition
  }
end

return paddle