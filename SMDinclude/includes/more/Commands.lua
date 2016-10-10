--Commands Lua
function extra.self_command(status,event,com)
    if type(com) == 'table' then
        if com[1]:lower() == 'set' or com[1]:lower() == 's' then
            --Set gear modes
            if _G[com[2]:lower()..'_types'] then
                for i,v in pairs(_G[com[2]:lower()..'_types']) do
                    if tostring(v):lower() == com[3]:lower() then
                        _G[com[2]:lower()..'_types_count'] = i
                    end
                end
                add_to_chat(8, com[2]..' set to '.._G[com[2]:lower()..'_types'][_G[com[2]:lower()..'_types_count']])
            --Set Max Steps
            elseif com[2]:lower() == 'stepmax' then
                local max_steps = (player.main_job == "DNC" and 6 or 5)
                if tonumber(com[3]) > max_steps then
                    add_to_chat(8, 'Max step cap is '..tostring(max_steps))
                else
                    Stepmax = tonumber(com[3])
                    add_to_chat(8, 'Max step = '..tostring(Stepmax))
                end
            end
        elseif com[1]:lower() == 'cycle' or com[1]:lower() == 'c' then
            --Cycle Max Steps
            if com[2]:lower() == 'stepmax' then
                Stepmax = (Stepmax % (player.main_job == "DNC" and 6 or 5)) + 1
                add_to_chat(8, 'Max step = '..tostring(Stepmax))
            end
        elseif com[1]:lower() == 'toggle' or com[1]:lower() == 't' then
            --Toggle Step Stoper
            if com[2]:lower() == 'stopsteps' then
                Stopsteps = not Stopsteps
                add_to_chat(8, 'Step Stopper '..(Stopsteps and 'Enabled' or 'Disabled'))
            end
        elseif com[1]:lower() == 'clear' then
            --Clear Aggrocount
            if com[2]:lower() == 'aggrocount' and reg_event.atacking_mobs then
                if reg_event and reg_event.clear_aggro_count then
                    reg_event.clear_aggro_count()
                    add_to_chat(8, 'Aggro Counter Cleared')
                end
            end
        end
    else
        if com == "reload_gearswap" then
            if file_write and file_write.write then
                file_write.write()
            end
            send_command("lua reload gearswap")
        elseif com == 'tstopsteps' then
            Stopsteps = not Stopsteps
            add_to_chat(8, 'Step Stopper '..(Stopsteps and 'Enabled' or 'Disabled'))
        elseif com == 'stepcount' then
            Stepmax = (Stepmax % (player.main_job == "DNC" and 6 or 5)) + 1
            add_to_chat(8, 'Max step = '..tostring(Stepmax))
        elseif com == 'autohw' then
            Hwauto = not Hwauto
            add_to_chat(8, 'Auto Healing Waltz Is '..(Hwauto and 'Enabled' or 'Disabled'))
        end
    end
end