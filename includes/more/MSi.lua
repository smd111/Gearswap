if not Changestaff then
    Changestaff = false --Togle with //gs c tchangestaff (true for change staves, false for do not change staves)
end
if not Usestaff then
    Usestaff = 'Atk' --Togle with //gs c tstaveuse (Atk for Attack Staves, Acc for Accuracy Staves)
end

MSi_staves = {Fire="Atar",Ice="Vourukasha",Wind="Vayuvata",Earth="Vishrava",Lightning="Apamajas",Water="Haoma",Light="Arka",Dark="Xsaeta",}
MSi_grips = {Fire="Fire",Ice="Ice",Wind="Wind",Earth="Earth",Lightning="Thunder",Water="Water",Light="Light",Dark="Dark",}

function check_type()
    if Usestaff == "Atk" then
        return "I"
    elseif Usestaff == "Acc" then
        return "II"
    end
end
function MSi_precast(status,set_gear,event_type,spell)
    if Changestaff then
        if Typ.spells:contains(spell.type) then
            if Cure.spells:contains(spell.english) then
                set_gear = set_combine(set_gear, {main="Arka IV",sub="Dominie's Grip",body="Heka's Kalasiris",hands="Bokwus Gloves",neck="Phalaina Locket",left_ear="Roundel Earring",})
            else
                set_gear = set_combine(set_gear, {main=MSi_staves[spell.element].." "..check_type(),sub=MSi_grips[spell.element].." Grip"})
            end
        end
    end
    return set_gear
end
MSi_midcast = MSi_precast
function MSi_self_command(status,set_gear,event_type,command)
    if type(command) == 'table' then
        if command[1]:lower() == 'set' or command[1]:lower() == 's' then
            if command[2]:lower() == "staves" then
                Usestaff = command[3]:ucfirst()
                add_to_chat(7, '----- Staves Set To '..Usestaff..' -----')
            end
        elseif command[1]:lower() == 'toggle' or command[1]:lower() == 't' then
            if command[2]:lower() == "staves" then
                Changestaff = not Changestaff
                add_to_chat(7, '----- Staves Will ' .. (Changestaff and '' or 'NOT ') .. 'Change -----')
            end
        end
    else
        if command == 'tstavetouse' then
            Usestaff = (Usestaff=='Atk' and 'Acc' or 'Atk')
            add_to_chat(7, '----- Staves Set To '..Usestaff..' -----')
        elseif command == 'tchangemagestaff' then
            Changestaff = not Changestaff
            add_to_chat(7, '----- Staves Will ' .. (Changestaff and '' or 'NOT ') .. 'Change -----')
        end
    end
end