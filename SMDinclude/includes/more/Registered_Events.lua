reg_event = {atacking_mobs = {player=T{},party=T{},alliance=T{},pet=T{}},treasure_hunter={},mb_timer=1}
reg_event.skill_type = T{}
reg_event.job_skills=T{[1]=S{1,2,6,13,18,19},[2]=S{1,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21},[3]=S{1,5,6,7,8,9,10,11,12,13,14,17,19,22},[4]=S{1,7,8,22},
    [5]=S{1,8,9,11,22},[6]=S{1,8,22},[7]=S{1,4,8,9},[8]=S{1,7,12,14},[9]=S{13},[10]=S{12,13},[11]=S{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,20,21,22},
    [12]=S{1,2,3,4,5,7,10,11,14,15,20,21},[22]=S{18},[23]=S{18},[24]=S{18},[25]=S{1,5,6,11,12,13},[26]=S{1,6,8,11,13,17},[27]=S{1,2,3,4,5,6,10,11,12,13,17,18,19,20},
    [28]=S{2,18},[29]=S{"All"},[30]=S{1,3,5,6,7,9},[31]=S{1,2,5,6,7,8,9,10,12,13,14,16,17,18,19,20,21,22},[32]=S{3,5,7,20,22},[33]=S{3,5,7,20},[34]=S{3,4,5,20,22},
    [35]=S{3,4,5,20,21},[36]=S{4,5,8,20,21},[37]=S{4,5,8,21},[38]=S{15},[39]=S{13},[40]=S{10},[41]=S{10},[42]=S{10},[43]=S{16},[44]=S{21},[45]=S{21},[48]=S{"All"},
    [49]=S{"All"},[50]=S{"All"},[51]=S{"All"},[52]=S{"All"},[53]=S{"All"},[54]=S{"All"},[55]=S{"All"},[56]=S{"All"},[57]=S{"All"},}
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
    if add_to and remove_type[add_to] then
        reg_event.atacking_mobs[add_to]:append(id)
        for i,v in ipairs(remove_type[add_to]) do
            if reg_event.atacking_mobs[v]:contains(id) then
                reg_event.atacking_mobs[v]:delete(id)
                return true
            end
        end
    else
        for i,v in pairs(reg_event.atacking_mobs) do
            if reg_event.atacking_mobs[i]:contains(id) then
                reg_event.atacking_mobs[i]:delete(id)
                return true
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
    local new_zone = zones[new_id].name
    coroutine.schedule(gearswap.equip_sets:prepare('zone_change',nil,new_zone,zones[old_id].name,cities:contains(new_zone)),(Zone_change_delay or 5))
end
reg_event.zone_change_id = windower.raw_register_event('zone change', reg_event.zone_change)
function reg_event.incoming_chunk(id, data, modified, injected, blocked)
    local triggered = false
    if id == 0x029 then
        local message,target,param = data:unpack('H',0x19),data:unpack('I',0x09),data:unpack('I',0x0D)
        if S{6,20,97,113,406,605,646}:contains(message) then --removes mobs/th in aggro/th list
            local removed = reg_event.remove_add_agro(target)
            if reg_event.treasure_hunter[target] then
                reg_event.treasure_hunter[target] = nil
            end
            triggered = true
            if triggered and removed then
                local player = reg_event.atacking_mobs.player:length()
                local party = reg_event.atacking_mobs.party:length()
                local alliance = reg_event.atacking_mobs.alliance:length()
                local pet = reg_event.atacking_mobs.pet:length()
                local total = reg_event.attacker_count()
                gearswap.equip_sets('aggro_change',nil,player,party,alliance,pet,total)
            end
        elseif S{603,608}:contains(message) and player.id == data:unpack('I',0x05) then --treasure hunter counter
            local target_tbl = windower.ffxi.get_mob_by_id(target)
            local gain = (reg_event.treasure_hunter[target] and false or true)
            local th_count = param
            reg_event.treasure_hunter[target] = param
            gearswap.equip_sets('treasure_hunter_change',nil,gain,th_count,target_tbl.name,target_tbl)
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
            if not reg_event.atacking_mobs[apply_where]:contains(actor) then
                reg_event.remove_add_agro(actor,apply_where)
                triggered = true
            end
        elseif player.id == actor and player.target.id == target and not target_in_party then --adds mobs that player attacks
            if not reg_event.atacking_mobs['player']:contains(player.target.id) then
                reg_event.remove_add_agro(player.target.id,'player')
                triggered = true
            end
        elseif not (target_in_party or actor_in_party) then --removes mobs that attack a target out of party/alliance
            local removed = reg_event.remove_add_agro(actor)
            if removed then
                triggered = true
            end
        end
        if triggered then
            local player = reg_event.atacking_mobs.player:length()
            local party = reg_event.atacking_mobs.party:length()
            local alliance = reg_event.atacking_mobs.alliance:length()
            local pet = reg_event.atacking_mobs.pet:length()
            local total = reg_event.attacker_count()
            gearswap.equip_sets('aggro_change',nil,player,party,alliance,pet,total)
        end
    elseif id == 0x062 and skillwatch then --updates display for skillup watch
        triggered = true
    elseif id == 0x044 and skillwatch then --updates display for skillup watch(pup)
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