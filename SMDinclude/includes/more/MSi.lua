msi = {}
msi.staves = {Fire="Atar",Ice="Vourukasha",Wind="Vayuvata",Earth="Vishrava",Lightning="Apamajas",Water="Haoma",Light="Arka",Dark="Xsaeta",}
msi.grips = {Fire="Fire",Ice="Ice",Wind="Wind",Earth="Earth",Lightning="Thunder",Water="Water",Light="Light",Dark="Dark",}
msi.stype = {["Atk"]="I",["Acc"]="II"}

function msi.precast(status,current_event,spell)
    if Changestaff then
        if Typ.spells:contains(spell.type) then
            if Cure.spells:contains(spell.english) then
                if sets.cure then
                    sets.building[current_event] = set_combine(sets.building[current_event], cure_gear[lang[gearswap.language]], sets.cure)
                else
                    sets.building[current_event] = set_combine(sets.building[current_event], cure_gear[lang[gearswap.language]])
                end
            else
                local spell_element = (type(spell.element)=='number' and gearswap.res.elements[spell.element] or gearswap.res.elements:with('name', spell.element))
                local spell_stave = gearswap.res.items:with('enl', msi.staves[spell_element.en]..' '..msi.stype[Usestaff])
                local spell_grip = gearswap.res.items:with('enl', msi.grips[spell_element.en].." Grip")
                sets.building[current_event] = set_combine(sets.building[current_event], {main=sspell_stave[gearswap.language],sub=spell_grip[gearswap.language]})
            end
        end
    end
end
msi.midcast = msi.precast
function msi.self_command(status,current_event,command)
    if type(command) == 'table' then
        if command[1]:lower() == 'set' or command[1]:lower() == 's' then
            if command[2]:lower() == "staves" then
                Usestaff = command[3]:ucfirst()
                add_to_chat(8, 'Magian Staves Set To '..Usestaff)
            end
        elseif command[1]:lower() == 'toggle' or command[1]:lower() == 't' then
            if command[2]:lower() == "staves" then
                Changestaff = not Changestaff
                add_to_chat(8, 'Auto Magian Stave Change '..(Changestaff and 'Enabled' or 'Disabled'))
            end
        end
    else
        if command == 'tstavetouse' then
            Usestaff = (Usestaff=='Atk' and 'Acc' or 'Atk')
            add_to_chat(8, 'Magian Staves Set To '..Usestaff)
        elseif command == 'tchangemagestaff' then
            Changestaff = not Changestaff
            add_to_chat(8, 'Auto Magian Stave Change '..(Changestaff and 'Enabled' or 'Disabled'))
        end
    end
end