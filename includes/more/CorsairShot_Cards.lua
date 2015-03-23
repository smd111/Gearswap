
    card_short = {Fire="Fire",Ice="Ice",Wind="Wind",Earth="Earth",Thunder="Thnd.",Water="Water",Light="Light",Dark="Dark",}

function card_getmore(typ)
    if player.inventory[card_short[typ].." Card Case"] ~= nil then
        return card_short[typ].." Card Case"
    elseif player.inventory["Trump Card Case"] ~= nil then
        return "Trump Card Case"
    end
end
function card_check(typ)
    if (player.inventory[typ.." Card"] == nil or player.inventory["Trump Card"] == nil) 
        and (player.inventory[card_short[typ].." Card Case"] ~= nil or player.inventory["Trump Card Case"] ~= nil ) then
        return true
    end
end
function card_rule(status,set_gear,spell)
    if spell.type == "CorsairShot" then
        local typ = string.match(spell.en, '(%a+) Shot')
        if card_check(typ) then
            status.end_spell=true
            status.end_event=true
            send_command('input /item "'..card_getmore(typ)..'" <me>')
        end
    end
end