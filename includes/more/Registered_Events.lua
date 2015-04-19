packets = require('packets')
registered_events = {}
registered_events.skill = {}
registered_events.atacking_mobs = {player=T{},party=T{},alliance=T{},pet=T{}}
registered_events.treasure_hunter = {}
registered_events.skill_type = {'Axe','Club','Dagger','Great Axe','Great Katana','Great Sword','Hand-to-Hand','Katana','Polearm','Scythe','Staff','Sword','Archery','Marksmanship',
        'Throwing','Evasion','Guard','Parrying','Shield','Blue Magic','Dark Magic','Divine Magic','Elemental Magic','Enfeebling Magic','Enhancing Magic',
        'Geomancy','Handbell','Healing Magic','Ninjutsu','Singing','Stringed Instrument','Summoning Magic','Wind Instrument','Automaton Archery','Automaton Magic','Automaton Melee'}
if not skill_count then skill_count = 1 end
function registered_events.clear_aggro_count()
    registered_events.atacking_mobs.player:clear()
    registered_events.atacking_mobs.party:clear()
    registered_events.atacking_mobs.alliance:clear()
end

-- added events--
function registered_events.zone_change(new_id,old_id) --zone change event
    registered_events.clear_aggro_count()
    local new = res.zones[new_id].name
    local old = res.zones[old_id].name
    coroutine.sleep(4)
    if mf_zone_change then
        mf_zone_change(new,old)
    end
end
registered_events.zone_change_id = windower.raw_register_event('zone change', registered_events.zone_change)
function registered_events.level_change() --updates display when player lvls up/down
    if updatedisplay then
        coroutine.schedule(updatedisplay, 3)
    end
end
registered_events.level_up_id = windower.raw_register_event('level up', registered_events.level_change)
registered_events.level_down_id = windower.raw_register_event('level down', registered_events.level_change)
function registered_events.party_id_check(id) --checks to see if sent id is a party/alliance member
    for pt_num,pt in ipairs(alliance) do
        if type(pt) == 'table' then
            for pos,party_position in ipairs(pt) do
                if party_position.mob.id == id then
                    return true,pt_num
                end
            end
        end
    end
    if pet.isvalid and pet.id == id then
        return true,4
    end
    return false
end
function registered_events.remove_add_agro(id,add_to) --adds/removes mobs from aggro list
    local remove_type = {alliance={'party','player','pet'},party={'alliance','player','pet'},player={'alliance','party','pet'},pet={'alliance','party','player'}}
    if add_to and registered_events.atacking_mobs[add_to] then
        registered_events.atacking_mobs[add_to][id] = true
        for i,v in pairs(remove_type[add_to]) do
            if registered_events.atacking_mobs[v][id] then
                registered_events.atacking_mobs[v][id] = nil
            end
        end
    else
        for i,v in pairs(registered_events.atacking_mobs) do
            if registered_events.atacking_mobs[i][id] then
                registered_events.atacking_mobs[i][id] = nil
            end
        end
    end
end
function registered_events.attacker_count(a) --gets count for aggro
    if a and S{'alliance','party','player','pet'}:contains(a:lower()) then
        return registered_events.atacking_mobs[a:lower()]:length()
    else
        return (registered_events.atacking_mobs.player:length() + registered_events.atacking_mobs.party:length() + 
            registered_events.atacking_mobs.alliance:length() + registered_events.atacking_mobs.pet:length())
    end
end
function registered_events.incoming_chunk(id, data, modified, injected, blocked)
    local triggered = false
    if id == 0x029 then
        local packet = packets.parse('incoming', data)
        if S{6,20,97,113,406,605,646}:contains(packet['Message']) then --removes mobs/th in aggro/th list
            registered_events.remove_add_agro(packet['Target'])
            if registered_events.treasure_hunter[packet['Target']] then
                registered_events.treasure_hunter[packet['Target']] = nil
            end
            triggered = true
        elseif S{603,608}:contains(packet['Message']) and player.id == packet['Actor'] then
            --treasure hunter counter
            registered_events.treasure_hunter[packet['Target']] = packet['Param 1']
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
        local target_in_party,pt_num = registered_events.party_id_check(packet['Target 1 ID'])
        local actor_in_party = registered_events.party_id_check(packet['Actor'])
        if target_in_party and not actor_in_party then --adds mobs to aggro list
            local apply_where = ''
            if S{2,3}:contains(pt_num) then
                apply_where = 'alliance'
            elseif pt_num == 1 then
                if player.id == packet['Target 1 ID'] then
                    apply_where = 'player'
                else
                    apply_where = 'party'
                end
            elseif pt_num == 4 then
                apply_where = 'pet'
            end
            registered_events.remove_add_agro(packet['Actor'],apply_where)
            triggered = true
        elseif player.id == packet['Actor'] and player.target.id == packet['Target 1 ID'] and not target_in_party then --adds mobs that player attacks
            registered_events.remove_add_agro(player.target.id,'player')
            triggered = true
        elseif not (target_in_party or actor_in_party) then --removes mobs that attack a target out of party/alliance
            registered_events.remove_add_agro(packet['Actor'])
            triggered = true
        end
    elseif id == 0x062 and skillwatch then --grabs data for skillup watch
        local packet = packets.parse('incoming', data)
        for i,v in pairs(packet) do
            if not i:wmatch('_*|Unknown*|(N/A)*|Automaton*') then
                registered_events.skill[i] = v
            end
        end
        triggered = true
    elseif id == 0x044 and skillwatch then --grabs data for skillup watch(pup)
        local packet = packets.parse('incoming', data)
        if data:sub(5,5):byte() == 0x12 then
            if packet['Current Melee Skill'] == packet['Max Melee Skill'] then
                registered_events.skill['Automaton Melee Capped'] = true
            else
                registered_events.skill['Automaton Melee Capped'] = false
            end
            if packet['Current Ranged Skill'] == packet['Max Ranged Skill'] then
                registered_events.skill['Automaton Archery Capped'] = true
            else
                registered_events.skill['Automaton Archery Capped'] = false
            end
            if packet['Current Magic Skill'] == packet['Max Magic Skill'] then
                registered_events.skill['Automaton Magic Capped'] = true
            else
                registered_events.skill['Automaton Magic Capped'] = false
            end
            registered_events.skill['Automaton Melee Level'] = packet['Current Melee Skill']
            registered_events.skill['Automaton Archery Level'] = packet['Current Ranged Skill']
            registered_events.skill['Automaton Magic Level'] = packet['Current Magic Skill']
            triggered = true
        end
    end
    if triggered and updatedisplay then
        updatedisplay()
        triggered = false
    end
end
registered_events.incoming_chunk_id = windower.raw_register_event('incoming chunk', registered_events.incoming_chunk)