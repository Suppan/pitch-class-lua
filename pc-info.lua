#!/usr/bin/env lua
local pc = require 'pc-functions'

if(#arg > 0) then
    local chord = arg
    local normal,name,prime,vector = pc.info(chord)
    print("midi: " .. table.concat(chord," "))
    print("normal: " .. table.concat(normal," "))
    print("prime: " .. prime)
    print("name: " .. name)
    print("vector: " .. vector)
end

--enter in terminal: lua pc-info.lua 60 64 55
