nin_wheel_next = {
    ['Katon: Ichi'] = 'Suiton: Ichi',['Hyoton: Ichi'] = 'Katon: Ichi',['Huton: Ichi'] = 'Hyoton: Ichi',['Doton: Ichi'] = 'Huton: Ichi',['Raiton: Ichi'] = 'Doton: Ichi',
    ['Suiton: Ichi'] ='Raiton: Ichi',['Katon: Ni'] = 'Suiton: Ni',['Hyoton: Ni'] = 'Katon: Ni',['Huton: Ni'] = 'Hyoton: Ni',['Doton: Ni'] = 'Huton: Ni',
    ['Raiton: Ni'] = 'Doton: Ni',['Suiton: Ni'] = 'Raiton: Ni',['Katon: San'] = 'Suiton: San',['Hyoton: San'] = 'Katon: San',['Huton: San'] = 'Hyoton: San',
    ['Doton: San'] = 'Huton: San',['Raiton: San'] = 'Doton: San',['Suiton: San'] = 'Raiton: San',}

nin_super_wheel_next = {
    ['Katon: Ichi'] = 'Suiton: San',['Hyoton: Ichi'] = 'Katon: Ichi',['Huton: Ichi'] = 'Hyoton: Ichi',['Doton: Ichi'] = 'Huton: Ichi',['Raiton: Ichi'] = 'Doton: Ichi',
    ['Suiton: Ichi'] ='Raiton: Ichi',['Katon: Ni'] = 'Suiton: Ichi',['Hyoton: Ni'] = 'Katon: Ni',['Huton: Ni'] = 'Hyoton: Ni',['Doton: Ni'] = 'Huton: Ni',
    ['Raiton: Ni'] = 'Doton: Ni',['Suiton: Ni'] = 'Raiton: Ni',['Katon: San'] = 'Suiton: Ichi',['Hyoton: San'] = 'Katon: San',['Huton: San'] = 'Hyoton: San',
    ['Doton: San'] = 'Huton: San',['Raiton: San'] = 'Doton: San',['Suiton: San'] = 'Raiton: San',}
    
nin_wheel_start = {
    [1] = {['Ice']='Hyoton: Ichi',['Fire']='Katon: Ichi',['Water']='Suiton: Ichi',['Lightning']='Raiton: Ichi',['Earth']='Doton: Ichi',['Wind']='Huton: Ichi',},
    [2] = {['Ice']='Hyoton: Ni',['Fire']='Katon: Ni',['Water']='Suiton: Ni',['Lightning']='Raiton: Ni',['Earth']='Doton: Ni',['Wind']='Huton: Ni',},
    [3] = {['Ice']='Hyoton: San',['Fire']='Katon: San',['Water']='Suiton: San',['Lightning']='Raiton: San',['Earth']='Doton: San',['Wind']='Huton: San',},}
        
wheel_count = 0
nin_wheel = false
nin_super_wheel = false
start_nin_element = 'Fire'
start_nin_lvl = 1

--after_cast
if spell.type == 'Ninjutsu' and nin_wheel then
    if wheel_count < 7 then
        wheel_count = wheel_count + 1
        send_command('input /ma "'..nin_wheel_next[spell.en]..'" <t>')
    else
        nin_wheel = false
    end
else spell.type == 'Ninjutsu' and nin_super_wheel then
    if wheel_count < 19 then
        wheel_count = wheel_count + 1
        send_command('input /ma "'..nin_super_wheel_next[spell.en]..'" <t>')
    else
        nin_wheel = false
    end
end
--self_command
function ninja_wheel_self_command(command)
    if 
    local commandArgs = command
    if type(commandArgs) == 'string' then
        commandArgs = T(commandArgs:split(' '))
    end
    if commandArgs[1]:lower() == 'start' then
        for i,v in pairs(commandArgs) do
            if type(v) == 'string' then
                if v:lower() == 'ninwheel' then
                    nin_wheel = true
                elseif v:lower() == 'superninwheel' then
                    nin_super_wheel = true
                elseif windower.wc_match(v:ucfirst(), "Ice|Fire|Water|Lightning|Earth|Wind") then
                    start_nin_element = v:ucfirst()
                elseif windower.wc_match(v, "1|2|3") then
                    start_nin_lvl = tonumber(v)
                end
            else
                start_nin_lvl = tonumber(v)
            end
        end
        if nin_wheel or nin_super_wheel then
            send_command('input /ma "'..nin_wheel_start[start_nin_lvl][start_nin_element]..'" <t>')
        end
    end
end