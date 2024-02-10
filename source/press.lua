import "press_tail"
import "utils"

local pd <const> = playdate
local gfx <const> = pd.graphics

local FALL_TIME_INIT <const> = 1
local UPPER_POINT <const> = 40
local LOWER_POINT <const> = 180
local ASCEND_SPEED <const> = 3

local PressState = {
    UnderCeiling = {},
    Falling = {},
    OnFloor = {},
    Ascending = {}
}

-- local PressUpdates = {
--     [PressState.Above] = function(Press) do end
-- }

class('Press').extends(gfx.sprite)

function Press:init(x, opposite)
    self.opposite = opposite or false
    self.press_state = PressState.UnderCeiling
    self.fall_time = FALL_TIME_INIT
    self.rest_time = 0

    self.clangSound = pd.sound.sampleplayer.new("sounds/clang")
    self.clickSound = pd.sound.sampleplayer.new("sounds/click")
    self.pullingChaingSound = pd.sound.sampleplayer.new("sounds/pulling-chain")

    self:setImage(getPressImage(self.opposite))
    self:add()
    self:setCollideRect(0, 0, self:getSize())
    self.collisionResponse = function(other)
        return gfx.sprite.kCollisionTypeOverlap
    end
    
    self.x = x
    self.y = 40
    self:moveTo(self.x, self.y)
    self.tail = PressTail(self, self.opposite)
end

function Press:startFall()
    if self.press_state == PressState.UnderCeiling then
        self.press_state = PressState.Falling
    end
end

function Press:move(delta)
    local direction = self.opposite and -1 or 1
    self:moveBy(direction * delta, 0)

    if self.x < -self.width/2 then
        self.x += SCREEN_WIDTH + self.width / 2
    elseif self.x > SCREEN_WIDTH + self.width / 2 then
        self.x += -SCREEN_WIDTH - self.width
    end
    self:moveTo(self.x, self.y)
end

function Press:update()
    if pd.buttonJustPressed(pd.kButtonB) and self.press_state == PressState.UnderCeiling then
        self.press_state = PressState.Falling
    end

    local change, acceleratedChange = pd.getCrankChange()
    self:move(acceleratedChange)

    if self.press_state == PressState.Falling then
        local delta = self.fall_time * self.fall_time
        self.fall_time += 1

        if self.y + delta > LOWER_POINT then
            delta = LOWER_POINT - self.y
        end
        self:fall(delta)
    elseif self.press_state == PressState.Ascending then
        local delta = -ASCEND_SPEED
        if self.y + delta < UPPER_POINT then
            delta = UPPER_POINT - self.y
        end
        -- todo: write it's own function
        self:fall(delta)
        if self.y <= UPPER_POINT then
            self.y = UPPER_POINT
            self.press_state = PressState.UnderCeiling
            -- self.clickSound:play()
        end
    elseif self.press_state == PressState.OnFloor then
        self.rest_time += 1
        if self.rest_time == 5 then
            self.press_state = PressState.Ascending
            self.rest_time = 0
            -- self.pullingChaingSound:play()
        end
    end
end

function Press:fall(delta)
    self:moveBy(0, delta)
    local actualX, actualY, collisions, length = self:checkCollisions(self.x, self.y + delta)
    -- local actualX, actualY, collisions, length = self:moveWithCollisions(self.x, self.y + delta)
    if length > 0 then
        for _, collision in pairs(collisions) do
            local collidedObject = collision['other']
            if collidedObject:isa(Human) and collision['normal'].dy == -1 then
                collidedObject:hit()
                self.press_state = PressState.Ascending
                -- self.pullingChaingSound:play()
                setShakeAmount(2)
            end
        end
    end

    if self.y >= LOWER_POINT then
        self.press_state = PressState.OnFloor
        self.clangSound:play()
        setShakeAmount(8)
    end
    if self.press_state ~= PressState.Falling then
        self.fall_time = FALL_TIME_INIT
    end
end

function getPressImage(behind)
    local pressImage = gfx.image.new(40, 80)
    local imageMask = pressImage:getMaskImage():copy()
    local ditherMask = imageMask:copy()

    gfx.pushContext(pressImage)
        gfx.setColor(gfx.kColorBlack)
        if behind == true then
            gfx.setDitherPattern(0.5, gfx.image.kDitherTypeDiagonalLine)
        end
        gfx.fillRect(10, 0, 20, 80, ditherMask)
        gfx.fillRect(0, 60, 40, 20, ditherMask)
    gfx.popContext()
    return pressImage
end