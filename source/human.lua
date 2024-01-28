local pd <const> = playdate
local gfx <const> = pd.graphics

class('Human').extends(gfx.sprite)

local SPEED = 4

function Human:init()
    self.width = 20
    local humanImage = gfx.image.new(self.width, 40)

    gfx.pushContext(humanImage)
        gfx.setColor(gfx.kColorBlack)
        gfx.fillRect(0, 0, 20, 40)
    gfx.popContext()
    self:setImage(humanImage)
    self:add()
    
    self:setCollideRect(0, 0, self:getSize())

    self.x = 0
    self.y = 200
    self:moveTo(self.x, self.y)
end

function Human:update()
    local actualX, actualY, collisions, length = self:moveWithCollisions(self.x + SPEED, self.y)
    -- self:moveBy(4, 0)
    if self.x > 400 then
        self:remove()
    end
end