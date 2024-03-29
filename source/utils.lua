local pd <const> = playdate
local gfx <const> = pd.graphics
local img <const> = gfx.image

local ditherTypes <const> = {
    -- img.kDitherTypeNone,
    nil,
    img.kDitherTypeDiagonalLine,
    img.kDitherTypeVerticalLine,
    img.kDitherTypeHorizontalLine,
    -- img.kDitherTypeScreen,
    -- img.kDitherTypeBayer2x2,
    -- img.kDitherTypeBayer4x4,
    -- img.kDitherTypeBayer8x8,
    -- img.kDitherTypeFloydSteinberg,
    -- img.kDitherTypeBurkes,
    -- img.kDitherTypeAtkinson
}

function getRandomDitherType()
    local randomIndex = math.random(#ditherTypes)
    return ditherTypes[randomIndex]
end

function getRandomEvent(probability)
    local result = math.random(probability)
    return result == 1
end

SCREEN_WIDTH = 400
SCREEN_HEIGH = 280