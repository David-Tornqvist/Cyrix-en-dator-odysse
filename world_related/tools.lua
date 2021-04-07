local tools = {};

tools.load = function ()
    isDelete = false;
end

tools.activate = function (tool)
    if(tool == "delete")then
        isDelete = not isDelete;
    end
end

tools.delete = function (gateName,port)

    local gate = arrGates[getindex(gateName)];


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
        

    

    if gateName < firstStartBlockName then
        if (port == "q") then

            if(gate.output.q.connect.port == "a" and arrGates[getindex(gate.output.q.connect.name)] ~= nil) then
                arrGates[getindex(gate.output.q.connect.name)].input.a.connect = nil;
                arrGates[getindex(gate.output.q.connect.name)].input.a.status = false;
            end
    
            if(gate.output.q.connect.port == "b" and arrGates[getindex(gate.output.q.connect.name)] ~= nil) then
                arrGates[getindex(gate.output.q.connect.name)].input.b.connect = nil;
                arrGates[getindex(gate.output.q.connect.name)].input.b.status = false;
            end
            
            arrGates[getindex(gateName)].output.q.connect.name = nil;
            arrGates[getindex(gateName)].output.q.connect.port = nil;
        end
    else
        
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

        

        arrStartBlock[starting_block_getIndex(gateName)].output[port].connect.name = nil;
        arrStartBlock[starting_block_getIndex(gateName)].output[port].connect.port = nil;
        
    end
end

tools.deleteNodeWire = function (nodeName,portNum)
    
    if(arrGates[getindex(nodeName)].output.q.connect[portNum].port == "a") then
        arrGates[getindex(arrGates[getindex(nodeName)].output.q.connect[portNum].name)].input.a.connect = nil;
        arrGates[getindex(arrGates[getindex(nodeName)].output.q.connect[portNum].name)].input.a.status = false;
    end    

    if (arrGates[getindex(nodeName)].output.q.connect[portNum].port == "b") then
        arrGates[getindex(arrGates[getindex(nodeName)].output.q.connect[portNum].name)].input.b.connect = nil;
        arrGates[getindex(arrGates[getindex(nodeName)].output.q.connect[portNum].name)].input.b.status = false;
    end
                
    
    arrGates[getindex(nodeName)].output.q.connect[portNum].port = nil;
    arrGates[getindex(nodeName)].output.q.connect[portNum].name = nil;

end

tools.deleteNodeOutputs = function (gateName)
    
    local node = arrGates[getindex(gateName)];

    for i = 1, #node.output.q.connect do

        tools.deleteNodeWire(gateName,i);
        
    end

end 

tools.findNodeOutputIndex = function (nodeName,gateName)
    for i = 1, #arrGates[getindex(nodeName)].output.q.connect do
        if(arrGates[getindex(nodeName)].output.q.connect[i].name == gateName) then
            return i;
        end
    end
end

tools.deleteGate = function (gateName)

    if arrGates[getindex(gateName)].input.a.connect ~= nil then
        if arrGates[getindex(arrGates[getindex(gateName)].input.a.connect)].type ~= "node" then
            tools.delete(gateName,"a");
        else
            tools.deleteNodeWire(arrGates[getindex(gateName)].input.a.connect, tools.findNodeOutputIndex(arrGates[getindex(gateName)].input.a.connect, gateName));        
        end
    end

    if arrGates[getindex(gateName)].input.b.connect ~= nil then
        if arrGates[getindex(arrGates[getindex(gateName)].input.b.connect)].type ~= "node" then
            tools.delete(gateName,"b");
        else
            tools.deleteNodeWire(arrGates[getindex(gateName)].input.b.connect, tools.findNodeOutputIndex(arrGates[getindex(gateName)].input.b.connect, gateName));        
        end
    end
    


    if arrGates[getindex(gateName)].type ~= "node" then
        tools.delete(gateName,"q");    
    else
        tools.deleteNodeOutputs(gateName);
    end
    

    table.remove(arrGates,getindex(gateName));
    
end



return tools