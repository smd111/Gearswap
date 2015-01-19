
    full_debug = false
    debug_count = 1
    debug_type = {"Status_Change","Pet_Change","Filtered_Action","Pretarget","Precast","Buff_Change","Midcast","Pet_Midcast","Aftercast","Pet_Aftercast",
    "Indi_Change","Self_Command","All"}

function Debug_status_change(new,old)
    if full_debug then
        if debug_count == 1 or debug_count == 13 then
            add_to_chat(7,"status_change")
            add_to_chat(7,"Status New = "..tostring(new))
            add_to_chat(7,"Status Old = "..tostring(old))
        end
    end
end
function Debug_pet_change(pet,gain)
    if full_debug then
        if debug_count == 2 or debug_count == 13 then
            add_to_chat(7,"pet_change")
            add_to_chat(7,"Pet = "..tostring(pet)..", Gain = "..tostring(gain))
            add_to_chat(7,"Pet Element = "..tostring(pet.element))
        end
    end
end
function Debug_filtered_action(spell)
    if full_debug then
        if debug_count == 3 or debug_count == 13 then
            add_to_chat(7,"filtered_action")
            add_to_chat(7,"Spell Name = "..tostring(spell.english))
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
function Debug_pretarget(spell)
    if full_debug then
        if debug_count == 4 or debug_count == 13 then
            add_to_chat(7,"pretarget")
            add_to_chat(7,"Spell Name = "..tostring(spell.english))
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
function Debug_precast(spell)
    if full_debug then
        if debug_count == 5 or debug_count == 13 then
            add_to_chat(7,"precast")
            add_to_chat(7,"Spell Name = "..tostring(spell.english))
            add_to_chat(7,"Spell Type = "..tostring(spell.type))
            add_to_chat(7,"Spell Element = "..tostring(spell.element))
            add_to_chat(7,"Spell Target Type = "..tostring(spell.target.type))
            add_to_chat(7,"Day Element = "..tostring(world.day_element))
            add_to_chat(7,"Weather Element = "..tostring(world.weather_element))
            add_to_chat(7,"Moon Phase = "..tostring(world.moon))
            add_to_chat(7,"Zone Name = "..tostring(world.zone))
            add_to_chat(7,"spell.tp_cost = "..tostring(spell.tp_cost))
            add_to_chat(7,"Zone Name = "..tostring(world.zone))
        end
    end
end
function Debug_buff_change(name,gain)
    if full_debug then
        if debug_count == 6 or debug_count == 13 then
            add_to_chat(7,"buff_change")
            add_to_chat(7,"Buff = "..tostring(name)..', Gain = '..tostring(gain))
        end
    end
end
function Debug_midcast(spell)
    if full_debug then
        if debug_count == 7 or debug_count == 13 then
            add_to_chat(7,"midcast")
            add_to_chat(7,"Spell Name = "..tostring(spell.english))
            add_to_chat(7,"Spell Type = "..tostring(spell.type))
            add_to_chat(7,"Spell Element = "..tostring(spell.element))
            add_to_chat(7,"Spell Target Type = "..tostring(spell.target.type))
            add_to_chat(7,"Day Element = "..tostring(world.day_element))
            add_to_chat(7,"Weather Element = "..tostring(world.weather_element))
            add_to_chat(7,"Moon Phase = "..tostring(world.moon))
            add_to_chat(7,"Zone Name = "..tostring(world.zone))
        end
    end
    return
end
function Debug_pet_midcast(spell)
    if full_debug then
        if debug_count == 8 or debug_count == 13 then
            add_to_chat(7,"pet_midcast")
            add_to_chat(7,"Spell Name = "..tostring(spell.english))
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
function Debug_aftercast(spell)
    if full_debug then
        if debug_count == 9 or debug_count == 13 then
            add_to_chat(7,"aftercast")
            add_to_chat(7,"Spell Name = "..tostring(spell.english))
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
function Debug_pet_aftercast(spell)
    if full_debug then
        if debug_count == 10 or debug_count == 13 then
            add_to_chat(7,"pet_aftercast")
            add_to_chat(7,"Spell Name = "..tostring(spell.english))
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
function Debug_indi_change(indi_table,gain)
    if full_debug then
        if debug_count == 11 or debug_count == 13 then
            add_to_chat(7,"indi_change")
            add_to_chat(7,"Indi Element = "..tostring(indi_table.element))
            add_to_chat(7,"Indi Element_id = "..tostring(indi_table.element_id))
            add_to_chat(7,"Indi Target = "..tostring(indi_table.target))
            add_to_chat(7,"Indi Size = "..tostring(indi_table.size))
            add_to_chat(7,"Indi Gain = "..tostring(gain))
        end
    end
end
function Debug_self_command(command)
    if command == 'tDebug' then
        full_debug = not full_debug
        send_command('clear log')
        send_command('gs debug_mode;wait 0.3;gs show_swaps')
        add_to_chat(7,'Debug Mode = ' .. (full_debug and 'ON' or 'OFF'))
    end
    if command == 'cDebugtype' then
        debug_count = (debug_count % #debug_type) + 1
        add_to_chat(7,'Debug Mode Type = ' .. tostring(debug_type[debug_count]))
    end
    if full_debug then
        if debug_count == 12 or debug_count == 13 then
            local commandArgs = command
            if type(commandArgs) == 'string' then
                commandArgs = T(commandArgs:split(' '))
            end
            if commandArgs[2] then
                for i, v in ipairs(commandArgs) do
                    add_to_chat(7,"commandArgs["..i.."] = "..tostring(v))
                end
            end
            add_to_chat(7,"Full Command Recived= "..tostring(command))
        end
    end
    if command:lower():startswith('set ') or command:lower():startswith('s ') then
        local commandArgs = command
        if type(commandArgs) == 'string' then
            commandArgs = T(commandArgs:split(' '))
        end
        if commandArgs[2]:lower() == 'debug' then
            local corrections_for_set_debug = {['status_change']='status_change',['sc']='status_change',['pet_change']='pet_change',['pc']='pet_change',
            ['filtered_action']='filtered_action',['fa']='filtered_action',['pretarget']='pretarget',['pret']='pretarget',['precast']='precast',['prec']='precast',
            ['buff_change']='buff_change',['bc']='buff_change',['midcast']='midcast',['mc']='midcast',['pet_midcast']='pet_midcast',['pmc']='pet_midcast',
            ['aftercast']='aftercast',['ac']='aftercast',['pet_aftercast']='pet_aftercast',['pac']='pet_aftercast',['indi_change']='indi_change',['ic']='indi_change',
            ['self_command']='self_command',['command']='self_command',['scom']='self_command',['all']='all',}
            for i, v in ipairs(debug_type) do
                if corrections_for_set_debug[string.lower(commandArgs[3])] == v:lower() then
                    commandArgs[3] = i
                end
            end
            debug_count = tonumber(commandArgs[3])
        end
        if updatedisplay then
            updatedisplay()
        end
    end
end