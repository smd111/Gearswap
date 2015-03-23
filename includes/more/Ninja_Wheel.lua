ninja_wheel_next = {['Katon']='Suiton',['Hyoton']='Katon',['Huton']='Hyoton',['Doton']='Huton',['Raiton']='Doton',['Suiton']='Raiton'}
ninja_wheel_level = {[1]="Ichi",[2]="Ni",[3]="San"}
ninja_wheel_next_level = {["San"]="Ichi",["Ichi"]="Ni",["Ni"]="San"}
ninja_wheel_element = {['Ice']='Hyoton',['Fire']='Katon',['Water']='Suiton',['Lightning']='Raiton',['Earth']='Doton',['Wind']='Huton',}
ninja_wheel_start_type = false
ninja_wheel_count = 0
ninja_wheel_tog = false
ninja_wheel_super_tog = false
ninja_wheel_start_element = "Ice"
ninja_wheel_start_lvl = 1
ninja_wheel_element_list = {"Ice","Fire","Water","Lightning","Earth"}
ninja_wheel_element_count = 1
ninja_wheel_super_cycle = 1

function ninja_wheel_precast(status,set_gear,spell)
    if spell.type == 'Ninjutsu' and not player.in_combat then
        ninja_wheel_tog = false
        ninja_wheel_super_tog = false
    end
end
function ninja_wheel_aftercast(status,set_gear,spell)
    if spell.type == 'Ninjutsu' then
        local name,level = string.match(spell.en, '(%a+): (%a+)')
        if spell.interrupted then
            send_command('wait 3.0;input /ma "'..name..': '..level..'" <t>')
            return
        end
        if ninja_wheel_tog then
            ninja_wheel_count = ninja_wheel_count + 1
            if ninja_wheel_count < 7 then
                send_command('wait 3.0;input /ma "'..ninja_wheel_next[name]..': '..level..'" <t>')
            else
                ninja_wheel_count = 0
                ninja_wheel_tog = false
            end
        elseif ninja_wheel_super_tog then
            ninja_wheel_count = ninja_wheel_count + 1
            if ninja_wheel_count == 7 and not ninja_wheel_super_cycle == 3 then
                send_command('wait 3.0;input /ma "'..ninja_wheel_next[name]..': '..ninja_wheel_next_level[level]..'" <t>')
                ninja_wheel_super_cycle = ninja_wheel_super_cycle + 1
            elseif ninja_wheel_count < 7 then
                send_command('wait 3.0;input /ma "'..ninja_wheel_next[name]..': '..level..'" <t>')
            else
                ninja_wheel_count = 0
                ninja_wheel_super_cycle = 1
                ninja_wheel_super_tog = false
            end
        end
    end
end
function ninja_wheel_self_command(status,set_gear,command)
    if type(command) == "table" then
        if command[1]:lower() == 'startnin' then
            if command[2]:lower() == 'ninwheel' or command[2]:lower() == 'nw' then
                ninja_wheel_tog = true
            elseif command[2]:lower() == 'superninwheel' or command[2]:lower() == 'snw' then
                ninja_wheel_super_tog = true
            end
        elseif command[1]:lower() == 'setnin' or command[1]:lower() == 'sn' then
            if (command[2]:lower() == 'element' or command[2]:lower() == 'ele') and ninja_wheel_element_list:contains(command[3]:ucfirst()) then
                ninja_wheel_start_element = command[3]:ucfirst()
            elseif command[2]:lower() == 'level' and windower.wc_match(command[3], "1|2|3") then
                ninja_wheel_start_lvl = tonumber(command[3])
            end
        end
    end
    if ninja_wheel_tog or ninja_wheel_super_tog then
        send_command('input /ma "'..ninja_wheel_element[ninja_wheel_start_element]..': '..ninja_wheel_level[ninja_wheel_start_lvl]..'" <t>')
    end
end