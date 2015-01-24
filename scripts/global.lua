local global = {}

local windowW, windowH = love.graphics.getDimensions()

global.tScrn = 0
global.bScrn = windowH
global.lScrn = 0
global.rScrn = windowW
global.vmScrn = windowH/2
global.hmScrn = windowW/2

function global.qu(value)
  return value + 1
end

function global.qd(value)
  return value - 1
end

function global.between(a,l,r)
  return (a >= l and a <= r)
end

function global.copytable(table)
  local copy = {}
  for k,v in pairs(table) do
    copy[k] = v
  end
  return copy
end

function global.invertColor(color)
  local new = {}
  for n, byte in ipairs(color) do
    new[n] = 255-byte
  end
    new[4] = 255
  return new
end

return global
