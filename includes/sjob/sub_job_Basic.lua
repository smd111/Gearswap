--any functions you do not need should be removed or will cause errors
function SJi_file_unload()
    ---------------------------------------
    --put your file_unload rules here
    ---------------------------------------
end
function SJi_status_change(new,old, status, set_gear)
    ----------------------------------------
    --equip example: equip_set(set_gear, sets.Engaged)
    ---------------------------------------
end
function SJi_pretarget(spell,status,set_gear)
    ---------------------------------------
    --put your pretarget rules here
    ---------------------------------------
    --equip example: equip_set(set_gear, sets.Engaged)
    ---------------------------------------
end
function SJi_precast(spell,status,set_gear)
    ---------------------------------------
    --put your precast rules here
    ---------------------------------------
    --equip example: equip_set(set_gear, sets.Engaged)
    ---------------------------------------
end
function SJi_buff_change(name,gain)
    ---------------------------------------
    --put your buff_change rules here
    ---------------------------------------
    --equip example: equip(sets.Engaged)
    ---------------------------------------
end
function SJi_midcast(spell,status,set_gear)
    ---------------------------------------
    --put your midcast rules here
    ---------------------------------------
    --equip example: equip_set(set_gear, sets.Engaged)
    ---------------------------------------
end
function SJi_aftercast(spell,status,set_gear)
    ---------------------------------------
    --put your aftercast rules here
    ---------------------------------------
    --equip example: equip_set(set_gear, sets.Engaged)
    ---------------------------------------
end
function SJi_self_command(command)
    ---------------------------------------
    --put your self_command rules here
    ---------------------------------------
    if type(command) == 'table' then
        if command[1]:lower() == 'set' or command[1]:lower() == 's' then
            --put commands that you want to the set command for example: gs c s armor TP
            --example code:
            -- if command[2]:lower() == 'stepmax' then
                -- Stepmax = tonumber(command[3])
                -- add_to_chat(7,'Max step = ' ..Stepmax)
            -- end
        elseif command[1]:lower() == 'cycle' or command[1]:lower() == 'c' then
            --put commands that you want to the cycle command for example: gs c c armor note: for cycling through all posible variants
            --example code:
            -- if command[2]:lower() == 'stepmax' then
                -- Stepmax = (Stepmax % 5) + 1
                -- add_to_chat(7,'Max step = ' ..Stepmax)
            -- end
        elseif command[1]:lower() == 'toggle' or command[1]:lower() == 't' then
            --put commands that you want to the toggle command for example: gs c t armor note: onle needed fot true/false variables
            --example code:
            -- if command == 'stopsteps' then
                -- Stopsteps = not Stopsteps
                -- add_to_chat(7, '----- Steps Will ' .. (Stopsteps and '' or 'Not ') .. 'Stop -----')
            -- end
        end
    else
        --put all other commands here example: gs c tarmor note: this is for single string commands
        --example code:
        -- if command == 'tstopsteps' then
            -- Stopsteps = not Stopsteps
            -- add_to_chat(7, '----- Steps Will ' .. (Stopsteps and '' or 'Not ') .. 'Stop -----')
        -- end
    end
end
function SJi_pet_change(pet,gain,status,set_gear)
    ---------------------------------------
    --put your pet_change rules here
    ---------------------------------------
end
function SJi_pet_midcast(spell,status,set_gear)
    ---------------------------------------
    --put your pet_midcast rules here
    ---------------------------------------
    --equip example: equip_set(set_gear, sets.Engaged)
    ---------------------------------------
end
function SJi_pet_aftercast(spell,status,set_gear)
    ---------------------------------------
    --put your pet_aftercast rules here
    ---------------------------------------
    --equip example: equip_set(set_gear, sets.Engaged)
    ---------------------------------------
end
function SJi_filtered_action(spell,status,set_gear)
    ---------------------------------------
    --put your filtered_action rules here
    ---------------------------------------
end
function SJi_file_unload()
    ---------------------------------------
    --put your file_unload rules here
    ---------------------------------------
end