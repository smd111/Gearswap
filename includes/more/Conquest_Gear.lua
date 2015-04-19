conquest_gear = {}
conquest_gear.areas = {
    regions=S{"San d'Oria","Bastok","Windurst","Jeuno","Ronfaure","Zulkheim","Norvallen","Gustaberg","Derfland","Sarutabaruta","Kolshushu","Aragoneu",
            "Fauregandi","Valdeaunia","Qufim","Li'Telor","Kuzotz","Vollbow","Elshimo Lowlands","Elshimo Uplands","Tu'Lia","Dynamis","Movalpolos",
            "Tavnazian Marquisate","Tavnazian Archipelago","Promyvion","Lumoria","Limbus"},
    always_ring=S{"San d'Oria","Bastok","Windurst","Jeuno","Dynamis","Lumoria"},
    always_neck=S{"Dynamis","Promyvion","Lumoria","Limbus"},}
conquest_gear.neck = {}
conquest_gear.neck['case']={"Mage","Tank","Normal"}
conquest_gear.neck.Mage="Rep.Gold Medal"
conquest_gear.neck.Tank="Windurstian Scarf"
conquest_gear.neck.Normal="Grand T.K. Collar"
conquest_gear.ring = {}
conquest_gear.ring['case']={"Mage","Tank","Normal"}
conquest_gear.ring.Mage="Gnd.Kgt. Ring"
conquest_gear.ring.Tank="Ptr.Prt. Ring"
conquest_gear.ring.Normal="Gld.Msk. Ring"
if not conquest.neck.change then
    conquest.neck.change = false
end
if not conquest.neck.case_id then
    conquest.neck.case_id = 1
end
if not conquest.ring.change then
    conquest.ring.change = false
end
if not conquest.ring.case_id then
    conquest.ring.case_id = 1
end
    
function conquest_gear.code(status,current_event)
    if has_any_buff_of(S{"Signet","Sanction","Sigil"}) then
        if world.conquest and conquest_gear.areas.regions:contains(world.conquest.region_name) then
            local ring = res.items:with('en', conquest_gear.neck[conquest.neck.case[conquest.neck.case_id]])
            local neck = res.items:with('en', conquest_gear.ring[conquest.ring.case[conquest.ring.case_id]])
            if conquest_gear.areas.always_neck:contains(world.conquest.region_name) and conquest_gear.neck.change then
                sets.building[current_event] = set_combine(sets.building[current_event], {neck=neck[gearswap.language]})
            end
            if conquest_gear.areas.always_ring:contains(world.conquest.region_name) and conquest.ring.change then
                sets.building[current_event] = set_combine(sets.building[current_event], {left_ring=ring[gearswap.language]})
            end
            if world.conquest.nation == player.nation then
                if conquest_gear.ring.change then
                    sets.building[current_event] = set_combine(sets.building[current_event], {left_ring=ring[gearswap.language]})
                end
            else
                if conquest_gear.neck.change then
                    sets.building[current_event] = set_combine(sets.building[current_event], {neck=neck[gearswap.language]})
                end
            end
        end
    end
end
conquest_gear.precast = conquest_gear.code
conquest_gear.midcast = conquest_gear.code
conquest_gear.pet_midcast = conquest_gear.code
conquest_gear.aftercast = conquest_gear.code
conquest_gear.pet_aftercast = conquest_gear.code
conquest_gear.status_change = conquest_gear.code
conquest_gear.pet_status_change = conquest_gear.code
conquest_gear.sub_job_change = conquest_gear.code
conquest_gear.pet_change = conquest_gear.code
conquest_gear.indi_change = conquest_gear.code
function conquest_gear.self_command(status,current_event,command)
    if type(command) == 'table' then
        if command[1]:lower() == 'set' or command[1]:lower() == 's' then
            if command[2]:lower() == "cqneck" then
                for i,v in ipairs(conquest_gear.neck.case) do
                    if v:lower() == command[3]:lower() then
                        conquest.neck.case_id = i
                    end
                end
            elseif command[2]:lower() == "cqring" then
                for i,v in ipairs(conquest_gear.ring.case) do
                    if v:lower() == command[3]:lower() then
                        conquest.ring.case_id = i
                    end
                end
            end
        end
    else
        if command == "cconneck" then
            conquest.neck.case_id = (conquest.neck.case_id % #conquest.neck.case) + 1
        elseif command == "cconring" then
            conquest.ring.case_id = (conquest.ring.case_id % #conquest.ring.case) + 1
        elseif command == 'tconneckchange' then
            conquest.neck.change = not conquest.neck.change
        elseif command == 'tconringchange' then
            conquest.ring.change = not conquest.ring.change
        end
    end
end