dofile("pc-sets.lua")

function member(arr, x)
    for _, v in pairs(arr) do
        if v == x then 
	return true end
    end
    return false
end

function rm_reps(arr)
    local lenx = #arr
    if(lenx < 2) then 
	return arr
    else
        local t = {}
        for i = 1,lenx do
            local midix = arr[i]
            if(midix and midix ~= arr[i+1])
                then
                table.insert(t,midix)
            end	
        end
        return t
    end
end
  
function list_min(arr)
   local minx = arr[1]
   for i = 2, #arr do
       if(arr[i] < minx) then minx = arr[i] end
   end
   return minx
end

function get_prime_set(chord,invers)
   local set0 = {}                           -- chord -> pc
   local setx  = {} 		             -- = set0 to reset
   local set1 = {} 		             -- set1 = normalform = set1 % 12
   local set2 = {} 		             -- set2 = primeform
   local posarr = {} 	                     -- collect result positions
   local diffx = {}
   local posaddx = 0
   local firstval

   for i = 1, #chord do
      set0[i] = math.floor(chord[i] % 12)    --quartertones -> rounded
   end

   table.sort(set0)
   set0 = rm_reps(set0)

    if invers then
        for i = 1, #set0 do
            set0[i] = (12 - set0[i]) % 12
        end
        table.sort(set0)
   end
 
   for i = 1, #set0 do
      posarr[i] = i
   end

    if(#set0 < 2) then
        table.insert(set2,0)
        return  set2
        else
        -- span test (last - first, penultimate position - first, before penultimate position - first,...)
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
                   if(diffx[i] == minx) then table.insert(posarr,i) end
                end
                for i = 1, #set0 do
                   setx[i] = set0[i]
                end
                posaddx = posaddx + 1
                if (#posarr == 1) then break end
            end
        end

        firstval = set0[posarr[1]]
        set1[1] = firstval

        for i = 2, #set0 do
          local k = ((i + posarr[1] - 2) % #set0) + 1
          local addx = 0
          if (set1[i-1] > set0[k]) then addx = 12 end
          set1[i] = set0[k] + addx
        end

        for i = 1, #set0 do
          local pcx = set1[i] - set1[1]
          table.insert(set2,pcx)
        end

        return set2
    end
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

function pc_info(chord,mode)
    mode = mode or "name"
    
    local modepos = 1
    local a = pc2string(get_prime_set(chord,false))
    local b = pc2string(get_prime_set(chord,true))
    local resx

    if(mode == "name") then modepos = 1
        elseif (mode == "prime") then modepos = 2
        elseif (mode == "vector") then modepos = 3
    end

    if(#a == 1) then
        resx = pc_data1[1][modepos]
    elseif (#a == 12) then
        resx = pc_data12[1][modepos]
    elseif (#a == 11) then
        resx = pc_data11[1][modepos]
    elseif (#a == 2) then
        for j = 1, #pc_data2 do
           if(pc_data2[j][2] == a or pc_data2[j][2] == b) then
                resx = pc_data2[j][modepos]
                break
           end 
        end   
    elseif (#a == 10) then
        for j = 1, #pc_data10 do
           if(pc_data10[j][2] == a or pc_data10[j][2] == b) then
                resx = pc_data10[j][modepos]
                break
           end 
        end  
    elseif (#a == 3) then
        for j = 1, #pc_data3 do
           if(pc_data3[j][2] == a or pc_data3[j][2] == b) then
                resx = pc_data3[j][modepos]
                break
           end 
        end  
    elseif (#a == 9) then
        for j = 1, #pc_data9 do
           if(pc_data9[j][2] == a or pc_data9[j][2] == b) then
                resx = pc_data9[j][modepos]
                break
           end 
        end  
    elseif (#a == 4) then
        for j = 1, #pc_data4 do
           if(pc_data4[j][2] == a or pc_data4[j][2] == b) then
                resx = pc_data4[j][modepos]
                break
           end 
        end  
    elseif (#a == 8) then
        for j = 1, #pc_data8 do
           if(pc_data8[j][2] == a or pc_data8[j][2] == b) then
                resx = pc_data8[j][modepos]
                break
           end 
        end  
    elseif (#a == 7) then
        for j = 1, #pc_data7 do
           if(pc_data7[j][2] == a or pc_data7[j][2] == b) then
                resx = pc_data7[j][modepos]
                break
           end 
        end 
    elseif (#a == 5) then
        for j = 1, #pc_data5 do
           if(pc_data5[j][2] == a or pc_data5[j][2] == b) then
                resx = pc_data5[j][modepos]
                break
           end 
        end   
    elseif (#a == 6) then
        for j = 1, #pc_data6 do
           if(pc_data6[j][2] == a or pc_data6[j][2] == b) then
                resx = pc_data6[j][modepos]
                break
           end 
        end
    end
    return resx
end

--test:
--local set = {64,65,69,72}
--print(pc_info(set,"name"))
--print(pc_info(set,"prime"))
--print(pc_info(set,"vector"))

