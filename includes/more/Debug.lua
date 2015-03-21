
full_debug = false
debug_count = 1
debug_type = {"Status_Change","Pet_Change","Filtered_Action","Pretarget","Precast","Buff_Change","Midcast","Pet_Midcast","Aftercast","Pet_Aftercast",
    "Indi_Change","Pet_Status_Change","Sub_Job_Change","Self_Command","All"}

function Debug_code(status,set_gear,event_type,spell)
    if full_debug then
        if debug_type[debug_count]:lower() == event_type or debug_type[debug_count] == "All" then
            add_to_chat(7,"Event = "..event_type)
            for i,v in pairs(spell) do
                if type(spell[i]) == "table" and not S{"levels","flags"}:contains(i) then
                    for i2,v2 in pairs(spell[i]) do
                        add_to_chat(7,"spell."..i.."."..i2.." = "..tostring(v2))
                    end
                else
                    add_to_chat(7,"spell."..i.." = "..tostring(v))
                end
            end
        end
    end
end
Debug_filtered_action = Debug_code
Debug_pretarget = Debug_code
Debug_precast = Debug_code
Debug_midcast = Debug_code
Debug_pet_midcast = Debug_code
Debug_aftercast = Debug_code
Debug_pet_aftercast = Debug_code
function Debug_status_change(status,set_gear,event_type,new,old)
    if full_debug then
        if debug_type[debug_count]:lower() == event_type or debug_type[debug_count] == "All" then
            add_to_chat(7,"Event = "..event_type)
            add_to_chat(7,"Status New = "..tostring(new))
            add_to_chat(7,"Status Old = "..tostring(old))
        end
    end
end
Debug_pet_status_change = Debug_status_change
function Debug_sub_job_change(status,set_gear,event_type,pet,gain)
    if full_debug then
        if debug_type[debug_count]:lower() == event_type or debug_type[debug_count] == "All" then
            add_to_chat(7,"Event = "..event_type)
            add_to_chat(7,"New Sub Job= "..tostring(new))
            add_to_chat(7,"Old Sub Job = "..tostring(old))
        end
    end
end
function Debug_pet_change(status,set_gear,event_type,pet,gain)
    if full_debug then
        if debug_type[debug_count]:lower() == event_type or debug_type[debug_count] == "All" then
            add_to_chat(7,"Event = "..event_type)
            for i,v in pairs(pet) do
                if type(pet[i]) == "table" then
                    for i2,v2 in pairs(pet[i]) do
                        add_to_chat(7,"pet."..i.."."..i2.." = "..v2)
                    end
                else
                    add_to_chat(7,"pet."..i.." = "..v)
                end
            end
            add_to_chat(7,"gain = "..tostring(gain))
        end
    end
end
function Debug_buff_change(status,set_gear,event_type,name,gain,buff_table)
    if full_debug then
        if debug_type[debug_count]:lower() == event_type or debug_type[debug_count] == "All" then
            add_to_chat(7,"Event = "..event_type)
            add_to_chat(7,"buff = "..tostring(name)..', gain = '..tostring(gain))
            for i,v in pairs(buff_table) do
                add_to_chat(7,"buff_table."..i.." = "..v)
            end
        end
    end
end
function Debug_indi_change(status,set_gear,event_type,indi_table,gain)
    if full_debug then
        if debug_type[debug_count]:lower() == event_type or debug_type[debug_count] == "All" then
            add_to_chat(7,"Event = "..event_type)
            for i,v in pairs(indi_table) do
                add_to_chat(7,"indi_table."..i.." = "..v)
            end
            add_to_chat(7,"gain = "..tostring(gain))
        end
    end
end
function Debug_self_command(status,set_gear,event_type,command)
    if full_debug then
        if debug_type[debug_count]:lower() == event_type or debug_type[debug_count] == "All" then
            add_to_chat(7,"Event = "..event_type)
            if type(command) == "table" then
                for i,v in pairs(command) do
                    add_to_chat(7,'Command['..i..'] = '..v)
                end
            else
                add_to_chat(7,'Command = '..command)
            end
        end
    end
    if type(command) == "table" then
        if command[1]:lower() == 'set' or command[1]:lower() == 's' then
            if command[2]:lower() == 'debug' then
                local corrections_for_set_debug = {['status_change']='status_change',['sc']='status_change',['pet_change']='pet_change',['pc']='pet_change',
                ['filtered_action']='filtered_action',['fa']='filtered_action',['pretarget']='pretarget',['pret']='pretarget',['precast']='precast',['prec']='precast',
                ['buff_change']='buff_change',['bc']='buff_change',['midcast']='midcast',['mc']='midcast',['pet_midcast']='pet_midcast',['pmc']='pet_midcast',
                ['aftercast']='aftercast',['ac']='aftercast',['pet_aftercast']='pet_aftercast',['pac']='pet_aftercast',['indi_change']='indi_change',['ic']='indi_change',
                ['self_command']='self_command',['command']='self_command',['scom']='self_command',['all']='all',}
                for i, v in ipairs(debug_type) do
                    if corrections_for_set_debug[string.lower(command[3])] == v:lower() then
                        debug_count = i
                    end
                end 
            end
        end
        if command[1]:lower() == 'show' and (command[2]:lower() == 'variable' or command[2]:lower() == 'var') then
            if _G[command[3]:lower()] then
                for i,v in pairs(_G[command[3]:lower()]) do
                    if type(_G[command[3]:lower()][i]) == "table" and not S{"job_points","merits","case","wardrobe","sack","satchel","inventory"}:contains(i) then
                        for i2,v2 in pairs(_G[command[3]:lower()][i]) do
                            if type(_G[command[3]:lower()][i][i2]) == "table" then
                                for i3,v3 in pairs(_G[command[3]:lower()][i][i2]) do
                                    add_to_chat(7,command[3]:lower().."."..i.."."..i2.."."..i3.." = "..tostring(v3))
                                end
                            else
                                add_to_chat(7,command[3]:lower().."."..i.."."..i2.." = "..tostring(v2))
                            end
                        end
                    else
                        add_to_chat(7,command[3]:lower().."."..i.." = "..tostring(v))
                    end
                end
            end
        end
    elseif command == 'tDebug' then
        full_debug = not full_debug
        send_command('clear log')
        send_command('gs debug_mode;wait 0.3;gs show_swaps')
        add_to_chat(7,'Debug Mode = ' .. (full_debug and 'ON' or 'OFF'))
    elseif command == 'cDebugtype' then
        debug_count = (debug_count % #debug_type) + 1
        add_to_chat(7,'Debug Mode Type = ' .. tostring(debug_type[debug_count]))
    end
    if updatedisplay then
        updatedisplay()
    end
end