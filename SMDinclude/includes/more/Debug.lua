full_debug = false
fdebug = {}
fdebug.count = 1
fdebug.type = {"Status_Change","Pet_Change","Filtered_Action","Pretarget","Precast","Buff_Change","Midcast","Pet_Midcast","Aftercast","Pet_Aftercast","Indi_Change",
               "Pet_Status_Change","Sub_Job_Change","Self_Command","All"}
function fdebug.code(status,event,spell)
    if full_debug then
        if fdebug.type[fdebug.count]:lower() == event or fdebug.type[fdebug.count] == "All" then
            add_to_chat(cc.mc, "Event = "..event)
            for i,v in pairs(spell) do
                if type(v) == "table" and not S{"levels","flags"}:contains(i) then
                    for i2,v2 in pairs(v) do
                        add_to_chat(cc.mc, "spell."..i.."."..i2.." = "..tostring(v2))
                    end
                else
                    add_to_chat(cc.mc, "spell."..i.." = "..tostring(v))
                end
            end
        end
    end
end
fdebug.filtered_action = fdebug.code
fdebug.pretarget = fdebug.code
fdebug.precast = fdebug.code
fdebug.midcast = fdebug.code
fdebug.pet_midcast = fdebug.code
fdebug.aftercast = fdebug.code
fdebug.pet_aftercast = fdebug.code 
function fdebug.status_change(status,event,new,old)
    if full_debug then
        if fdebug.type[fdebug.count]:lower() == event or fdebug.type[fdebug.count] == "All" then
            add_to_chat(cc.mc, "Event = "..event) add_to_chat(cc.mc, "Status New = "..tostring(new)) add_to_chat(cc.mc, "Status Old = "..tostring(old))
        end
    end
end
fdebug.pet_status_change = fdebug.status_change
function fdebug.sub_job_change(status,event,new,old)
    if full_debug then
        if fdebug.type[fdebug.count]:lower() == event or fdebug.type[fdebug.count] == "All" then
            add_to_chat(cc.mc, "Event = "..event) add_to_chat(cc.mc, "New Sub Job= "..tostring(new)) add_to_chat(cc.mc, "Old Sub Job = "..tostring(old))
        end
    end
end
function fdebug.pet_change(status,event,pet,gain)
    if full_debug then
        if fdebug.type[fdebug.count]:lower() == event or fdebug.type[fdebug.count] == "All" then
            add_to_chat(cc.mc, "Event = "..event)
            for i,v in pairs(pet) do
                if type(v) == "table" then
                    for i2,v2 in pairs(v) do
                        add_to_chat(cc.mc, "pet."..i.."."..i2.." = "..v2)
                    end
                else
                    add_to_chat(cc.mc, "pet."..i.." = "..v)
                end
            end
            add_to_chat(cc.mc, "gain = "..tostring(gain))
        end
    end
end
function fdebug.buff_change(status,event,name,gain,buff_table)
    if full_debug then
        if fdebug.type[fdebug.count]:lower() == event or fdebug.type[fdebug.count] == "All" then
            add_to_chat(cc.mc, "Event = "..event)
            add_to_chat(cc.mc, "buff = "..tostring(name)..', gain = '..tostring(gain))
            for i,v in pairs(buff_table) do
                add_to_chat(cc.mc, "buff_table."..i.." = "..v)
            end
        end
    end
end
function fdebug.indi_change(status,event,indi_table,gain)
    if full_debug then
        if fdebug.type[fdebug.count]:lower() == event or fdebug.type[fdebug.count] == "All" then
            add_to_chat(cc.mc, "Event = "..event)
            for i,v in pairs(indi_table) do
                add_to_chat(cc.mc, "indi_table."..i.." = "..v)
            end
            add_to_chat(cc.mc, "gain = "..tostring(gain))
        end
    end
end
function fdebug.self_command(status,event,command)
    if full_debug then
        if fdebug.type[fdebug.count]:lower() == event or fdebug.type[fdebug.count] == "All" then
        add_to_chat(cc.mc, "Event = "..event)
            if type(command) == "table" then
                for i,v in pairs(command) do
                    add_to_chat(cc.mc, 'Command['..i..'] = '..v)
                end
            else
                add_to_chat(cc.mc, 'Command = '..command)
            end
        end
    end
    if type(command) == "table" then
        if command[1]:lower() == 'set' or command[1]:lower() == 's' then
            if command[2]:lower() == 'debug' then
                local corrections_for_set_debug = {['status_change']='status_change',['sc']='status_change',['pet_change']='pet_change',['pc']='pet_change',
                                                   ['filtered_action']='filtered_action',['fa']='filtered_action',['pretarget']='pretarget',['pret']='pretarget',
                                                   ['precast']='precast',['prec']='precast',['buff_change']='buff_change',['bc']='buff_change',['midcast']='midcast',
                                                   ['mc']='midcast',['pet_midcast']='pet_midcast',['pmc']='pet_midcast',['aftercast']='aftercast',['ac']='aftercast',
                                                   ['pet_aftercast']='pet_aftercast',['pac']='pet_aftercast',['indi_change']='indi_change',['ic']='indi_change',
                                                   ['self_command']='self_command',['command']='self_command',['scom']='self_command',['all']='all',}
                for i, v in ipairs(fdebug.type) do
                    if corrections_for_set_debug[string.lower(command[3])] == v:lower() then
                        fdebug.count = i
                    end
                end 
            end
        elseif command[1]:lower() == 'show' and (command[2]:lower() == 'variable' or command[2]:lower() == 'var') then
            local tbl = loadstring("return "..command[3])() or loadstring("return user_env."..command[3])()
            if type(tbl) == "table" then
                for i,v in pairs(tbl) do
                    print(command[3].."."..i.." = "..tostring(v))
                end
            else
                print(command[3].." = "..tostring(tbl))
            end
        end
    elseif command == 'tDebug' then
        full_debug = not full_debug
        send_command('clear log')
        send_command('gs fdebug.mode;wait 0.3;gs show_swaps')
        add_to_chat(cc.mc, 'Debug Mode = ' .. (full_debug and 'ON' or 'OFF'))
    elseif command == 'cDebugtype' then
        fdebug.count = (fdebug.count % #fdebug.type) + 1
        add_to_chat(cc.mc, 'Debug Mode Type = ' .. tostring(fdebug.type[fdebug.count]))
    elseif command == 'test' then
        ---
    end
    if updatedisplay then
        updatedisplay()
    end
end