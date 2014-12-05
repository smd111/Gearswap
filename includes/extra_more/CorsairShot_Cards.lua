        --COR CARD TABLE (use spell.english to get data)
        --This table will give you the card and the card case for each of the quick draw skills
cards = {
    ["Dark Shot"] = {card="Dark Card",case="Dark Card Case",tcard="Trump Card",tcase="Trump Card Case"},
    ["Earth Shot"] = {card="Earth Card",case="Earth Card Case",tcard="Trump Card",tcase="Trump Card Case"},
    ["Ice Shot"] = {card="Ice Card",case="Ice Card Case",tcard="Trump Card",tcase="Trump Card Case"},
    ["Water Shot"] = {card="Water Card",case="Water Card Case",tcard="Trump Card",tcase="Trump Card Case"},
    ["Wind Shot"] = {card="Wind Card",case="Wind Card Case",tcard="Trump Card",tcase="Trump Card Case"},
    ["Fire Shot"] = {card="Fire Card",case="Fire Card Case",tcard="Trump Card",tcase="Trump Card Case"},
    ["Thunder Shot"] = {card="Thunder Card",case="Thunder Card Case",tcard="Trump Card",tcase="Trump Card Case"},
    ["Light Shot"] = {card="Light Card",case="Light Card Case",tcard="Trump Card",tcase="Trump Card Case"},
    }
        

function card_rule(spell,status,set_gear)
    if spell.type == "CorsairShot" and card_check(spell) then
        status.end_spell=true
        send_command('input /item "'..card_getmore(spell)..'" <me>')
    elseif spell.type == "CorsairShot" and not card_check() then
        status.end_spell=true
    end
end
function card_getmore(spell)
    if player.inventory[cards[spell.english].case] ~= nil then
        return cards[spell.english].case
    elseif player.inventory[cards[spell.english].tcase] ~= nil then
        return cards[spell.english].tcase
    end
end
function card_check(spell)
    if (player.inventory[cards[spell.english].card] == nil or player.inventory[cards[spell.english].tcard] == nil) and (player.inventory[cards[spell.english].case] ~= nil or player.inventory[cards[spell.english].tcase] ~= nil ) then
        return true
    else
        add_to_chat(7,"No Cards Available To Cast "..spell.english)
    end
end