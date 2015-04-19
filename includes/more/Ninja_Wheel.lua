ninja_wheel = {}
ninja_wheel.next = {['Katon']='Suiton',['Hyoton']='Katon',['Huton']='Hyoton',['Doton']='Huton',['Raiton']='Doton',['Suiton']='Raiton'}
ninja_wheel.level = {"Ichi","Ni","San"}
ninja_wheel.next_level = {["San"]="Ichi",["Ichi"]="Ni",["Ni"]="San"}
ninja_wheel.element = {['Ice']='Hyoton',['Fire']='Katon',['Water']='Suiton',['Lightning']='Raiton',['Earth']='Doton',['Wind']='Huton',}
ninja_wheel.start_type = false
ninja_wheel.count = 0
ninja_wheel.tog = false
ninja_wheel.super_tog = false
ninja_wheel.start_element = "Ice"
ninja_wheel.start_lvl = 1
ninja_wheel.element_list = {"Ice","Fire","Water","Lightning","Earth"}
ninja_wheel.element_count = 1
ninja_wheel.super_cycle = 1

function ninja_wheel.precast(status,current_event,spell)
    if spell.type == 'Ninjutsu' and not player.in_combat then
        ninja_wheel.tog = false
        ninja_wheel.super_tog = false
    end
end
function ninja_wheel.aftercast(status,current_event,spell)
    if spell.type == 'Ninjutsu' then
        local name,level = string.match(spell.en, '(%a+): (%a+)')
        if spell.interrupted then
            local nin_spell = res.items:with('en', name..': '..level)
            send_command('wait 3.0;input /ma "'..nin_spell[gearswap.language]..'" <t>')
            return
        end
        if ninja_wheel.tog then
            ninja_wheel.count = ninja_wheel.count + 1
            if ninja_wheel.count < 7 then
                local nin_spell = res.items:with('en', ninja_wheel.next[name]..': '..level)
                send_command('wait 3.0;input /ma "'..nin_spell[gearswap.language]..'" <t>')
            else
                ninja_wheel.count = 0
                ninja_wheel.tog = false
            end
        elseif ninja_wheel.super_tog then
            ninja_wheel.count = ninja_wheel.count + 1
            if ninja_wheel.count == 7 and not ninja_wheel.super_cycle == 3 then
                local nin_spell = res.items:with('en', ninja_wheel.next[name]..': '..ninja_wheel.level[level])
                send_command('wait 3.0;input /ma "'..nin_spell[gearswap.language]..'" <t>')
                ninja_wheel.super_cycle = ninja_wheel.super_cycle + 1
            elseif ninja_wheel.count < 7 then
                local nin_spell = res.items:with('en', ninja_wheel.next[name]..': '..level)
                send_command('wait 3.0;input /ma "'..nin_spell[gearswap.language]..'" <t>')
            else
                ninja_wheel.count = 0
                ninja_wheel.super_cycle = 1
                ninja_wheel.super_tog = false
            end
        end
    end
end
function ninja_wheel.self_command(status,current_event,command)
    if type(command) == "table" then
        if command[1]:lower() == 'startnin' then
            if command[2]:lower() == 'ninwheel' or command[2]:lower() == 'nw' then
                ninja_wheel.tog = true
            elseif command[2]:lower() == 'superninwheel' or command[2]:lower() == 'snw' then
                ninja_wheel.super_tog = true
            end
        elseif command[1]:lower() == 'setnin' or command[1]:lower() == 'sn' then
            if (command[2]:lower() == 'element' or command[2]:lower() == 'ele') and ninja_wheel.element_list:contains(command[3]:ucfirst()) then
                ninja_wheel.start_element = command[3]:ucfirst()
            elseif command[2]:lower() == 'level' and windower.wc_match(command[3], "1|2|3") then
                ninja_wheel.start_lvl = tonumber(command[3])
            end
        end
    end
    if ninja_wheel.tog or ninja_wheel.super_tog then
        send_command('input /ma "'..ninja_wheel.element[ninja_wheel.start_element]..': '..ninja_wheel.level[ninja_wheel.start_lvl]..'" <t>')
    end
end