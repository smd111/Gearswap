Conquest = {
    always = {"Al'Taieu","Auroral Updraft","Empyreal Paradox","The Garden of Ru'Hmet","Grand Palace of Hu'Xzoi","Dynamis - Windurst","Dynamis - San d'Oria",
        "Dynamis - Bastok","Dynamis - Jeuno","Dynamis - Beaucedine","Dynamis - Xarcabard","Dynamis - Valkurm","Dynamis - Buburimu","Dynamis - Qufim","Dynamis - Tavnazia",
        "Apollyon","Temenos","Hall of Transference","Memory Flux","Promyvion - Dem","Promyvion - Holla","Promyvion - Mea","Promyvion - Vahzl","Spire of Dem",
        "Spire of Holla","Spire of Mea","Spire of Vahzl"},
    never = {"Abyssea - La Theine","Abyssea - Konschtat","Abyssea - Tahrongi","Abyssea - Attohwa","Abyssea - Misareaux","Abyssea - Vunkerl","Abyssea - Altepa",
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
    no_ring = {"Hall of Transference","Memory Flux","Promyvion - Dem","Promyvion - Holla","Promyvion - Mea","Promyvion - Vahzl","Spire of Dem","Spire of Holla",
        "Spire of Mea","Spire of Vahzl"},
    neck = {
        ['case'] = {"Mage","Tank","Normal"},
        Mage = {[1] = {neck="Rep.Gold Medal"}, [2] = jobneck},
        Tank = {[1] = {neck="Windurstian Scarf"}, [2] = jobneck},
        Normal = {[1] = {neck="Grand T.K. Collar"},[2] = jobneck},},
    ring ={
        ['case'] = {"Mage","Tank","Normal"},
        Mage = {[1] = {left_ring="Gnd.Kgt. Ring"}, [2] = jobring},
        Tank = {[1] = {left_ring="Ptr.Prt. Ring"},[2] = jobring},
        Normal = {[1] = {left_ring="Gld.Msk. Ring"},[2] = jobring},},}
        
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
function Conquest_Gear_do(status,set_gear)
    local neckid = 2
    local ringid = 2
    if has_any_buff_of(S{"Signet","Sanction","Sigil"}) then
        if table.contains(Conquest.always, world.area) then
            neckid = 1
            if not table.contains(Conquest.no_ring, world.area) then
                ringid = 1
            else
                ringid = 2
            end
        elseif not table.contains(Conquest.never, world.area) then
            if world.conquest.nation == player.nation then
                neckid = 2
                ringid = 1
            else
                neckid = 1
                ringid = 2
            end
        end
    end
    if Conquest.neck.change then
        set_gear = set_combine(set_gear, Conquest.neck[Conquest.neck.case[Conquest.neck.case_id]][neckid])
    end
    if Conquest.ring.change then
        set_gear = set_combine(set_gear, Conquest.ring[Conquest.ring.case[Conquest.ring.case_id]][ringid])
    end
    return set_gear
end
function Conquest_Gear_self_command(command)
    if command == "conquestneck" then
        Conquest.neck.case_id = (Conquest.neck.case_id % #Conquest.neck.case) + 1
    end
    if command == "conquestring" then
        Conquest.ring.case_id = (Conquest.ring.case_id % #Conquest.ring.case) + 1
    end
    if command == 'conquestneckchange' then
        Conquest.neck.change = not Conquest.neck.change
    end
    if command == 'conquestringchange' then
        Conquest.ring.change = not Conquest.ring.change
    end
end