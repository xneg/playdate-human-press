import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "press_controller"
import "human_conveyer"

local pd <const> = playdate
local gfx <const> = pd.graphics

pressController = PressController()

pressController:addPress(100)
pressController:addPress(200, true)
pressController:addPress(300)

HumanConveyer()

function pd.update()
    gfx.sprite.update()
    pd.timer.updateTimers()
    pressController:update()
end