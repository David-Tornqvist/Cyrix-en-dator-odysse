local camera = require "screen_related.camera";
local gates = require "world_related.gates";
local menu = require "screen_related.menu";
local wires = require "world_related.wires";
local starting_block = require "world_related.starting_block";
local tools = require "world_related.tools";
local goalblock = require "world_related.goal_block";
local gameOver = require "modes.gameOver"

local level = {};

level.load = function (start,goal)
    
    love.math.setRandomSeed(os.time());
    levelComplete = false
  
    gates.load();
    starting_block.load();
    tools.load();
    goalblock.load();
    starting_block.create(start.x, start.y, start.outputs);
    iGoalblock.create(goal.x,goal.y, goal.inputs);
    iGoalblock.simulate();

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

        time = time + dt;

        if time > maxtime then
            gameOver.load();
        end

        gates.update();
    
        camera.update("pan");
    

        if levelComplete then
            frenzyMode_update();
        end
        
    end

    function love.keypressed(key)

        if (key == "escape") then loadMainMenu(); end
        if (key == "delete") then
            isDelete = not isDelete
        end
    
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
        tools.drawScore();
        tools.drawTime();
        menu.draw();


        
    
    end
end

return level;