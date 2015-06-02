packets = require('packets')
reg_event = {}
reg_event.skill = {}
reg_event.atacking_mobs = {player=T{},party=T{},alliance=T{},pet=T{}}
reg_event.treasure_hunter = {}
reg_event.skill_type = {'Axe','Club','Dagger','Great Axe','Great Katana','Great Sword','Hand-to-Hand','Katana','Polearm','Scythe','Staff','Sword','Archery','Marksmanship','Throwing','Evasion','Guard','Parrying','Shield','Blue Magic','Dark Magic','Divine Magic','Elemental Magic','Enfeebling Magic','Enhancing Magic','Geomancy','Handbell','Healing Magic','Ninjutsu','Singing','Stringed Instrument','Summoning Magic','Wind Instrument','Automaton Archery','Automaton Magic','Automaton Melee'}
function reg_event.clear_aggro_count() 
    reg_event.atacking_mobs.player:clear() reg_event.atacking_mobs.party:clear() reg_event.atacking_mobs.alliance:clear() reg_event.atacking_mobs.pet:clear()
end
function reg_event.party_id_check(id) --checks to see if sent id is a party/alliance member
    for pt_num,pt in ipairs(alliance) do if type(pt) == 'table' then for pos,party_position in ipairs(pt) do if party_position.mob.id == id then return true,pt_num end end end end
    if pet.isvalid and pet.id == id then return true,4 end
    return false
end
function reg_event.remove_add_agro(id,add_to) --adds/removes mobs from aggro list
    local remove_type = {alliance={'party','player','pet'},party={'alliance','player','pet'},player={'alliance','party','pet'},pet={'alliance','party','player'}}
    if add_to and reg_event.atacking_mobs[add_to] then
        reg_event.atacking_mobs[add_to][id] = true
        for i,v in ipairs(remove_type[add_to]) do if reg_event.atacking_mobs[v][id] then reg_event.atacking_mobs[v][id] = nil end end
    else
        for i,v in pairs(reg_event.atacking_mobs) do if reg_event.atacking_mobs[i][id] then reg_event.atacking_mobs[i][id] = nil end end
    end
end
function reg_event.attacker_count(a) --gets count for aggro
    if a and S{'alliance','party','player','pet'}:contains(a:lower()) then
        return reg_event.atacking_mobs[a:lower()]:length()
    else
        return (reg_event.atacking_mobs.player:length() + reg_event.atacking_mobs.party:length() + reg_event.atacking_mobs.alliance:length() + reg_event.atacking_mobs.pet:length())
    end
end
-- added events--
function reg_event.zone_change(new_id,old_id) --zone change event
    reg_event.clear_aggro_count() local zones = res.zones local new = zones[new_id].name local old = zones[old_id].name coroutine.sleep(4) if mf.zone_change then mf.zone_change(new,old) end
end
reg_event.zone_change_id = windower.raw_register_event('zone change', reg_event.zone_change)
function reg_event.level_change() --updates display when player lvls up/down
    if updatedisplay then coroutine.schedule(updatedisplay, 3) end
