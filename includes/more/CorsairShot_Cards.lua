function card_getmore(typ)
    local c_case = typ.." Card Case"
    local t_case = "Trump Card Case"
    if player.inventory[c_case] ~= nil then
        return c_case
    elseif player.inventory[t_case] ~= nil then
        return t_case
    end
end
function card_check(typ)
    if (player.inventory[typ.." Card"] == nil or player.inventory["Trump Card"] == nil) 
        and (player.inventory[typ.." Card Case"] ~= nil or player.inventory["Trump Card Case"] ~= nil ) then
        return true
    end
end
function card_rule(spell,status,set_gear)
    if spell.type == "CorsairShot" then
        local typ = string.match(spell.en, '(%a+) Shot')
        if card_check(typ) then
            status.end_spell=true
            status.end_event=true
            send_command('input /item "'..card_getmore(typ)..'" <me>')
        elseif not card_check(typ) then
            add_to_chat(7,"No Cards Available To Cast "..spell.english)
            status.end_spell=true
            status.end_event=true
        end
    end
end