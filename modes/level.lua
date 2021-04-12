local camera = require "screen_related.camera";
local gates = require "world_related.gates";
local menu = require "screen_related.menu";
local wires = require "world_related.wires";
local startingBlock = require "world_related.starting_block";
local tools = require "world_related.tools";
local goalBlock = require "world_related.goal_block";
local gameOver = require "modes.game_over"

local level = {};

level.load = function (start,goal)
    
    love.math.setRandomSeed(os.time());
    levelComplete = false
  
    gates.load();
    startingBlock.load();
    tools.load();
    goalBlock.load();
    startingBlock.create(start.x, start.y, start.outputs);
    iGoalBlock.create(goal.x,goal.y, goal.inputs);
    iGoalBlock.simulate();

    function love.mousepressed(mouseX, mouseY, button)

        menu.click(mouseX, mouseY, button);

        portUpdate = false;
    
        startingBlock.click(mouseY, mouseY, button);
        iGoalBlock.click(button);
    
        gates.click(mouseX, mouseY, button);
        wires.connect(); 
    
        if(portUpdate == false) then
            gates.IOrelease();
        end
    
        camera.update("mPush", button);
    
        gates.simulate();
        iGoalBlock.simulate();

    end

    function love.mousereleased(x, y, button)

        gates.release(button);
    
        camera.update("mRel", button);
        
    end

    
    function love.wheelmoved(x, y)
 
        camera.update("scrl", y);

    end

    love.mousemoved = function (x,y)

        x = x / screenScale;
        y = y / screenScale;

        for i = 1, #arrGates do
            if( x > (arrGates[i].x + arrGates[i].input.a.coords.x - 10) and x < (arrGates[i].x + arrGates[i].input.a.coords.x + 10) 
                and y > (arrGates[i].y + arrGates[i].input.a.coords.y - 10) and y < (arrGates[i].y + arrGates[i].input.a.coords.y + 10)) then
                    arrGates[i].input.a.hover = true;
            else
                arrGates[i].input.a.hover = false;         
            end

            if arrGates[i].input.b.coords.x ~= nil then
                if( x > (arrGates[i].x + arrGates[i].input.b.coords.x - 10) and x < (arrGates[i].x + arrGates[i].input.b.coords.x + 10) 
                    and y > (arrGates[i].y + arrGates[i].input.b.coords.y - 10) and y < (arrGates[i].y + arrGates[i].input.b.coords.y + 10)) then
                        arrGates[i].input.b.hover = true;
                else
                    arrGates[i].input.b.hover = false;        
                end
            end
            
            if( x > (arrGates[i].x + arrGates[i].output.q.coords.x - 10) and x < (arrGates[i].x + arrGates[i].output.q.coords.x + 10) 
                and y > (arrGates[i].y + arrGates[i].output.q.coords.y - 10) and y < (arrGates[i].y + arrGates[i].output.q.coords.y + 10)) then
                    arrGates[i].output.q.hover = true;
            else
                arrGates[i].output.q.hover = false
            end

        end

        for b = 1, #arrStartBlock[1].output do
            if( x > (arrStartBlock[1].coords.x + arrStartBlock[1].output[b].coords.x - 10) and 
                x < (arrStartBlock[1].coords.x + arrStartBlock[1].output[b].coords.x + 10) and 
                y > (arrStartBlock[1].coords.y + arrStartBlock[1].output[b].coords.y - 10) and 
                y < (arrStartBlock[1].coords.y + arrStartBlock[1].output[b].coords.y + 10)) then 
            
                    arrStartBlock[1].output[b].hover = true
            
            else
                arrStartBlock[1].output[b].hover = false
            end
        end

        for b = 1, #iGoalBlock.entity.inputs do
            if( x > (iGoalBlock.entity.coords.x + iGoalBlock.entity.inputs[b].coords.x - 10) and 
                x < (iGoalBlock.entity.coords.x + iGoalBlock.entity.inputs[b].coords.x + 10) and 
                y > (iGoalBlock.entity.coords.y + iGoalBlock.entity.inputs[b].coords.y - 10) and 
                y < (iGoalBlock.entity.coords.y + iGoalBlock.entity.inputs[b].coords.y + 10)) then
        
                iGoalBlock.entity.inputs[b].hover = true;
            else
                iGoalBlock.entity.inputs[b].hover = false
            end    
        end
    end

    love.update = function(dt)

        time = time + dt;

        if time > maxtime then
            gameOver.load();
        end

        gates.update();
    
        camera.update("pan");
    

        if levelComplete then
            frenzyModeUpdate();
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
    
        startingBlock.draw();
        iGoalBlock.draw();
        gates.draw();
        wires.draw();
    
        love.graphics.pop();
    
        iGoalBlock.truthTableDraw();
        tools.drawScore();
        tools.drawTime();
        menu.draw();

    end
end

return level;