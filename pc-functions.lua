local sets = require 'pc-sets'
local pc = {}

function member(arr, x)
    for i = 1,#arr do
        if arr[i] == x then return true end
    end
    return false
end

function list_min(arr)
   local minx = arr[1]
   for i = 2, #arr do
       if(arr[i] < minx) then minx = arr[i] end
   end
return minx
end

function rm_dups(arr)
    local hash = {}
    local t = {}
    for i = 1, #arr do
    	local v = arr[i]
        if (not hash[v]) then
        t[#t+1] = v
        hash[v] = true
        end
    end
    return t
end

function pc.get_normal_form(chord,invers)
   local set0 = {}                           -- chord -> pc
   local setx  = {}                          -- to reset
   local set1 = {}                           -- normalform
   local posarr = {}                         -- collect result positions
   local diffx = {}
   local posaddx = 0

   for i = 1, #chord do
      set0[i] = math.floor(chord[i] % 12)    --quartertones -> rounded
   end

   set0 = rm_dups(set0)

    if invers then
        for i = 1, #set0 do
            set0[i] = (12 - set0[i]) % 12
        end
   end
 
   table.sort(set0)
   
   for i = 1, #set0 do
      posarr[i] = i
   end

    if(#set0 < 2) then
        set2[1] = 0
        return  set2
        else
        --span test (last - first, penultima last - first, before penultima last - first)
        if (#posarr > 1) then
            while (#posarr > 1 and posaddx < (#set0 - 1) ) do
            	--reset setx
            	for i = 1, #set0 do
                	setx[i] = set0[i]
           	 	end
                for j = 1, #set0 do
                    local posstart = ((j -1) % #set0) + 1
                    local posend = ((j + #set0  - 2 - posaddx) % #set0) + 1
                    local posendbefore = ((j + #set0  - 3 - posaddx) % #set0) + 1
                    local a = setx[posstart]
                    local b = setx[posend]
                    local c = setx[posendbefore]
                    if(b<c) then b = b + 12; setx[posend] = b end
                    if member(posarr,j) then
                       diffx[j] =  b - a
                    end
                end

                local minx = list_min(diffx)
                posarr = {}

                for i = 1, #set0 do
                   if(diffx[i] == minx) then posarr[#posarr+1] = i end
                end
                for i = 1, #set0 do
                   setx[i] = set0[i]
                end
                posaddx = posaddx + 1
                if (#posarr == 1) then break end
            end
        end

        local posres = posarr[1]

        for i = 1, #set0 do
        local pos2 = ((i + posres - 2) % #set0) + 1
          set1[i] = set0[pos2] % 12
        end
        return set1
    end
end

function pc.normal2prime_form(normal_set)
   local t = {}
   local firstval = normal_set[1]
   for i = 1, #normal_set do
        t[i] = (normal_set[i] - firstval) % 12
   end
   return t
end

function pc2string(arr)
    local stringx  = ""
    for i = 1, #arr do
        local pcx = arr[i]
        if (pcx == 10) then pcx = "T"
        elseif (pcx == 11) then pcx = "E"
        end
        stringx = stringx .. pcx
    end
    return stringx
end

function pc.info(chord)
    local normal_a = pc.get_normal_form(chord,false)
    local normal_b = pc.get_normal_form(normal_a,true)
    local a = pc2string(pc.normal2prime_form(normal_a))
    local b = pc2string(pc.normal2prime_form(normal_b))
    local resx

    if(#a == 1) then
        resx = sets.card1[1]
    elseif (#a == 12) then
        resx = sets.card12[1]
    elseif (#a == 11) then
        resx = sets.card11[1]
    elseif (#a == 2) then
        for j = 1, #sets.card2 do
           if(sets.card2[j][2] == a or sets.card[j][2] == b) then
                resx = sets.card2[j]
                break
           end 
        end   
    elseif (#a == 10) then
        for j = 1, #sets.card10 do
           if(sets.card10[j][2] == a or sets.card10[j][2] == b) then
                resx = sets.card10[j]
                break
           end 
        end  
    elseif (#a == 3) then
        for j = 1, #sets.card3 do
           if(sets.card3[j][2] == a or sets.card3[j][2] == b) then
                resx = sets.card3[j]
                break
           end 
        end  
    elseif (#a == 9) then
        for j = 1, #sets.card9 do
           if(sets.card9[j][2] == a or sets.card9[j][2] == b) then
                resx = sets.card9[j]
                break
           end 
        end  
    elseif (#a == 4) then
        for j = 1, #sets.card4 do
           if(sets.card4[j][2] == a or sets.card4[j][2] == b) then
                resx = sets.card4[j]
                break
           end 
        end  
    elseif (#a == 8) then
        for j = 1, #sets.card8 do
           if(sets.card8[j][2] == a or sets.card8[j][2] == b) then
                resx = sets.card8[j]
                break
           end 
        end  
    elseif (#a == 7) then
        for j = 1, #sets.card7 do
           if(sets.card7[j][2] == a or sets.card7[j][2] == b) then
                resx = sets.card7[j]
                break
           end 
        end 
    elseif (#a == 5) then
        for j = 1, #sets.card5 do
           if(sets.card5[j][2] == a or sets.card5[j][2] == b) then
                resx = sets.card5[j]
                break
           end 
        end   
    elseif (#a == 6) then
        for j = 1, #sets.card6 do
           if(sets.card6[j][2] == a or sets.card6[j][2] == b) then
                resx = sets.card6[j]
                break
           end 
        end
    end
    return normal_a,resx[1],resx[2],resx[3]
end


return pc
