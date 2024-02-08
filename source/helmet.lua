local pd <const> = playdate
local gfx <const> = pd.graphics

class('Helmet').extends(gfx.sprite)

function Helmet:init()
    self.destroySound = pd.sound.sampleplayer.new("sounds/metal_clank")
    local image = gfx.image.new(10, 6)

    gfx.pushContext(image)
        gfx.setColor(gfx.kColorBlack)
        gfx.fillRect(2, 0, 6, 3)
        gfx.fillRect(0, 3, 10, 3)
    gfx.popContext()
    self:setImage(image)
    self:add()
    
    self:setCollideRect(0, 0, self:getSize())
end

function Helmet:destroy()
    self.destroySound:play()
    self:remove()
end