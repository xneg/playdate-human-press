local pd <const> = playdate
local gfx <const> = pd.graphics

class('Press').extends(gfx.sprite)

function Press:init(x, behind)
    behind = behind or false
    self.behind = behind
    self.width = 40
    local pressImage = gfx.image.new(self.width, 80)
    
    local imageMask = pressImage:getMaskImage():copy()
    local ditherMask = imageMask:copy()

    gfx.pushContext(pressImage)
        gfx.setColor(gfx.kColorBlack)
        if behind == true then
            gfx.setDitherPattern(0.5, gfx.image.kDitherTypeHorizontalLine)
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

function Press:move(delta)
    local direction = self.behind and -1 or 1
    self:moveBy(direction * delta, 0)
end

function Press:fall(delta)
    self:moveBy(0, delta)
end