import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "press"

local pd <const> = playdate
local gfx <const> = pd.graphics

Press(100)
Press(200, true)
Press(300)

function pd.update()
    gfx.sprite.update()
    pd.timer.updateTimers()
end