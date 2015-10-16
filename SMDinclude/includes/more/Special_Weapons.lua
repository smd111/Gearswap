s_weapon = {}
function s_weapon.precast(status,current_event,spell)--changes to corect 13th weaponskill for special weapons
    local Special_Weapons_Data = {["Molva Maul"]="Randgrith",["Skogul Lance"]="Geirskogul",["Cleofun Axe"]="Onslaught",["Corbenic Sword"]="Knights of Round",
                                  ["Murti Bow"]="Namas Arrow",["Heofon Knuckles"]="Final Heaven",["Clement Skean"]="Mercy Stroke",["Khloros Blade"]="Scourge",
                                  ["Barbarus Bhuj"]="Metatron Torment",["Crisis Scythe"]="Catastrophe",["Sekirei"]="Blade: Metsu",["Ame-no-ohabari"]="Tachi: Kaiten",
                                  ["Chthonic Staff"]="Gate of Tartarus",["Exequy Gun"]="Coronach"}
    if spell.type == "WeaponSkill" then
        local main = (res.items:with('en', player.equipment.main) or res.items:with('ja', player.equipment.main))
        if Special_Weapons_Data[main.en] and spell.en ~= Special_Weapons_Data[main.en] then
            if special_weapon_ws_count < 13 then
                special_weapon_ws_count = special_weapon_ws_count +1
            elseif special_weapon_ws_count == 13 then
                local new_ws = res.weapon_skills:with('en', Special_Weapons_Data[main.en])
                status.end_spell=true
                status.end_event=true
                special_weapon_ws_count = 0
                send_command('input /ws "'..new_ws[gearswap.language]..'" <t>')
                return
            end
        end
    end
end