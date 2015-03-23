Conquest_Gear_areas = {
    regions=S{"San d'Oria","Bastok","Windurst","Jeuno","Ronfaure","Zulkheim","Norvallen","Gustaberg","Derfland","Sarutabaruta","Kolshushu","Aragoneu",
                    "Fauregandi","Valdeaunia","Qufim","Li'Telor","Kuzotz","Vollbow","Elshimo Lowlands","Elshimo Uplands","Tu'Lia","Dynamis","Movalpolos",
                    "Tavnazian Marquisate","Tavnazian Archipelago","Promyvion","Lumoria","Limbus"},
    always_ring=S{"San d'Oria","Bastok","Windurst","Jeuno","Dynamis","Lumoria"},
    always_neck=S{"Dynamis","Promyvion","Lumoria","Limbus"},}
    
Conquest_neck['case']={"Mage","Tank","Normal"}
Conquest_neck.Mage={neck="Rep.Gold Medal"}
Conquest_neck.Tank={neck="Windurstian Scarf"}
Conquest_neck.Normal={neck="Grand T.K. Collar"}
Conquest_ring['case']={"Mage","Tank","Normal"}
Conquest_ring.Mage={left_ring="Gnd.Kgt. Ring"}
Conquest_ring.Tank={left_ring="Ptr.Prt. Ring"}
Conquest_ring.Normal={left_ring="Gld.Msk. Ring"}
        
if not Conquest_neck.change then
    Conquest_neck.change = false
end
if not Conquest_neck.case_id then
    Conquest_neck.case_id = 1
end
if not Conquest_ring.change then
    Conquest_ring.change = false
end
if not Conquest_ring.case_id then
    Conquest_ring.case_id = 1
end
    
function Conquest_Gear_code(status,set_gear)
    if has_any_buff_of(S{"Signet","Sanction","Sigil"}) then
        if world.conquest and Conquest_Gear_areas.regions:contains(world.conquest.region_name) then
            if Conquest_Gear_areas.always_neck:contains(world.conquest.region_name) and Conquest_neck.change then
                set_gear = set_combine(set_gear, Conquest_neck[Conquest_neck.case[Conquest_neck.case_id]])
            end
            if Conquest_Gear_areas.always_ring:contains(world.conquest.region_name) and Conquest_ring.change then
                set_gear = set_combine(set_gear, Conquest_ring[Conquest_ring.case[Conquest_ring.case_id]])
            end
            if world.conquest.nation == player.nation then
                if Conquest_ring.change then
                    set_gear = set_combine(set_gear, Conquest_ringg[Conquest_ring.case[Conquest_ring.ring.case_id]])
                end
            else
                if Conquest_neck.change then
                    set_gear = set_combine(set_gear, Conquest_neck[Conquest_neck.case[Conquest_neck.case_id]])
                end
            end
        end
    end
    return set_gear
end
Conquest_Gear_precast = Conquest_Gear_code
Conquest_Gear_midcast = Conquest_Gear_code
Conquest_Gear_pet_midcast = Conquest_Gear_code
Conquest_Gear_aftercast = Conquest_Gear_code
Conquest_Gear_pet_aftercast = Conquest_Gear_code
Conquest_Gear_status_change = Conquest_Gear_code
Conquest_Gear_pet_status_change = Conquest_Gear_code
Conquest_Gear_sub_job_change = Conquest_Gear_code
Conquest_Gear_pet_change = Conquest_Gear_code
Conquest_Gear_indi_change = Conquest_Gear_code
function Conquest_Gear_self_command(status,set_gear,command)
    if type(command) == 'table' then
        if command[1]:lower() == 'set' or command[1]:lower() == 's' then
            if command[2]:lower() == "cqneck" then
                for i,v in ipairs(Conquest_neck.case) do
                    if v:lower() == command[3]:lower() then
                        Conquest_neck.case_id = i
                    end
                end
            elseif command[2]:lower(Conquest_ring.case) == "cqring" then
                for i,v in ipairs() do
                    if v:lower() == command[3]:lower() then
                        Conquest_ring.case_id = i
                    end
                end
            end
        end
    else
        if command == "cconneck" then
            Conquest_neck.case_id = (Conquest_neck.case_id % #Conquest_neck.case) + 1
        elseif command == "cconring" then
            Conquest_ring.case_id = (Conquest_ring.case_id % #Conquest_ring.case) + 1
        elseif command == 'tconneckchange' then
            Conquest_neck.change = not Conquest_neck.change
        elseif command == 'tconringchange' then
            Conquest_ring.change = not Conquest_ring.change
        end
    end
end