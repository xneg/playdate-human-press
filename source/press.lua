local pd <const> = playdate
local gfx <const> = pd.graphics

class('Press').extends(gfx.sprite)

function Press:init(x, behind)
    behind = behind or false
    self.behind = behind
    local pressImage = gfx.image.new(40, 80)

    local imageMask = pressImage:getMaskImage():copy()
    local ditherMask = imageMask:copy()

    gfx.pushContext(pressImage)
        gfx.setColor(gfx.kColorBlack)
        if behind == true then
            gfx.setDitherPattern(0.5, gfx.image.kDitherTypeBayer8x8)
        end
        gfx.fillRect(10, 0, 20, 80, ditherMask)
        gfx.fillRect(0, 60, 40, 20, ditherMask)
    gfx.popContext()
    self:setImage(pressImage)
    self:add()
    
    self.x = x
    self.y = 40
    self:moveTo(self.x, self.y)
end

function Press:update()
    local change, acceleratedChange = pd.getCrankChange()

    if acceleratedChange < 0 then
        if self.x > 0 then
            self:moveBy(acceleratedChange / 10, 0)
        end
    elseif acceleratedChange > 0 then
        if self.x < 400 then
            self:moveBy(acceleratedChange / 10, 0)
        end
    end
end