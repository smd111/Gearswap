ammo = {} sets.ammo_empty = {ammo=empty,} ammo.item_use = "none"
function ammo.to_bag(ammo)
    local find_bag_type = {}
    local find_ammo_type = {}
    local bag_type = 'none'
    local ammo_name = ""
    if ammo == "Bullet" or ammo:contains("ブレット") then 
        find_bag_type = gearswap.res.items[5363]
    elseif ammo == "Antique Bullet" or ammo == "Atq. Bullet +1" or ammo:contains("旧式弾") then
        local number = tonumber(string.match(ammo, '%d')) or 0
        local id = 5284 + number find_bag_type = gearswap.res.items[id]
    elseif ammo:contains("Dogbolt") or ammo:contains("ドッグボルト") then
        local number = tonumber(string.match(ammo, '%d')) or 0
        local id = 5278 + number find_bag_type = gearswap.res.items[id]
    elseif ammo:contains("Crude Arrow") or ammo:contains("野矢") then
        local number = tonumber(string.match(ammo, '%d')) or 0
        local id = 5270 + number find_bag_type = gearswap.res.items[id]
    elseif ammo == "Old Arrow" or ammo:contains("古びた矢") then
        find_bag_type = gearswap.res.items[4196]
    else
        find_ammo_type = (gearswap.res.items:with('en', ammo) or gearswap.res.items:with('ja', ammo))
        ammo_name = (string.match(find_ammo_type.enl, '(.+) bolt') or string.match(find_ammo_type.enl, '(.+) arrow') or string.match(find_ammo_type.enl, '(.+) bullet'))
        if find_ammo_type then
            if find_ammo_type.en:contains('Bolt') then
                bag_type = 'bolt quiver'
            elseif find_ammo_type.en:contains('Arrow') then
                bag_type = 'quiver'
            elseif find_ammo_type.en:contains('Bullet') then
                bag_type = 'bullet pouch'
            end
        end
        find_bag_type = (gearswap.res.items:with('enl', ammo_name..' '..bag_type) or gearswap.res.items:with('enl', ammo_name..' bolt quiver') or gearswap.res.items:with('enl', ammo_name..' quiver') or gearswap.res.items:with('enl', ammo_name..' pouch') or gearswap.res.items:with('enl', "Oberon bullet pouch"))
    end
    if not find_bag_type then
        return false
    else
        return find_bag_type
    end
end
function ammo.precast(status,current_event,spell)
    if spell.english == "Ranged" and player.equipment.ammo ~= sets.range[range_types[range_types_count]].ammo then
        local ammo_bag = ammo.to_bag(sets.range[range_types[range_types_count]].ammo)[gearswap.language]
        if ammo_bag and player.inventory[ammo_bag] then
            equip(sets.ammo_empty) ammo.item_use = ammo_bag send_command('input /item "'..ammo_bag..'" <me>')
        else
            add_to_chat(cc.mc,"No Ammo Bag Found For "..sets.range[range_types[range_types_count]].ammo)
        end
        status.end_event = true
        status.end_spell = true
    end
end
function ammo.aftercast(status,current_event,spell)
    if spell.english == ammo.item_use then
        ammo.item_use = 'none'
    end
end