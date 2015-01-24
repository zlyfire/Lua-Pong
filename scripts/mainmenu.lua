local mainmenu={}

local buttons = {}
local btnID = 0

local doneOnce = false

local function newBtn(name)
  local yT = 200+(75*btnID)
  local yB = 250+(75*btnID)
  local coords = {btnSideLeft, yT, btnSideLeft, yB, btnSideRight, yB, btnSideRight, yT}

  buttons[name] = cButton:new(coords, name)
  btnID = cG.qu(btnID)
  return buttons[name]
end

local function doBtnThing(btn)
  if btn == btn_newGame then
    cBtnActions.newGame()
  end
  if btn == btn_options then
    cBtnActions.options()
  end
end

function mainmenu.update()
  if not doneOnce then
    btnSideLeft = cG.hmScrn-(cG.hmScrn/2)
    btnSideRight = cG.hmScrn+btnSideLeft

    btn_newGame = newBtn("New Game")
    btn_options = newBtn("Options")

    doneOnce = true
  end

  for n,btn in pairs(buttons) do
    if cCollision.basic(mouse, btn) then
      if mouse:pressed("l") then
          btn:setState("pressed")
      elseif mouse:released("l") and btn:getPrevState() == "pressed" then
        btn:setState("active")
        doBtnThing(btn)
      else
        btn:setState("hovered")
      end
    else
      btn:setState("inactive")
    end
  end

  bkgColor = c_rock
end

function mainmenu.draw()
  cDraw.setFont("coelacanth",30)
  for n,btn in pairs(buttons) do
    cDraw.btn(btn, c_blue, c_green)
  end
  cDraw.setFont("defFont",10)
end

return mainmenu
