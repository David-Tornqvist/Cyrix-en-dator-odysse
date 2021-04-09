local camera = require "screen_related.camera";
local gates = require "world_related.gates";
local menu = require "screen_related.menu";
local wires = require "world_related.wires";
local starting_block = require "world_related.starting_block";
local tools = require "world_related.tools";
local goalblock = require "world_related.goal_block"


local loadLevel = function ()

    function love.mousepressed(mousex, mousey, button)

        portUpdate = false;
    
        starting_block.click(mousey, mousey, button);
        iGoalblock.click(button);
    
        menu.click(mousex, mousey, button);
        gates.click(mousex, mousey, button);
        wires.connect(); 
    
        if(portUpdate == false) then
            gates.IOrelease();
        end
    
        camera.update("mPush", button);
    
        gates.simulate();
        iGoalblock.simulate();
    end

    function love.mousereleased(x, y, button)

        gates.release(button);
    
        camera.update("mRel", button);
        
    end

    
    function love.wheelmoved(x, y)
 
    camera.update("scrl", y);

    end

    love.update = function(dt)

        gates.update();
    
        camera.update("pan");
    
        print(levelComplete);
        
    end

    love.draw = function()

        love.graphics.scale(screenScale, screenScale);
    
        love.graphics.push();
    
        love.graphics.scale(zoom, zoom);
        love.graphics.translate(translate.x, translate.y);
    
        starting_block.draw();
        iGoalblock.draw();
        gates.draw();
        wires.draw();
    
        love.graphics.pop();
    
        iGoalblock.truthTableDraw();
        menu.draw();
        
    
    end

    love.math.setRandomSeed(os.time());
    levelComplete = false
  
    gates.load();
    starting_block.load();
    tools.load();
    goalblock.load();
    starting_block.create(500, 950, 2);
    iGoalblock.create(500,-2000,1);
    iGoalblock.simulate();

end


love.load = function()

    camera.load();
    loadLevel();

end    

function love.keypressed(key)

    if (key == "escape") then love.event.quit(); end
    if (key == "a") then
        loadLevel();
    end

end