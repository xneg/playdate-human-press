import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "press_controller"
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

pressController = PressController()

-- (400 + press.width) / 3
pressController:addPress(0)
pressController:addPress(147)
pressController:addPress(293)

HumanConveyer()

function pd.update()
    gfx.sprite.update()
    pd.timer.updateTimers()
    pressController:update()
end