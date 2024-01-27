import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "press"
import "press_controller"

local pd <const> = playdate
local gfx <const> = pd.graphics

pressController = PressController()

pressController:addPress(100)
pressController:addPress(200, true)
pressController:addPress(300)

function pd.update()
    gfx.sprite.update()
    -- pd.timer.updateTimers()
    pressController:update()
end