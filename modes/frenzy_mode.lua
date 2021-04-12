local level = require "modes.level";

local frenzyMode = {}

frenzyMode.load = function ()

    maxtime = 300;
    time = 0;
    score = 0;
    level.load({x = 500,y = 900, outputs = 2},{x = 500, y = 150, inputs = 1});
    
end

frenzyModeUpdate = function ()

    levelComplete = false;
    score = score + 1;

    local inputs = 1;
    local outputs = 2;
    local y = 150;

    if score > 10 then
        inputs = 2;
    end

    if score > 15 then
        outputs = 3
        y = -1000
    end

    if score > 20 then
        inputs = 3;
    end

    if score > 50 then
        outputs = 4;
    end

    if score > 60 then
        inputs = 4;
    end

    if score > 70 then
        inputs = 5;
    end

    if score > 100 then
        outputs = 5;
    end

    if score > 120 then
        inputs = 6;
    end

    if score > 130 then
        inputs = 7
    end

    if score > 140 then
        inputs = 8
    end

    if score > 150 then
        inputs = 9
    end

    if score > 160 then
        inputs = 10
    end

    level.load({x = 500,y = 900, outputs = outputs},{x = 500, y = y, inputs = inputs});
end

return frenzyMode;