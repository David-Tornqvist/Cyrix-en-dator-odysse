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

    love.mousemoved = function (x,y)


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

        for b = 1, #iGoalblock.entity.inputs do
            if( x > (iGoalblock.entity.coords.x + iGoalblock.entity.inputs[b].coords.x - 10) and 
                x < (iGoalblock.entity.coords.x + iGoalblock.entity.inputs[b].coords.x + 10) and 
                y > (iGoalblock.entity.coords.y + iGoalblock.entity.inputs[b].coords.y - 10) and 
                y < (iGoalblock.entity.coords.y + iGoalblock.entity.inputs[b].coords.y + 10)) then
        
                iGoalblock.entity.inputs[b].hover = true;
            else
                iGoalblock.entity.inputs[b].hover = false
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