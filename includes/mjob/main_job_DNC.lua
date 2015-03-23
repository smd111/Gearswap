if not Stepmax then
    Stepmax = 1
end
if not Stopsteps then
    Stopsteps = false
end
    Hwauto = false

function MJi_precast(status,set_gear,spell)
    if spell.type == 'Waltz' and not spell.en:startswith('Divine Waltz') then 
        if spell.target.hpp <= 75 then
            if player.tp >= 800 and player.main_job_level > 87 then
                if spell.en ~= 'Curing Waltz V' then
                    send_command('@input /ja "Curing Waltz V" <me>')
                    status.end_spell=true
                    status.end_event=true
                    return set_gear
                end
            elseif player.tp >= 650 and player.main_job_level > 70 then
                if spell.en ~= 'Curing Waltz IV' then
                    send_command('@input /ja "Curing Waltz IV" <me>')
                    status.end_spell=true
                    status.end_event=true
                    return set_gear
                end
            elseif player.tp >= 500 and player.main_job_level > 44 then
                if spell.en ~= 'Curing Waltz III' then
                    send_command('@input /ja "Curing Waltz III" <me>')
                    status.end_spell=true
                    status.end_event=true
                    return set_gear
                end
            elseif player.tp >= 350 and player.main_job_level > 29 then
                if spell.en ~= 'Curing Waltz II' then
                    send_command('@input /ja "Curing Waltz II" <me>')
                    status.end_spell=true
                    status.end_event=true
                    return set_gear
                end
            elseif player.tp >= 200 and player.main_job_level > 14 then
                if spell.en ~= 'Curing Waltz' then
                    send_command('@input /ja "Curing Waltz" <me>')
                    status.end_spell=true
                    status.end_event=true
                    return set_gear
                end
            else
                status.end_spell=true
                status.end_event=true
            end
        elseif spell.target.hpp >= 75 and spell.target.type == 'SELF' then
            if has_any_buff_of(Waltz.debuff) and player.main_job_level > 34 then
                if spell.en ~= 'Healing Waltz' then
                    send_command('@input /ja "Healing Waltz" <me>')
                    status.end_spell=true
                    status.end_event=true
                    return set_gear
                end
            else
                status.end_spell=true
                status.end_event=true
            end
        else
            status.end_spell=true
            status.end_event=true
        end
    end
    if spell.type == 'Samba' and spell.en ~= 'Haste Samba' and spell.en ~= 'Aspir Samba' and spell.en ~= 'Aspir Samba II' then
        if player.tp >= 400 and player.main_job_level >= 65 then
            if spell.en ~= 'Drain Samba III' then
                send_command('@input /ja "Drain Samba III" <me>')
                status.end_spell=true
                status.end_event=true
                return set_gear
            end
        elseif player.tp >= 250 and player.main_job_level >= 35 then
            if spell.en ~= 'Drain Samba II' then
                send_command('@input /ja "Drain Samba II" <me>')
                status.end_spell=true
                status.end_event=true
                return set_gear
            end
        elseif player.tp >= 100 and player.main_job_level >= 5 then
            if spell.en ~= 'Drain Samba' then
                send_command('@input /ja "Drain Samba" <me>')
                status.end_spell=true
                status.end_event=true
                return set_gear
            end
        else
            status.end_spell=true
            status.end_event=true
        end
    end
    if spell.type == 'Step' then
        if spell.tp_cost > player.tp then
            status.end_spell=true
            status.end_event=true
            return set_gear
        end
        if Stopsteps then
            local fm_count = 0
            for i, v in pairs(buffactive) do
                if string.startswith(tostring(i), 'finishing move') then
                    fm_count = tonumber(string.sub(i, 16))
                    if fm_count >= Stepmax then
                        status.end_spell=true
                        status.end_event=true
                        return set_gear
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
            return set_gear
        end
    end
end 
function MJi_buff_change(status,set_gear,name,gain,buff_tabl)
    if Hwauto and table.contains(Waltz.debuff,name) then
        if gain and player.tp >= 200 and player.main_job_level > 34 then
            send_command('@input /ja "Healing Waltz" <me>')
        end
    end
    return set_gear
end
function MJi_self_command(status,set_gear,command)
    if type(command) == 'table' then
        if command[1]:lower() == 'set' or command[1]:lower() == 's' then
            if command[2]:lower() == 'stepmax' then
                Stepmax = tonumber(command[3])
                add_to_chat(7,'Max step = ' ..Stepmax)
            end
        elseif command[1]:lower() == 'cycle' or command[1]:lower() == 'c' then
            if command[2]:lower() == 'stepmax' then
                Stepmax = (Stepmax % 5) + 1
                add_to_chat(7,'Max step = ' ..Stepmax)
            end
        elseif command[1]:lower() == 'toggle' or command[1]:lower() == 't' then
            if command == 'stopsteps' then
                Stopsteps = not Stopsteps
                add_to_chat(7, '----- Steps Will ' .. (Stopsteps and '' or 'Not ') .. 'Stop -----')
            end
            if command == 'autohw' then
                Hwauto = not Hwauto
                add_to_chat(7, '----- Auto Healing Waltz Is ' .. (Hwauto and 'Enabled' or 'Disabled'))
            end
        end
    else
        if command == 'tstopsteps' then
            Stopsteps = not Stopsteps
            add_to_chat(7, '----- Steps Will ' .. (Stopsteps and '' or 'Not ') .. 'Stop -----')
        end
        if command == 'stepcount' then
            Stepmax = (Stepmax % 5) + 1
            add_to_chat(7,'Max step = ' ..Stepmax)
        end
        if command == 'autohw' then
            Hwauto = not Hwauto
            add_to_chat(7, '----- Auto Healing Waltz Is ' .. (Hwauto and 'Enabled' or 'Disabled'))
        end
    end
end