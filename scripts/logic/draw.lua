local draw = {}

function draw.text(text, x, y, color)
  draw.setColor(color)
  local make = love.graphics.print
  if text ~= nil then
    make(text, x, y)
  end
end

function draw.textC(text, x, y, maxW, color)
  draw.setColor(color)
  local make = love.graphics.printf
  if text ~= nil then
    make(text, x, y, maxW, "center")
  end
end

function draw.image(image, x, y, rotation, scaleX, scaleY)
  local rotation = rotation or 0
  local make = love.graphics.draw
  if image ~= nil then
    make(image, x, y, rotation, scaleX, scaleY)
  else
    make(missingTexture, x, y, rotation, scaleX, scaleY)
  end
end

--vertices are defined counterclockwise
function draw.poly(mode, verts, color)
  mode = mode or "fill"
  draw.setColor(color)
  local make = love.graphics.polygon
  if mode ~= nil and verts ~= nil then
    make(mode,verts)
  end
end

function draw.btn(btn, color, textColor)
  local color,textColor = cG.copytable(color),cG.copytable(textColor)
  do
    local state = btn:getState()
    if state == "inactive" then
      color = btn:getStateColor(state) or color
    elseif state == "hovered" then
      color[1] = color[1] + 255
    elseif state == "pressed" then
      color[2] = color[2] + 255
    elseif state == "active" then
      color[3] = color[3] + 255
    else
      color = color
    end
    textColor = cG.invertColor(color)
  end
  if btn ~= nil then
    local verts = btn:getVerts()
    draw.poly("fill", verts, color)
    local width = verts[7] - verts[1]
    local centerH = ((verts[4] - verts[2])/2)+verts[2]
    draw.textC(btn:getName(), verts[1], centerH-(fontH/2), width, textColor)
  end
end

function draw.paddle(pdl, color)
  local color = color or c_white
  if pdl ~= nil then
    local verts = pdl
    --draw.poly("fill", verts, color)
    local y = 0
    for p,n in pairs(pdl) do
      y = y+31
      draw.text(tostring(p),0,y,c_green)
    end
    draw.text(tostring(paddle1).." ? "..tostring(verts),0,y+31,c_green)
  end
end

function draw.entity(entity)
  if entity ~= nil then
    local x,y = entity:getPos()
    local sprite = spriteTable[entity:getSprite()]
    local sprW,sprH = sprite:getDimensions()
    local eW,eH = entity:getDimensions()
    local sW,sH = eW/sprW,eH/sprH
    draw.image(sprite, x,y, 0, 4,4)
  end
end

function draw.setColor(color)
  color = color or c_green
  love.graphics.setColor(color)
end

function draw.setGScale(sw,sh)
  make = love.graphics.scale
  make(sw,sh)
end

function draw.newFont(name, spot, size)
  local size = size or 10
  local nFont = love.graphics.newFont(spot, size)
  font[name..size] = nFont
end

function draw.setFont(name, size)
  local size = size or cFont:getHeight()
  local tFont = font[name..size]
  if tFont ~= nil then
    love.graphics.setFont(tFont)
    fontH = tFont:getHeight() or size
  else
    --Font doesn't exist!
  end
end

function draw.clear(color1, color2)
  --local color2 = color2 or color1
  love.graphics.setBackgroundColor(color1)
  love.graphics.clear()
  --canvas:clear(color2)
end

return draw