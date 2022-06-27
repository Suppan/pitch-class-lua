#!/usr/bin/env lua

dofile("pc-functions.lua")

if(#arg > 0) then
    local chord = arg
    local name,prime, vector, normal = pc_info(chord)
    print("midi: " .. table.concat(chord," "))
    print("normal: " .. table.concat(normal," "))
    print("prime: " .. prime)
    print("name: " .. name)
    print("vector: " .. vector)
end

--enter in terminal: lua pc-info.lua 60 64 55
