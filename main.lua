local camera = require "screen_related.camera";
local main_menu = require "modes.main_menu";

love.load = function()    

    if love.filesystem.getInfo("hScore") == nil then
        highScore = 0;
    else
        highScore = tonumber(love.filesystem.read("hScore"),10);    
    end
    
    camera.load();
    music = true;

    loadMainMenu();

    soundtack = love.audio.newSource("audio/freedomCrags.mp3", "stream"); 
    soundtack:setLooping(true);
    soundtack:play();

end