end
reg_event.level_up_id = windower.raw_register_event('level up', reg_event.level_change)
reg_event.level_down_id = windower.raw_register_event('level down', reg_event.level_change)
function reg_event.incoming_chunk(id, data, modified, injected, blocked)
    local triggered = false
    if id == 0x029 then
        local packet = packets.parse('incoming', data)
        if S{6,20,97,113,406,605,646}:contains(packet['Message']) then --removes mobs/th in aggro/th list
            reg_event.remove_add_agro(packet['Target'])
            if reg_event.treasure_hunter[packet['Target']] then reg_event.treasure_hunter[packet['Target']] = nil end
            triggered = true
        elseif S{603,608}:contains(packet['Message']) and player.id == packet['Actor'] then --treasure hunter counter
            reg_event.treasure_hunter[packet['Target']] = packet['Param 1']
            -- print(packet['Param 1'])
            if mf_treasure_hunter_change then
                local name = windower.ffxi.get_mob_by_id(packet['Target']).name
                local gain = (packet['Param 1'] < reasure_hunter[packet['Target']] and false or true)
                local th_count = packet['Param 1']
                mf_treasure_hunter_change(gain,th_count,name)
            end
        end
    elseif id == 0x028 then
        local packet = packets.parse('incoming', data)
        local target_in_party,pt_num = reg_event.party_id_check(packet['Target 1 ID']) local actor_in_party = reg_event.party_id_check(packet['Actor'])
        if target_in_party and not actor_in_party then --adds mobs to aggro list
            local apply_where
            if S{2,3}:contains(pt_num) then apply_where = 'alliance' elseif pt_num == 1 then if player.id == packet['Target 1 ID'] then apply_where = 'player' else apply_where = 'party' end elseif pt_num == 4 then apply_where = 'pet' end
            reg_event.remove_add_agro(packet['Actor'],apply_where) triggered = true
        elseif player.id == packet['Actor'] and player.target.id == packet['Target 1 ID'] and not target_in_party then --adds mobs that player attacks
            reg_event.remove_add_agro(player.target.id,'player') triggered = true
        elseif not (target_in_party or actor_in_party) then --removes mobs that attack a target out of party/alliance
            reg_event.remove_add_agro(packet['Actor']) triggered = true
        end
    elseif id == 0x062 then --grabs data for skillup watch
        local packet = packets.parse('incoming', data) for i,v in pairs(packet) do if not i:wmatch('_*|Unknown*|(N/A)*|Automaton*') then reg_event.skill[i] = v end end
        triggered = true
    elseif id == 0x044 and skillwatch then --grabs data for skillup watch(pup)
        local packet = packets.parse('incoming', data)
        if packet['Job'] == 0x12 then
            local auto_skill ={[1]={'Current Melee Skill','Max Melee Skill','Automaton Melee Capped','Automaton Melee Level'},[2]={'Current Ranged Skill','Max Ranged Skill','Automaton Archery Capped','Automaton Archery Level'},[3]={'Current Magic Skill','Max Magic Skill','Automaton Magic Capped','Automaton Magic Level'}}
            for _,v in ipairs(auto_skill) do if packet[v[1]] == packet[v[2]] then reg_event.skill[v[3]] = true else reg_event.skill[v[3]] = false end reg_event.skill[v[4]] = packet[v[1]] end
            triggered = true
        end
    elseif id == 0x00A then
        local packet = packets.parse('incoming', data)
        if packet['Player'] == player.id then
            Player['STR'] = packet['STR'] Player['DEX'] = packet['DEX'] Player['VIT'] = packet['VIT'] Player['AGI'] = packet['AGI'] Player['INT'] = packet['INT']
            Player['MND'] = packet['MND'] Player['CHR'] = packet['CHR'] Player['STR+'] = packet['STR Bonus'] Player['DEX+'] = packet['DEX Bonus']
            Player['VIT+'] = packet['VIT Bonus'] Player['AGI+'] = packet['AGI Bonus'] Player['INT+'] = packet['INT Bonus'] Player['MND+'] = packet['MND Bonus']
            Player['CHR+'] = packet['CHR Bonus']
        end
    --0x061--
    elseif id == 0x061 then
        local packet = packets.parse('incoming', data)
        Player['STR'] = packet['Base STR'] Player['DEX'] = packet['Base DEX'] Player['VIT'] = packet['Base VIT'] Player['AGI'] = packet['Base AGI']
        Player['INT'] = packet['Base INT'] Player['MND'] = packet['Base MND'] Player['CHR'] = packet['Base CHR'] Player['STR+'] = packet['Added STR']
        Player['DEX+'] = packet['Added DEX'] Player['VIT+'] = packet['Added VIT'] Player['AGI+'] = packet['Added AGI'] Player['INT+'] = packet['Added INT']
        Player['MND+'] = packet['Added MND'] Player['CHR+'] = packet['Added CHR']
        -- Player['Attack'] = packet['Attack']
        -- Player['Defence'] = packet['Defence']
        -- Player['Fire Resistance'] = packet['Fire Resistance']
        -- Player['Wind Resistance'] = packet['Wind Resistance']
        -- Player['Lightning Resistance'] = packet['Lightning Resistance']
        -- Player['Light Resistance'] = packet['Light Resistance']
        -- Player['Ice Resistance'] = packet['Ice Resistance']
        -- Player['Earth Resistance'] = packet['Earth Resistance']
        -- Player['Water Resistance'] = packet['Water Resistance']
        -- Player['Dark Resistance'] = packet['Dark Resistance']
    end
    if triggered and updatedisplay then updatedisplay() triggered = false end
end
reg_event.incoming_chunk_id = windower.raw_register_event('incoming chunk', reg_event.incoming_chunk)
-- reg_event.outgoing_chunk_id = windower.raw_register_event('outgoing chunk', function (id, data, modified, injected, blocked)
    -- if id == 0x037 then
        -- local packet = packets.parse('outgoing', data)
        -- local item = windower.ffxi.get_items(packet['Bag'],packet['Slot'])
        -- if S{605,1020,1021,6002,6003,6004,6005,6006,6007}:contains(item.id) then
            -- if buffactive.invisible then
                -- send_command('cancel Invisible')
            -- end
            -- equip(sets.helm)
        -- end
    -- end
-- end)