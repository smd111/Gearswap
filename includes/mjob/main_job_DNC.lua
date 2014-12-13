if not Stepmax then
    Stepmax = 1
end
if not Stopsteps then
    Stopsteps = false
end
    Hwauto = false
--any functions you do not need should be removed or will cause errors
function MJi_precast(spell,status,set_gear)
    ---------------------------------------
    --put your precast rules here
    ---------------------------------------
    --equip example: equip_pre_cast = set_combine(equip_pre_cast, sets.Engaged)
    ---------------------------------------
    if spell.type == 'Step' then
        if spell.tp_cost > player.tp then
            status.end_spell=true
            status.end_event=true
            return
        end
        if Stopsteps then
        local fm_count = 0
            for i, v in pairs(buffactive) do
                if string.startswith(tostring(i), 'finishing move') then
                    fm_count = tonumber(string.sub(i, 16))
                    if fm_count >= Stepmax then
                        status.end_spell=true
                        status.end_event=true
                        return
                    end
                end
            end
        end
    end
    if spell.en == 'Spectral Jig' then
        send_command('cancel 71')
    end
    if spell.en == 'Reverse Flourish' then
        if player.tp >= 2750 then
            status.end_spell=true
            status.end_event=true
            return
        end
    end
end
function MJi_buff_change(name,gain)
    if Hwauto and windower.wc_match(name, "Max * Down|Magic * Down|* Down|bane|Bio|blindness|curse|Dia|disease|Shock|Rasp|Choke|Frost|Burn|Drown|Flash|paralysis|plague|poison|silence|slow|weight") then
        if gain and player.tp >= 200 and player.sub_job_level > 34 then
            send_command('@input /ja "Healing Waltz" <me>')
        end
    end
end
function MJi_self_command(command)
    ---------------------------------------
    --put your self_command rules here
    ---------------------------------------
    if command == 'tstopsteps' then
        Stopsteps = not Stopsteps
        -- add_to_chat(7, '----- Steps Will ' .. (Stopsteps and '' or 'Not ') .. 'Stop -----')
    end
    if command == 'stepcount' then
        Stepmax = (Stepmax % 5) + 1
        -- add_to_chat(7,'Max step = ' ..Stepmax)
    end
    if command == 'autohw' then
        Hwauto = not Hwauto
        add_to_chat(7, '----- Auto Healing Waltz Is ' .. (Hwauto and 'Enabled' or 'Disabled'))
    end
    if command:lower():startswith('set ') or command:lower():startswith('s ') then
        local commandArgs = command
        if type(commandArgs) == 'string' then
            commandArgs = T(commandArgs:split(' '))
        end
        if commandArgs[2]:lower() == 'steps' then
            if tonumber(commandArgs[3]) <= 5 then
                Stepmax = tonumber(commandArgs[3])
            else
                add_to_chat(7, "Cannot set max steps to "..commandArgs[3].." because max is 5.")
            end
        end
        if updatedisplay then
            updatedisplay()
        end
    end
end
