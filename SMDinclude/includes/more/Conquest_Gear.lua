conq_gear = {}
conq_gear.areas = {regions=S{"San d'Oria","Bastok","Windurst","Jeuno","Ronfaure","Zulkheim","Norvallen","Gustaberg","Derfland","Sarutabaruta","Kolshushu","Aragoneu",
                             "Fauregandi","Valdeaunia","Qufim","Li'Telor","Kuzotz","Vollbow","Elshimo Lowlands","Elshimo Uplands","Tu'Lia","Dynamis","Movalpolos",
                             "Tavnazian Marquisate","Tavnazian Archipelago","Promyvion","Lumoria","Limbus"},
                   always_ring=S{"San d'Oria","Bastok","Windurst","Jeuno","Dynamis","Lumoria"},
                   always_neck=S{"Dynamis","Promyvion","Lumoria","Limbus"},}
conq_gear.neck = {}
conq_gear.neck['case']={"Mage","Tank","Normal"}
conq_gear.neck.Mage="Rep.Gold Medal"
conq_gear.neck.Tank="Windurstian Scarf"
conq_gear.neck.Normal="Grand T.K. Collar"
conq_gear.ring = {}
conq_gear.ring['case']={"Mage","Tank","Normal"}
conq_gear.ring.Mage="Gnd.Kgt. Ring"
conq_gear.ring.Tank="Ptr.Prt. Ring"
conq_gear.ring.Normal="Gld.Msk. Ring"
   
function conq_gear.code(status,current_event)
    if has_any_buff_of(S{"Signet","Sanction","Sigil"}) then
        if world.conquest and conq_gear.areas.regions:contains(world.conquest.region_name) then
            local ring = gearswap.res.items:with('en', conq_gear.neck[conquest.neck.case[conquest.neck.case_id]])
            local neck = gearswap.res.items:with('en', conq_gear.ring[conquest.ring.case[conquest.ring.case_id]])
            if conq_gear.areas.always_neck:contains(world.conquest.region_name) and conq_gear.neck.change then
                sets.building[current_event] = set_combine(sets.building[current_event], {neck=neck[gearswap.language]})
            end
            if conq_gear.areas.always_ring:contains(world.conquest.region_name) and conquest.ring.change then
                sets.building[current_event] = set_combine(sets.building[current_event], {left_ring=ring[gearswap.language]})
            end
            if world.conquest.nation == player.nation then
                if conq_gear.ring.change then
                    sets.building[current_event] = set_combine(sets.building[current_event], {left_ring=ring[gearswap.language]})
                end
            else
                if conq_gear.neck.change then
                    sets.building[current_event] = set_combine(sets.building[current_event], {neck=neck[gearswap.language]})
                end
            end
        end
    end
end
conq_gear.precast = conq_gear.code
conq_gear.midcast = conq_gear.code
conq_gear.pet_midcast = conq_gear.code
conq_gear.aftercast = conq_gear.code
conq_gear.pet_aftercast = conq_gear.code
conq_gear.status_change = conq_gear.code
conq_gear.pet_status_change = conq_gear.code
conq_gear.sub_job_change = conq_gear.code
conq_gear.pet_change = conq_gear.code
conq_gear.indi_change = conq_gear.code
function conq_gear.self_command(status,current_event,command)
    if type(command) == 'table' then
        if command[1]:lower() == 'set' or command[1]:lower() == 's' then
            if command[2]:lower() == "cqneck" then
                for i,v in ipairs(conq_gear.neck.case) do
                    if v:lower() == command[3]:lower() then
                        conquest.neck.case_id = i
                        add_to_chat(cc.mc, ('Conquest Neck'):color(cc.y1,cc.mc)..' set to '..(conq_gear.neck.case[conquest.neck.case_id]):color(cc.b2))
                    end
                end
            elseif command[2]:lower() == "cqring" then
                for i,v in ipairs(conq_gear.ring.case) do
                    if v:lower() == command[3]:lower() then
                        conquest.ring.case_id = i
                        add_to_chat(cc.mc, ('Conquest Ring'):color(cc.y1,cc.mc)..' set to '..(conq_gear.ring.case[conquest.ring.case_id]):color(cc.b2))
                    end
                end
            end
        end
    else
        if command == "cconneck" then
            conquest.neck.case_id = (conquest.neck.case_id % #conq_gear.neck.case) + 1
            add_to_chat(cc.mc, ('Conquest Neck'):color(cc.y1,cc.mc)..' set to '..(conq_gear.neck.case[conquest.neck.case_id]):color(cc.b2))
        elseif command == "cconring" then
            conquest.ring.case_id = (conquest.ring.case_id % #conq_gear.ring.case) + 1
            add_to_chat(cc.mc, ('Conquest Ring'):color(cc.y1,cc.mc)..' set to '..(conq_gear.ring.case[conquest.ring.case_id]):color(cc.b2))
        elseif command == 'tconneckchange' then
            conquest.neck.change = not conquest.neck.change
            add_to_chat(cc.mc, 'Auto Conquest Neck Change '..(conquest.neck.change and ('Enabled'):color(cc.g1) or ('Disabled'):color(cc.r1)))
        elseif command == 'tconringchange' then
            conquest.ring.change = not conquest.ring.change
            add_to_chat(cc.mc, 'Auto Conquest Ring Change '..(conquest.ring.change and ('Enabled'):color(cc.g1) or ('Disabled'):color(cc.r1)))
        end
    end
end