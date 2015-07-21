card = {}
card.item_use = 'none'
function card.check(name)
    local card_case = res.items:with('en', name.." Card Case")
    if player.inventory[card_case[gearswap.language]] ~= nil then return card_case[gearswap.language]
    elseif player.inventory[res.items[5870][gearswap.language]] ~= nil then return res.items[5870][gearswap.language]
    end
end
function card.rule(status,current_event,spell)
    if spell.type == "CorsairShot" then
        local spell_element = (type(spell.element)=='number' and res.elements[spell.element] or res.elements:with('name', spell.element))
        local card_short = {Fire="Fire",Ice="Ice",Wind="Wind",Earth="Earth",Thunder="Thnd.",Water="Water",Light="Light",Dark="Dark",}
        local name = card.check(card_short[spell_element.en])
        if name then card.item_use = name send_command('input /item "'..name..'" <me>') end
        status.end_spell=true status.end_event=true
    end
end
function card.aftercast(status,current_event,spell) if spell.english == card.item_use then card.item_use = 'none' end end