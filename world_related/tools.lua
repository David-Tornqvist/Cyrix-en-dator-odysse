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

    --if gate.type ~= "node" then

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
    --end



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
end

return tools