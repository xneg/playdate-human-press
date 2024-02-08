local pd <const> = playdate
local gfx <const> = pd.graphics

import "utils"

class('Human').extends(gfx.sprite)

local SPEED <const> = 4

function Human:init()
    self.boneBreakSound = pd.sound.sampleplayer.new("sounds/fart")
    self.noSound = pd.sound.sampleplayer.new("sounds/no")
    self.width = 20
    local humanImage = gfx.image.new(self.width, 40)

    gfx.pushContext(humanImage)
        gfx.setColor(gfx.kColorBlack)
        local ditherType = getRandomDitherType()
        if ditherType ~= nil then
            gfx.setDitherPattern(0.5, ditherType)
        end
        gfx.fillRect(6, 0, 8, 8)
        gfx.fillRect(0, 7, 20, 20)
        gfx.fillRect(3, 25, 14, 20)
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
    -- self:moveBy(SPEED, 0)
    if self.x > 400 then
        -- if getRandomEvent(3) then
        --     getRandomEscapeCry():play()
        -- end
        decrementScore()
        self:remove()
    end
end

function Human:hit()
    -- if getRandomEvent(10) then
    --     self.noSound:play()
    -- end
    incrementScore()
    self.boneBreakSound:play()
    self:remove()
end

local escapeCries <const> = {
    -- pd.sound.sampleplayer.new("sounds/oh-yes"),
    pd.sound.sampleplayer.new("sounds/whoah"),
    pd.sound.sampleplayer.new("sounds/yess"),
}

function getRandomEscapeCry()
    local randomIndex = math.random(#escapeCries)
    return escapeCries[randomIndex]
end