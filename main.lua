local camera = require "screen_related.camera";
local gates = require "world_related.gates";
local menu = require "screen_related.menu";
local wires = require "world_related.wires";
local starting_block = require "world_related.starting_block";
local tools = require "world_related.tools";
local goalblock = require "world_related.goal_block";
local MainMenu = require "modes.mainMenu";

love.load = function()

    
    if love.filesystem.getInfo("hScore") == nil then
        highscore = 0;
    else
        highscore = tonumber(love.filesystem.read("hScore"),10);    
    end
    
    camera.load();
    loadMainMenu();

    soundtack = love.audio.newSource("audio/FreedomCrags.mp3", "stream"); 
    soundtack:setLooping(true);
    soundtack:play();


end