local paddle = {}

function paddle:new(id)
  local pos
  local x,y = 0,cG.vmScrn
  local width,height = 15,75
  local kb

  if id == 1 then
    x = cG.lScrn + width
    pos = "left"
    kb = pl1
  elseif id == 2 then
    x = cG.rScrn - (width*2)
    pos = "right"
    kb = pl2
  else
    x = 0
    pos = nil
    kb = nil
  end

  local self = {
    id=id,
    pos=pos,
    kb=kb,
    x=x,
    y=y,
    width= width,
    height = height,
    score = 0,
    verts = {
      x,y-(height/2),
      x,y+(height/2),
      x+width,y+(height/2),
      x+width,y-(height/2)
    },
    edges = {
      left=x,
      right=x+width,
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
    self.edges = {
      left=x,
      right=x+width,
      top=y-(height/2),
      bottom=y+(height/2)
    }
  end

  local getID = function(me)
    return self.ID
  end
  
  local getPosition = function(me,kind)
    local kind = kind or "verts"
    if kind == "xy" then
      return self.x,self.y
    elseif kind == "verts" then
      return self.verts
    elseif kind == "edges" then
      return self.edges
    else
      return self.verts
    end
  end
  
  local getScore = function(me)
    return self.score
  end

  local setPosition = function(me,newY)
    self.y = newY
    refactorVertices()
  end
  
  local updatePosition = function()
    self.y = self.y - self.vvel
    refactorVertices()
  end
  
  local setVerticalVelocity = function(VV)
    self.vvel = VV
  end
  
  local addScore = function(me,dScore)
    self.score = self.score + dScore
  end

  local controls = function(me)
    if(self.kb:pressed("w") or self.kb:pressed("up")) and self.y>cG.tScrn then
      setVerticalVelocity(5)
    elseif(self.kb:pressed("s") or self.kb:pressed("down")) and self.y<cG.bScrn then
      setVerticalVelocity(-5)
    else
      setVerticalVelocity(0)
    end
  end

  local update = function(me)
    kb:updateBtns()
    controls()
    updatePosition()
  end

  return {
    update = update,
    controls = controls,
    getPosition = getPosition,
    getID = getID,
    addScore = addScore,
    setPosition = setPosition,
    getScore = getScore
  }
end

return paddle