ninja_wheel_next = {
    ['Katon: Ichi']='Suiton: Ichi',['Hyoton: Ichi']='Katon: Ichi',['Huton: Ichi']='Hyoton: Ichi',['Doton: Ichi']='Huton: Ichi',['Raiton: Ichi']='Doton: Ichi',
    ['Suiton: Ichi']='Raiton: Ichi',['Katon: Ni']='Suiton: Ni',['Hyoton: Ni']='Katon: Ni',['Huton: Ni']='Hyoton: Ni',['Doton: Ni']='Huton: Ni',
    ['Raiton: Ni']='Doton: Ni',['Suiton: Ni']='Raiton: Ni',['Katon: San']='Suiton: San',['Hyoton: San']='Katon: San',['Huton: San']='Hyoton: San',
    ['Doton: San']='Huton: San',['Raiton: San']='Doton: San',['Suiton: San']='Raiton: San',}

ninja_wheel_super_next = {
    ['Katon: Ichi']='Suiton: San',['Hyoton: Ichi']='Katon: Ichi',['Huton: Ichi']='Hyoton: Ichi',['Doton: Ichi']='Huton: Ichi',['Raiton: Ichi']='Doton: Ichi',
    ['Suiton: Ichi']='Raiton: Ichi',['Katon: Ni']='Suiton: Ichi',['Hyoton: Ni']='Katon: Ni',['Huton: Ni']='Hyoton: Ni',['Doton: Ni']='Huton: Ni',
    ['Raiton: Ni']='Doton: Ni',['Suiton: Ni']='Raiton: Ni',['Katon: San']='Suiton: Ichi',['Hyoton: San']='Katon: San',['Huton: San']='Hyoton: San',
    ['Doton: San']='Huton: San',['Raiton: San']='Doton: San',['Suiton: San']='Raiton: San',}
    
ninja_wheel_start = {
    [1]={['Ice']='Hyoton: Ichi',['Fire']='Katon: Ichi',['Water']='Suiton: Ichi',['Lightning']='Raiton: Ichi',['Earth']='Doton: Ichi',['Wind']='Huton: Ichi',},
    [2]={['Ice']='Hyoton: Ni',['Fire']='Katon: Ni',['Water']='Suiton: Ni',['Lightning']='Raiton: Ni',['Earth']='Doton: Ni',['Wind']='Huton: Ni',},
    [3]={['Ice']='Hyoton: San',['Fire']='Katon: San',['Water']='Suiton: San',['Lightning']='Raiton: San',['Earth']='Doton: San',['Wind']='Huton: San',},}
        
ninja_wheel_start_type = false
ninja_wheel_count = 0
ninja_wheel_tog = false
ninja_wheel_super_tog = false
ninja_wheel_start_element = 'Fire'
ninja_wheel_start_lvl = 1
ninja_wheel_element = {"Ice","Fire","Water","Lightning","Earth"}
ninja_wheel_element_count = 1

function ninja_wheel_precast(spell)
    if spell.type == 'Ninjutsu' and not player.in_combat then
        ninja_wheel_tog = false
        ninja_wheel_super_tog = false
    end
end
function ninja_wheel_aftercast(spell)
    if spell.type == 'Ninjutsu' and ninja_wheel_tog then
        if spell.interrupted then
            ninja_wheel_count = ninja_wheel_count - 1
        end
        if ninja_wheel_count <= 7 then
            ninja_wheel_count = ninja_wheel_count + 1
            send_command('input /ma "'..ninja_wheel_next[spell.en]..'" <t>')
        else
            ninja_wheel_count = 0
            ninja_wheel_tog = false
        end
    elseif spell.type == 'Ninjutsu' and ninja_wheel_super_tog then
        if spell.interrupted then
            ninja_wheel_count = ninja_wheel_count - 1
        end
        if ninja_wheel_count <= 19 then
            ninja_wheel_count = ninja_wheel_count + 1
            send_command('input /ma "'..ninja_wheel_super_next[spell.en]..'" <t>')
        else
            ninja_wheel_count = 0
            ninja_wheel_super_tog = false
        end
    end
end
function ninja_wheel_self_command(command)
    if type(command) == "table" then
        if command[1]:lower() == 'startnin' then
            if command[2]:lower() == 'ninwheel' or command[2]:lower() == 'nw' then
                ninja_wheel_tog = true
            elseif command[2]:lower() == 'superninwheel' or command[2]:lower() == 'snw' then
                ninja_wheel_super_tog = true
            end
        elseif command[1]:lower() == 'setnin' or command[1]:lower() == 'sn' then
            if (command[2]:lower() == 'element' or command[2]:lower() == 'ele') and windower.wc_match(command[3]:ucfirst(), "Ice|Fire|Water|Lightning|Earth|Wind") then
                ninja_wheel_start_element = command[3]:ucfirst()
            elseif command[2]:lower() == 'level' and windower.wc_match(command[3], "1|2|3") then
                ninja_wheel_start_lvl = tonumber(command[3])
            end
        end
    end
    if ninja_wheel_tog or ninja_wheel_super_tog then
        send_command('input /ma "'..ninja_wheel_start[ninja_wheel_start_lvl][ninja_wheel_start_element]..'" <t>')
    end
end