#!/usr/bin/env lua

dofile("pc-functions.lua")

if(#arg > 0) then
    local set = arg
    print("chord: " .. table.concat(arg, " "))
    print("name: " .. pc_info(set,"name"))
    print("prime: " .. pc_info(set,"prime") .. " iv: " .. pc_info(set,"vector"))
end

--enter in terminal: lua pc-info.lua 60 64 55
