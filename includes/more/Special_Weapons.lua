if not specialweaponwscount then
    specialweaponwscount = 0
end
function Special_Weapon_precast(status,set_gear,event_type,spell)
    local Special_Weapons_Data = {["Molva Maul"]="Randgrith",["Skogul Lance"]="Geirskogul",["Cleofun Axe"]="Onslaught",["Corbenic Sword"]="Knights of Round",
    ["Murti Bow"]="Namas Arrow",["Heofon Knuckles"]="Final Heaven",["Clement Skean"]="Mercy Stroke",["Khloros Blade"]="Scourge",["Barbarus Bhuj"]="Metatron Torment",
    ["Crisis Scythe"]="Catastrophe",["Sekirei"]="Blade: Metsu",["Ame-no-ohabari"]="Tachi: Kaiten",["Chthonic Staff"]="Gate of Tartarus",["Exequy Gun"]="Coronach"}
    if spell.type == "WeaponSkill" then
        if Special_Weapons_Data[player.equipment.main] and spell.en ~= Special_Weapons_Data[player.equipment.main] then
            if specialweaponwscount < 13 then
                specialweaponwscount = specialweaponwscount +1
            elseif specialweaponwscount == 13 then
                status.end_spell=true
                status.end_event=true
                send_command('input /ws "'..Special_Weapons_Data[player.equipment.main]..'" <t>')
                specialweaponwscount = 0
            end
        end
    end
end