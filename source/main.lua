import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "press"
import "human_conveyer"
import "screen_shake"
import "score_display"

local pd <const> = playdate
local gfx <const> = pd.graphics

local screenShakeSprite = ScreenShake()

function setShakeAmount(amount)
    screenShakeSprite:setShakeAmount(amount)
end

createScoreDisplay()

-- (400 + press.width) / 3
Press(0)
Press(147)
Press(293)

HumanConveyer()

function pd.update()
    gfx.sprite.update()
    pd.timer.updateTimers()
end