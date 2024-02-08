local pd <const> = playdate
local gfx <const> = pd.graphics

import "human"
import "helmet"

class('HumanWithHelmet').extends(Human)

function HumanWithHelmet:init()
    HumanWithHelmet.super.init(self)
    self.helmet = Helmet()
    self.helmet_on = true
end

function HumanWithHelmet:update()
    HumanWithHelmet.super.update(self)
    -- print(self.x, self.y)
    if self.helmet then
        self.helmet:moveTo(self.x, self.y - 23)
        if self.x > 400 then
            self.helmet:remove()
        end
    end
end

function HumanWithHelmet:hit()
    if self.helmet_on then
        self.helmet:destroy()
        self.helmet_on = false
    else
        HumanWithHelmet.super.hit(self)
    end
    
end