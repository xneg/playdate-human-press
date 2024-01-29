local pd <const> = playdate
local gfx <const> = pd.graphics

class('PressTail').extends(gfx.sprite)

function PressTail:init(x, y, behind)
    behind = behind or false
    self.behind = behind
    self.width = 40
    local pressImage = gfx.image.new(self.width, 160)
    
    local imageMask = pressImage:getMaskImage():copy()
    local ditherMask = imageMask:copy()

    gfx.pushContext(pressImage)
        gfx.setColor(gfx.kColorBlack)
        if behind == true then
            gfx.setDitherPattern(0.5, gfx.image.kDitherTypeDiagonalLine)
        end
        gfx.fillRect(10, 0, 20, 160, ditherMask)
    gfx.popContext()
    self:setImage(pressImage)
    self:add()

    self:moveTo(x, y)
end

function PressTail:move(x, y)
    self:moveTo(x, y)
end