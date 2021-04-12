local tools = {};

tools.load = function ()
    isDelete = false;
end

tools.activate = function (tool)
    if(tool == "delete")then
        isDelete = not isDelete;
    end
end

--handles every type of gate diffrently but generally deletes all wires connected and then removes the gate from the gate array
tools.delete = function (gateName,port)

    local gate = arrGates[getindex(gateName)];

    if gateName < firstStartBlockName then
        if (port == "q") then

            if (gate.output.q.connect.name ~= nil) then

                if (gate.output.q.connect.name < goalblockFirstStart) then

                    if(gate.output.q.connect.port == "a" and arrGates[getindex(gate.output.q.connect.name)] ~= nil) then
                        arrGates[getindex(gate.output.q.connect.name)].input.a.connect = nil;
                        arrGates[getindex(gate.output.q.connect.name)].input.a.status = false;
                    end
            
                    if(gate.output.q.connect.port == "b" and arrGates[getindex(gate.output.q.connect.name)] ~= nil) then
                        arrGates[getindex(gate.output.q.connect.name)].input.b.connect = nil;
                        arrGates[getindex(gate.output.q.connect.name)].input.b.status = false;
                    end
                
                else    
                    iGoalBlock.entity.inputs[gate.output.q.connect.port].connect = nil;
                    iGoalBlock.entity.inputs[gate.output.q.connect.port].status = false;
                end
                
                arrGates[getindex(gateName)].output.q.connect.name = nil;
                arrGates[getindex(gateName)].output.q.connect.port = nil; 
            end
        end
    else

        if(port ~= nil) then
            if arrStartBlock[starting_block_getIndex(gateName)].output[port].connect.name ~= nil then

                if arrStartBlock[starting_block_getIndex(gateName)].output[port].connect.name < goalblockFirstStart then

                    if( arrStartBlock[starting_block_getIndex(gateName)].output[port].connect.port == "a" and 
                        arrGates[getindex(arrStartBlock[starting_block_getIndex(gateName)].output[port].connect.name)] ~= nil) then
        
                            arrGates[getindex(arrStartBlock[starting_block_getIndex(gateName)].output[port].connect.name)].input.a.connect = nil;
                            arrGates[getindex(arrStartBlock[starting_block_getIndex(gateName)].output[port].connect.name)].input.a.status = false;
        
                    end
        
                    if( arrStartBlock[starting_block_getIndex(gateName)].output[port].connect.port == "b" and 
                        arrGates[getindex(arrStartBlock[starting_block_getIndex(gateName)].output[port].connect.name)] ~= nil) then
        
                            arrGates[getindex(arrStartBlock[starting_block_getIndex(gateName)].output[port].connect.name)].input.b.connect = nil;
                            arrGates[getindex(arrStartBlock[starting_block_getIndex(gateName)].output[port].connect.name)].input.b.status = false;
        
                    end
                else

                    local index = iGoalBlock.findPortThatConnect(firstStartBlockName + port);

                    iGoalBlock.entity.inputs[index].connect = nil;
                    iGoalBlock.entity.inputs[index].status = false;

                end     
            end
        
            arrStartBlock[starting_block_getIndex(gateName)].output[port].connect.name = nil;
            arrStartBlock[starting_block_getIndex(gateName)].output[port].connect.port = nil;
        
        end
    end


    if (port == "a" and (gate.input.a.connect ~= nil)) then
            
        if (gate.input.a.connect - firstStartBlockName) < 0 then
            if(arrGates[getindex(gate.input.a.connect)].type ~= "node") then
                arrGates[getindex(gate.input.a.connect)].output.q.connect.name = nil;
                arrGates[getindex(gate.input.a.connect)].output.q.connect.port = nil;
            end
        else
            arrStartBlock[starting_block_getIndex(gateName)].output[gate.input.a.connect - firstStartBlockName].connect.name = nil;
            arrStartBlock[starting_block_getIndex(gateName)].output[gate.input.a.connect - firstStartBlockName].connect.port = nil;
        end
        
        arrGates[getindex(gateName)].input.a.connect = nil;
    
    elseif (port == "b" and (gate.input.b.connect ~= nil)) then
        
        if (gate.input.b.connect - firstStartBlockName) < 0 then
            if(arrGates[getindex(gate.input.b.connect)].type ~= "node") then

                arrGates[getindex(gate.input.b.connect)].output.q.connect.name = nil;
                arrGates[getindex(gate.input.b.connect)].output.q.connect.port = nil;

            end
        else

            arrStartBlock[starting_block_getIndex(gateName)].output[gate.input.b.connect - firstStartBlockName].connect.name = nil;
            arrStartBlock[starting_block_getIndex(gateName)].output[gate.input.b.connect - firstStartBlockName].connect.port = nil;

        end    

        arrGates[getindex(gateName)].input.b.connect = nil;
            
    end
    
    if ((gateName < firstStartBlockName) and (gateName >= goalblockFirstStart)) then

        if (iGoalBlock.entity.inputs[port].connect ~= nil) then
           
            if (iGoalBlock.entity.inputs[port].connect - firstStartBlockName) < 0 then
                if(arrGates[getindex(iGoalBlock.entity.inputs[port].connect)].type ~= "node") then

                    arrGates[getindex(iGoalBlock.entity.inputs[port].connect)].output.q.connect.name = nil;
                    arrGates[getindex(iGoalBlock.entity.inputs[port].connect)].output.q.connect.port = nil;

                end
            else

                arrStartBlock[starting_block_getIndex(gateName)].output[iGoalBlock.entity.inputs[port].connect - firstStartBlockName].connect.name = nil;
                arrStartBlock[starting_block_getIndex(gateName)].output[iGoalBlock.entity.inputs[port].connect - firstStartBlockName].connect.port = nil;

            end
         
            iGoalBlock.entity.inputs[port].connect = nil;
            iGoalBlock.entity.inputs[port].status = false;
            
        end
    end
