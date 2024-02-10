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
    -- local xs = {}
    -- for _, press in ipairs(self.presses) do
    --     table.insert(xs, press.x)
    -- end
    -- table.sort(xs, function(a, b) return a > b end)
    -- if xs then
    --     print(xs[1] - xs[2], xs[2] - xs[3])
    -- end
end