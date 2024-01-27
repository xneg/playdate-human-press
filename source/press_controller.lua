local pd <const> = playdate
local gfx <const> = pd.graphics

local FALL_TIME_INIT = 6
local UPPER_POINT = 0
local LOWER_POINT = 150
local ASCEND_SPEED = 4

class('PressController').extends()

function PressController:init()
    self.presses = {}
    self.falling = false
    self.ascending = false
    self.fall_time = FALL_TIME_INIT
    self.y = 0
end

function PressController:addPress(x, behind)
    table.insert(self.presses, Press(x, behind or false))
end


function PressController:movePresses(delta)
    for _, press in ipairs(self.presses) do
        press:move(delta)
    end
end

function PressController:fallPresses(delta)
    self.y += delta
    for _, press in ipairs(self.presses) do
        press:fall(delta)
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
    if pd.buttonJustPressed(pd.kButtonB) and self.falling == false and self.ascending == false then
        self.falling = true
    end

    if self.falling == true then
        local delta = self.fall_time * self.fall_time
        self.fall_time += 1
        if self.y + delta > LOWER_POINT then
            delta = LOWER_POINT - self.y
        end
        self:fallPresses(delta)
        if self.y == LOWER_POINT then
            self.falling = false
            self.ascending = true
            self.fall_time = FALL_TIME_INIT
        end
        coroutine.yield()
    end

    if self.ascending == true then
        local delta = -ASCEND_SPEED
        if self.y + delta < UPPER_POINT then
            delta = -self.y
        end
        self:fallPresses(delta)
        if self.y == UPPER_POINT then
            self.ascending = false
        end
    end

    local change, acceleratedChange = pd.getCrankChange()
    local left, right = self:leftAndRight()
    if acceleratedChange < 0 and left > 0 then
        self:movePresses(acceleratedChange/ 10)
    elseif acceleratedChange > 0 and right < 400 then
        self:movePresses(acceleratedChange/ 10)
    end
end