end


--finds the correct node output wire to delete
tools.deleteNodeWire = function (nodeName,portNum)

    if arrGates[getindex(nodeName)].output.q.connect[portNum].name ~= nil then

        if arrGates[getindex(nodeName)].output.q.connect[portNum].name < goalblockFirstStart then

            if(arrGates[getindex(nodeName)].output.q.connect[portNum].port == "a") then

                arrGates[getindex(arrGates[getindex(nodeName)].output.q.connect[portNum].name)].input.a.connect = nil;
                arrGates[getindex(arrGates[getindex(nodeName)].output.q.connect[portNum].name)].input.a.status = false;

            end    
        
            if (arrGates[getindex(nodeName)].output.q.connect[portNum].port == "b") then

                arrGates[getindex(arrGates[getindex(nodeName)].output.q.connect[portNum].name)].input.b.connect = nil;
                arrGates[getindex(arrGates[getindex(nodeName)].output.q.connect[portNum].name)].input.b.status = false;

            end
        else

            iGoalBlock.entity.inputs[portNum].connect = nil;
            iGoalBlock.entity.inputs[portNum].status = false;

        end
       
        arrGates[getindex(nodeName)].output.q.connect[portNum].port = nil;
        arrGates[getindex(nodeName)].output.q.connect[portNum].name = nil;
    
    end
end

tools.deleteNodeOutputs = function (gateName)
    
    local node = arrGates[getindex(gateName)];

    for i = 1, #node.output.q.connect do

        tools.deleteNodeWire(gateName,i);
        
    end

end 

tools.findNodeOutputIndex = function (nodeName,gateName,port)

    for i = 1, #arrGates[getindex(nodeName)].output.q.connect do

        if gateName < goalblockFirstStart then

            if(arrGates[getindex(nodeName)].output.q.connect[i].name == gateName) and (arrGates[getindex(nodeName)].output.q.connect[i].port == port)  then
                return i;
            end

        else

            if ((arrGates[getindex(nodeName)].output.q.connect[i].name == gateName) and (arrGates[getindex(nodeName)].output.q.connect[i].port == port)) then
                return i;
            end   

        end
    end
end

tools.deleteGate = function (gateName)

    if arrGates[getindex(gateName)].input.a.connect ~= nil then

        if (arrGates[getindex(gateName)].input.a.connect - firstStartBlockName) < 0 then

            if arrGates[getindex(arrGates[getindex(gateName)].input.a.connect)].type ~= "node" then
                tools.delete(gateName,"a");
            else
                tools.deleteNodeWire(arrGates[getindex(gateName)].input.a.connect, tools.findNodeOutputIndex(arrGates[getindex(gateName)].input.a.connect, gateName,"a"));        
            end

        else
            tools.delete(gateName,"a");    
        end
    end

    if arrGates[getindex(gateName)].input.b.connect ~= nil then

        if (arrGates[getindex(gateName)].input.b.connect - firstStartBlockName) < 0 then

            if arrGates[getindex(arrGates[getindex(gateName)].input.b.connect)].type ~= "node" then
                tools.delete(gateName,"b");
            else
                tools.deleteNodeWire(arrGates[getindex(gateName)].input.b.connect, tools.findNodeOutputIndex(arrGates[getindex(gateName)].input.b.connect, gateName,"b"));        
            end 

        else
            tools.delete(gateName,"b");
        end
    end

    if arrGates[getindex(gateName)].type ~= "node" then
        tools.delete(gateName,"q");    
    else
        tools.deleteNodeOutputs(gateName);
    end

    table.remove(arrGates,getindex(gateName));
    
end

tools.pow = function (base,exponential)
    
    local a = base;
    
    for i = 1, (exponential - 1) do
        a = a*base
    end

    if exponential == 0 then
        a = 1;
    end

    return a;

end

tools.binaryToDecimal = function (arr)

    local a = 0;

    if arr[1] == 1 or arr[1] == 0 then

        for i = 1, #arr do

            if arr[i] == 1 then
                a = a + tools.pow(2,(i-1));
            end

        end

    else

        for i = 1, #arr do

            if arr[i] then
                a = a + tools.pow(2,(i-1));
            end

        end  

    end
    
    return a;
    
end

tools.decimalToBinary = function (dec,nDig)

    local exp = 0;
    local bin = {};

    for i = 1, nDig do
        bin[i] = 0;
    end

    while tools.pow(2,exp) < dec do
        exp = exp + 1;
    end

    for i = exp, 0, -1 do
        if ((dec / tools.pow(2,i)) >= 1) then
            bin[i + 1] = 1;
            dec = dec - tools.pow(2,i)
        end
    end

    return(bin);
    
end

tools.findBinaryDigit = function (dec,dig)

    local bin = tools.decimalToBinary(dec,dig);

    return bin[dig];
    
end

tools.numTolet = function (num)

    local alphabet = {"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"};

    return alphabet[num];
    
end

tools.drawScore = function ()

    love.graphics.print("Score: " .. score, 0, 300);

end

tools.drawTime = function ()

    love.graphics.print("Tid: " .. maxtime - math.floor(time), 0, 320);

end


return tools