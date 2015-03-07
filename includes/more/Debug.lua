
    full_debug = false
    debug_count = 1
    debug_type = {"Status_Change","Pet_Change","Filtered_Action","Pretarget","Precast","Buff_Change","Midcast","Pet_Midcast","Aftercast","Pet_Aftercast",
    "Indi_Change","Pet_Status_Change","Sub_Job_Change","Self_Command","All"}

function Debug_code(spell,...)
    local a,b,c = unpack{...}
    if full_debug then
        if debug_type[debug_count]:lower() == c or debug_type[debug_count] == "All" then
            add_to_chat(7,"Event = "..c)
            add_to_chat(7,"Spell Name = "..tostring(spell.name))
            add_to_chat(7,"Spell Type = "..tostring(spell.type))
            add_to_chat(7,"Spell Element = "..tostring(spell.element))
            add_to_chat(7,"Spell Target Type = "..tostring(spell.target.type))
            add_to_chat(7,"Day Element = "..tostring(world.day_element))
            add_to_chat(7,"Weather Element = "..tostring(world.weather_element))
            add_to_chat(7,"Moon Phase = "..tostring(world.moon))
            add_to_chat(7,"Zone Name = "..tostring(world.zone))
        end
    end
end
function Debug_status_change(new,old,...)
    local a,b,c = unpack{...}
    if full_debug then
        if debug_type[debug_count]:lower() == c or debug_type[debug_count] == "All" then
            add_to_chat(7,"Event = "..c)
            add_to_chat(7,"Status New = "..tostring(new))
            add_to_chat(7,"Status Old = "..tostring(old))
        end
    end
end
function Debug_sub_job_change(new,old,...)
    local a,b,c = unpack{...}
    if full_debug then
        if debug_type[debug_count]:lower() == c or debug_type[debug_count] == "All" then
            add_to_chat(7,"Event = "..c)
            add_to_chat(7,"New Sub Job= "..tostring(new))
            add_to_chat(7,"Old Sub Job = "..tostring(old))
        end
    end
end
function Debug_pet_change(pet,gain,...)
    local a,b,c = unpack{...}
    if full_debug then
        if debug_type[debug_count]:lower() == c or debug_type[debug_count] == "All" then
            add_to_chat(7,"Event = "..c)
            add_to_chat(7,"Pet = "..tostring(pet)..", Gain = "..tostring(gain))
            add_to_chat(7,"Pet Element = "..tostring(pet.element))
        end
    end
end
function Debug_buff_change(name,gain,buff_table,...)
    local a,b,c = unpack{...}
    if full_debug then
        if debug_type[debug_count]:lower() == c or debug_type[debug_count] == "All" then
            add_to_chat(7,"Event = "..c)
            add_to_chat(7,"Buff = "..tostring(name)..', Gain = '..tostring(gain))
        end
    end
end
function Debug_indi_change(indi_table,gain,...)
    local a,b,c = unpack{...}
    if full_debug then
        if debug_type[debug_count]:lower() == c or debug_type[debug_count] == "All" then
            add_to_chat(7,"Event = "..c)
            add_to_chat(7,"Indi Element = "..tostring(indi_table.element))
            add_to_chat(7,"Indi Element_id = "..tostring(indi_table.element_id))
            add_to_chat(7,"Indi Target = "..tostring(indi_table.target))
            add_to_chat(7,"Indi Size = "..tostring(indi_table.size))
            add_to_chat(7,"Indi Gain = "..tostring(gain))
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
Debug_pet_status_change = Debug_status_change
function Debug_self_command(command,event_type)
    print(command[1],command[2])
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
    elseif command == 'tDebug' then
        full_debug = not full_debug
        send_command('clear log')
        send_command('gs debug_mode;wait 0.3;gs show_swaps')
        add_to_chat(7,'Debug Mode = ' .. (full_debug and 'ON' or 'OFF'))
    elseif command == 'cDebugtype' then
        debug_count = (debug_count % #debug_type) + 1
        add_to_chat(7,'Debug Mode Type = ' .. tostring(debug_type[debug_count]))
    end
    if full_debug then
        if debug_type[debug_count]:lower() == c or debug_type[debug_count] == "All" then
            add_to_chat(7,"Event = "..c)
            if type(command) == "table" then
                for i,v in ipairs(command) do
                    add_to_chat(7,'Command['..i..'] = '..v)
                end
            else
                add_to_chat(7,'Command = '..command)
            end
        end
    end
    if updatedisplay then
        updatedisplay()
    end
end