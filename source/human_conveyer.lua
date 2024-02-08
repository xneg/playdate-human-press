local pd <const> = playdate
local gfx <const> = pd.graphics

import "human"
import "human_with_helmet"
import "utils"

class('HumanConveyer').extends()

function HumanConveyer:init()
    math.randomseed(pd.getSecondsSinceEpoch())
    self:createTimer()
end

function HumanConveyer:createTimer()
    local spawnTime = math.random(300, 1000)
    spawnTimer = pd.timer.performAfterDelay(spawnTime, function ()
        self:createTimer()
        self:addHuman()
    end)
end

function HumanConveyer:addHuman()
    if getRandomEvent(5) then
        HumanWithHelmet()
    else
        Human()
    end
end