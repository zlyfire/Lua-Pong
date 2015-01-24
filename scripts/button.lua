local button = {}

function button:new(coords, name)
  local self = {
    verts = coords,
    name = name,
    state = "inactive",
    prevstate = "inactive"
  }
  local getVerts = function()
    return self.verts
  end

  local getName = function()
    return self.name
  end

  local getState = function()
    return self.state
  end

  local getPrevState = function()
    return self.prevstate
  end

  local getStateColor = function()
    return nil
  end

  local setName = function(me,nm)
    self.name = nm
  end

--Possible states: "inactive", "hovered", "pressed", active
  local setState = function(me,state)
    local success = false
    do
      self.prevstate = self.state
      self.state = state
      success = true
    end
    return success
  end

  return {
    getVerts = getVerts,
    getName = getName,
    getState = getState,
    getPrevState = getPrevState,
    getStateColor = getStateColor,

    setName = setName,
    setState = setState
  }
end

return button