local pd <const> = playdate
local gfx <const> = pd.graphics

import "press"

class('PressController').extends()

function PressController:init()
    self.presses = {}
end

function PressController:addPress(x, behind)
    table.insert(self.presses, Press(x, behind or false))
end


function PressController:movePresses(delta)
    for _, press in ipairs(self.presses) do
        press:move(delta)
    end
end

function PressController:leftAndRight()
    local left, right = 400, 0
    for _, press in ipairs(self.presses) do
        if press.x < left then
            left = press.x - press.width / 2
        end
        if press.x > right then
            right = press.x + press.width / 2
        end
    end
    return left, right
end

function PressController:update()
    if pd.buttonJustPressed(pd.kButtonB) then
        for _, press in ipairs(self.presses) do
            press:startFall()
        end
    end

    local change, acceleratedChange = pd.getCrankChange()
    local left, right = self:leftAndRight()
    if acceleratedChange < 0 and left > 0 then
        self:movePresses(acceleratedChange)
    elseif acceleratedChange > 0 and right < 400 then
        self:movePresses(acceleratedChange)
    end
end