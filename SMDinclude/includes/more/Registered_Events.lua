reg_event = {atacking_mobs = {player=T{},party=T{},alliance=T{},pet=T{}},treasure_hunter = {},mb_timer = 1}
reg_event.skill_type = T{"axe","club","dagger","great_axe","great_sword","great_katana","hand_to_hand","katana","polearm","scythe","staff","sword","archery","evasion",
                        "guard","marksmanship","parrying","shield","throwing","blue_magic","dark_magic","divine_magic","elemental_magic","enfeebling_magic",
                        "enhancing_magic","geomancy","healing_magic","handbell","ninjutsu","singing","stringed_instrument","summoning_magic","wind_instrument","alchemy",
                        "bonecraft","clothcraft","cooking","fishing","goldsmithing","leathercraft","smithing","synergy","woodworking"}
if player.main_job == "PUP" or player.sub_job == "PUP" then
    reg_event.skill_type:append('automaton_melee_level')
    reg_event.skill_type:append('automaton_archery_level')
    reg_event.skill_type:append('automaton_magic_level')
end
function reg_event.clear_aggro_count() 
    reg_event.atacking_mobs.player:clear()
    reg_event.atacking_mobs.party:clear()
    reg_event.atacking_mobs.alliance:clear()
    reg_event.atacking_mobs.pet:clear()
end
function reg_event.party_id_check(id) --checks to see if sent id is a party/alliance member
    for pt_num,pt in ipairs(alliance) do
        if type(pt) == 'table' then
            for pos,party_position in ipairs(pt) do
                if party_position.mob and party_position.mob.id == id then
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
function reg_event.remove_add_agro(id,add_to) --adds/removes mobs from aggro list
    local remove_type = {alliance={'party','player','pet'},party={'alliance','player','pet'},player={'alliance','party','pet'},pet={'alliance','party','player'}}
    if add_to and reg_event.atacking_mobs[add_to] then
        reg_event.atacking_mobs[add_to][id] = true
        for i,v in ipairs(remove_type[add_to]) do
            if reg_event.atacking_mobs[v][id] then
                reg_event.atacking_mobs[v][id] = nil
            end
        end
    else
        for i,v in pairs(reg_event.atacking_mobs) do
            if reg_event.atacking_mobs[i][id] then
                reg_event.atacking_mobs[i][id] = nil
            end
        end
    end
end
function reg_event.attacker_count(a) --gets count for aggro
    if a and S{'alliance','party','player','pet'}:contains(a:lower()) then
        return reg_event.atacking_mobs[a:lower()]:length()
    else
        return (reg_event.atacking_mobs.player:length() + reg_event.atacking_mobs.party:length() + reg_event.atacking_mobs.alliance:length() +
            reg_event.atacking_mobs.pet:length())
    end
end
-- added events--
function reg_event.zone_change(new_id,old_id) --zone change event
    reg_event.clear_aggro_count()
    local zones = gearswap.res.zones
    local new = zones[new_id].name
    local old = zones[old_id].name
    if mf.zone_change then
        mf.zone_change(new,old)
    end
end
reg_event.zone_change_id = windower.raw_register_event('zone change', reg_event.zone_change)
function reg_event.level_change() --updates display when player lvls up/down
    if updatedisplay then
        updatedisplay:schedule(3)
    end
end
reg_event.level_up_id = windower.raw_register_event('level up', reg_event.level_change)
reg_event.level_down_id = windower.raw_register_event('level down', reg_event.level_change)
function reg_event.incoming_chunk(id, data, modified, injected, blocked)
    local triggered = false
    if id == 0x029 then
        local message,target,param = data:unpack('H',0x19),data:unpack('I',0x09),data:unpack('I',0x0D)
        if S{6,20,97,113,406,605,646}:contains(message) then --removes mobs/th in aggro/th list
            reg_event.remove_add_agro(target)
            if reg_event.treasure_hunter[target] then
                reg_event.treasure_hunter[target] = nil
            end
            triggered = true
        elseif S{603,608}:contains(message) and player.id == data:unpack('I',0x05) then --treasure hunter counter
            reg_event.treasure_hunter[target] = param
            if mf.treasure_hunter_change then
                local name = windower.ffxi.get_mob_by_id(target).name
                local gain = (param < reasure_hunter[target] and false or true)
                local th_count = param mf.treasure_hunter_change(gain,th_count,name)
            end
        end
    elseif id == 0x028 then
        local a,target = data:unpack('b6b32', 19)
        local actor = data:unpack('I',0x06)
        local target_in_party,pt_num = reg_event.party_id_check(target)
        local actor_in_party,num = reg_event.party_id_check(actor)
        if target_in_party and not actor_in_party then --adds mobs to aggro list
            local apply_where
            if S{2,3}:contains(pt_num) then
                apply_where = 'alliance'
            elseif pt_num == 1 then
                if player.id == target then
                    apply_where = 'player'
                else
                    apply_where = 'party'
                end
            elseif pt_num == 4 then
                apply_where = 'pet'
            end
            reg_event.remove_add_agro(actor,apply_where)
            triggered = true
        elseif player.id == actor and player.target.id == target and not target_in_party then --adds mobs that player attacks
            reg_event.remove_add_agro(player.target.id,'player')
            triggered = true
        elseif not (target_in_party or actor_in_party) then --removes mobs that attack a target out of party/alliance
            reg_event.remove_add_agro(actor)
            triggered = true
        end
    elseif id == 0x062 then
        triggered = true
    elseif id == 0x044 and skillwatch then --grabs data for skillup watch(pup)
        if data:unpack('C',0x05) == 0x12 then
            triggered = true
        end
    end
    if triggered and updatedisplay and loaded then
        updatedisplay()
        triggered = false
    end
end
reg_event.incoming_chunk_id = windower.raw_register_event('incoming chunk', reg_event.incoming_chunk)