Conquest = {
    always=S{"Al'Taieu","Auroral Updraft","Empyreal Paradox","The Garden of Ru'Hmet","Grand Palace of Hu'Xzoi","Dynamis - Windurst","Dynamis - San d'Oria",
        "Dynamis - Bastok","Dynamis - Jeuno","Dynamis - Beaucedine","Dynamis - Xarcabard","Dynamis - Valkurm","Dynamis - Buburimu","Dynamis - Qufim","Dynamis - Tavnazia",
        "Apollyon","Temenos","Hall of Transference","Memory Flux","Promyvion - Dem","Promyvion - Holla","Promyvion - Mea","Promyvion - Vahzl","Spire of Dem",
        "Spire of Holla","Spire of Mea","Spire of Vahzl"},
    never=S{"Abyssea - La Theine","Abyssea - Konschtat","Abyssea - Tahrongi","Abyssea - Attohwa","Abyssea - Misareaux","Abyssea - Vunkerl","Abyssea - Altepa",
        "Abyssea - Uleguerand","Abyssea - Grauberg","Abyssea - Empyreal Paradox","Southern San d'Oria [S]","East Ronfaure [S]","Jugner Forest [S]",
        "Vunkerl Inlet [S]","Batallia Downs [S]","La Vaule [S]","Bastok Markets [S]","North Gustaberg [S]","Grauberg [S]","Pashhow Marshlands [S]",
        "Rolanberry Fields [S]","Beadeaux [S]","Windurst Waters [S]","West Sarutabaruta [S]","Fort Karugo-Narugo [S]","Meriphataud Mountains [S]",
        "Sauromugue Champaign [S]","Castle Oztroja [S]","Beaucedine Glacier [S]","Xarcabard [S]","Castle Zvahl Baileys [S]","Castle Zvahl Keep [S]","Throne Room [S]",
        "Garlaige Citadel [S]","Crawlers' Nest [S]","The Eldieme Necropolis [S]","Ruhotz Silvermines","Everbloom Hollow","Provenance","Walk of Echoes",
        "Open sea route to Al Zahbi","Open sea route to Mhaura","Al Zahbi","Aht Urhgan Whitegate","Wajaom Woodlands","Bhaflau Thickets","Nashmau","Arrapago Reef",
        "Ilrusi Atoll","Periqia","Talacca Cove","Silver Sea route to Nashmau","Silver Sea route to Al Zahbi","The Ashu Talif","Mount Zhayolm","Halvung",
        "Lebros Cavern","Navukgo Execution Chamber","Mamook","Mamool Ja Training Grounds","Jade Sepulcher","Aydeewa Subterrane","Leujaoam Sanctum",
        "Chocobo Circuit","The Colosseum","Alzadaal Undersea Ruins","Zhayolm Remnants","Arrapago Remnants","Bhaflau Remnants","Silver Sea Remnants",
        "Nyzul Isle","Hazhalm Testing Grounds","Caedarva Mire","Ghoyu's Reverie"},
    no_ring=S{"Hall of Transference","Memory Flux","Promyvion - Dem","Promyvion - Holla","Promyvion - Mea","Promyvion - Vahzl","Spire of Dem","Spire of Holla",
        "Spire of Mea","Spire of Vahzl"},
    neck={
        ['case']=S{"Mage","Tank","Normal"},
        Mage={neck="Rep.Gold Medal"},
        Tank={neck="Windurstian Scarf"},
        Normal={neck="Grand T.K. Collar"},},
    ring ={
        ['case']=S{"Mage","Tank","Normal"},
        Mage={left_ring="Gnd.Kgt. Ring"},
        Tank={left_ring="Ptr.Prt. Ring"},
        Normal={left_ring="Gld.Msk. Ring"},},}
        
if not Conquest.neck.change then
    Conquest.neck.change = false
end
if not Conquest.neck.case_id then
    Conquest.neck.case_id = 1
end
if not Conquest.ring.change then
    Conquest.ring.change = false
end
if not Conquest.ring.case_id then
    Conquest.ring.case_id = 1
end
function Conquest_Gear_do(set_gear)
    if has_any_buff_of(S{"Signet","Sanction","Sigil"}) then
        if Conquest.always:contains(world.area) then
            set_gear = set_combine(set_gear, Conquest.neck[Conquest.neck.case[Conquest.neck.case_id]])
            if not Conquest.no_ring:contains(world.area) then
                if Conquest.ring.change then
                    set_gear = set_combine(set_gear, Conquest.ring[Conquest.ring.case[Conquest.ring.case_id]])
                end
            end
        elseif not Conquest.never:contains(world.area) then
            if world.conquest.nation == player.nation then
                if Conquest.ring.change then
                    set_gear = set_combine(set_gear, Conquest.ring[Conquest.ring.case[Conquest.ring.case_id]])
                end
            else
                if Conquest.neck.change then
                    set_gear = set_combine(set_gear, Conquest.neck[Conquest.neck.case[Conquest.neck.case_id]])
                end
            end
        end
    end
    return set_gear
end
function Conquest_Gear_self_command(status,set_gear,event_type,command)
    if type(command) == 'table' then
        if command[1]:lower() == 'set' or command[1]:lower() == 's' then
            if command[2]:lower() == "cqneck" then
                for i,v in ipairs(Conquest.neck.case) do
                    if v:lower() == command[3]:lower() then
                        Conquest.neck.case_id = i
                    end
                end
            elseif command[2]:lower(Conquest.ring.case) == "cqring" then
                for i,v in ipairs() do
                    if v:lower() == command[3]:lower() then
                        Conquest.ring.case_id = i
                    end
                end
            end
        end
    else
        if command == "cconneck" then
            Conquest.neck.case_id = (Conquest.neck.case_id % #Conquest.neck.case) + 1
        elseif command == "cconring" then
            Conquest.ring.case_id = (Conquest.ring.case_id % #Conquest.ring.case) + 1
        elseif command == 'tconneckchange' then
            Conquest.neck.change = not Conquest.neck.change
        elseif command == 'tconringchange' then
            Conquest.ring.change = not Conquest.ring.change
        end
    end
end