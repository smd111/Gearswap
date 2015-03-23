include_setup()
--left_ring="Vocation Ring" or "Capacity Ring"
--Saved Variable Recovery ---------------------------------------------------------------------------------------------------------
if gearswap.pathsearch({'includes/map.lua'}) then
    include('includes/map.lua')
else
    error("Must Have includes/map.lua To Use This Include")
    return
end
if gearswap.pathsearch({'Saves/job_'..player.main_job..'var.lua'}) then
    include('Saves/job_'..player.main_job..'var.lua')
end
----Include functions-------------------------------------------------------------------------------------------------------------
function gear_equip_check(tab)
    if type(tab) == "table" and tab.type and S{"WeaponSkill","Samba","Waltz"}:contains(tab.type) and _global.current_event == "precast" then
        return false
    else
        return true
    end
end
function gear_equip(tab,set_gear)
    if gear_equip_check(tab) then
        if sets.weapon[weapon_types[weapon_types_count]] then
            set_gear = set_combine(set_gear, sets.weapon[weapon_types[weapon_types_count]])
        end
        if sets.range[range_types[range_types_count]] then
            set_gear = set_combine(set_gear, sets.range[range_types[range_types_count]])
        end
    end
    if sets.armor[armor_types[armor_types_count]] then
        set_gear = set_combine(set_gear, sets.armor[armor_types[armor_types_count]])
    end
    return set_gear
end
function run_event(status,set_gear,...)
    local a,b,c = unpack{...}
    local set_gear = set_gear
    set_gear = set_combine(set_gear, gear_equip(a,set_gear))
    if type(a) == "table" and _G["sets.".._global.current_event] and _G["sets.".._global.current_event][a.name] then
        set_gear = set_combine(set_gear, _G["sets.".._global.current_event][a.name])
    end
    for i, v in ipairs({"Conquest_Gear_","Debug_","Ammo_","extra_","Special_Weapon_","ninja_wheel_","MJi_","SJi_","MSi_","mf_","WS_Gear_","elemental_obi_"}) do
        if _G[v..''.._global.current_event] then
            set_gear = set_combine(set_gear, _G[v..''.._global.current_event](status,set_gear,a,b,c))
        end
        if S{"filtered_action","pretarget","precast"}:contains(_global.current_event) and status.end_spell then cancel_spell() end
        if status.end_event then return end
    end
    if gearchang_stopper(spell) then
        return
    end
    if not status.stop_swapping_gear then
        equip(set_gear)
    end
end
function add_gear_modes(tbl,tbl_append)
    local sorted = T(tbl):keyset():sort()
    for i = 1,#sorted do _G[tbl_append]:append(sorted[i]) end
end
----Gearswap basic functions------------------------------------------------------------------------------------------------------
function get_sets()
    gear_setup()
    add_gear_modes(sets.weapon,'weapon_types')
    add_gear_modes(sets.range,'range_types')
    add_gear_modes(sets.armor,'armor_types')
    if start_display then
        start_display()
    end
    if update_display then
        update_display()
    end
end
function filtered_action(spell)
    local status = {end_event=false,end_spell=false,stop_swapping_gear=true}
    local set_gear = {}
    if spell_stopper(spell) then cancel_spell() return end
    set_gear = set_combine(set_gear, sets[player.status])
    run_event(status,set_gear,spell)
end
function pretarget(spell)
    local status = {end_event=false,end_spell=false,stop_swapping_gear=true}
    local set_gear = {}
    if spell_stopper(spell) then cancel_spell() return end
    set_gear = set_combine(set_gear, sets[player.status])
    run_event(status,set_gear,spell)
end
function precast(spell)
    local status = {end_event=false,end_spell=false,stop_swapping_gear=false}
    local set_gear = {}
    if spell_stopper(spell) then cancel_spell() return end
    set_gear = set_combine(set_gear, sets[player.status])
    run_event(status,set_gear,spell)
end
function midcast(spell)
    if spell.action_type == "Ability" then
        return
    end
    local status = {end_event=false,stop_swapping_gear=false}
    local set_gear = {}
    if gearchang_stopper(spell) then return end
    set_gear = set_combine(set_gear, sets[player.status])
    run_event(status,set_gear,spell)
end
function aftercast(spell)
    local status = {end_event=false,stop_swapping_gear=false}
    local set_gear = {}
    if gearchang_stopper(spell) then return end
    set_gear = set_combine(set_gear, sets[player.status])
    run_event(status,set_gear,spell)
    if player.in_combat and auto_use_shards then
        for sni, snv in ipairs({'C.','Z.','A.','P.'}) do
            for sci, scv in ipairs({'I','II','III','IV','V'}) do
                if player.inventory[snv..' Ygg. Shard '..scv] then
                    send_command('wait 3.0;input /item "'..snv..' Ygg. Shard '..scv..'" <me>')
                end
            end
        end
    end
end
function status_change(new,old)
    local status = {end_event=false,stop_swapping_gear=false}
    local set_gear = {}
    set_gear = set_combine(set_gear, sets[player.status])
    run_event(status,set_gear,new,old)
end
function pet_change(pet,gain)
    local status = {end_event=false,stop_swapping_gear=false}
    local set_gear = {}
    set_gear = set_combine(set_gear, sets[player.status])
    run_event(status,set_gear,pet,gain)
end
function pet_midcast(spell)
    local status = {end_event=false,stop_swapping_gear=false}
    local set_gear = {}
    if gearchang_stopper(spell) then return end
    set_gear = set_combine(set_gear, sets[player.status])
    run_event(status,set_gear,spell)
end
function pet_aftercast(spell)
    local status = {end_event=false,stop_swapping_gear=false}
    local set_gear = {}
    if gearchang_stopper(spell) then return end
    set_gear = set_combine(set_gear, sets[player.status])
    run_event(status,set_gear,spell)
end
function pet_status_change(new,old)
    local status = {end_event=false,stop_swapping_gear=true}
    local set_gear = {}
    set_gear = set_combine(set_gear, sets[player.status])
    run_event(status,set_gear,new,old)
end
function buff_change(name,gain,buff_table)
    local status = {end_event=false,stop_swapping_gear=true}
    local set_gear = {}
    set_gear = set_combine(set_gear, sets[player.status])
    if name == "sleep" then
        if gain then
            equip({neck="Opo-opo Necklace",back="Aries Mantle"})
            disable("neck","back")
        else
            enable("neck","back")
            equip(sets[player.status], gear_equip(name,"buff_change",set_gear))
        end
    end
    run_event(status,set_gear,name,gain,buff_table)
end
function indi_change(indi_table,gain)
    local status = {end_event=false,stop_swapping_gear=true}
    local set_gear = {}
    set_gear = set_combine(set_gear, sets[player.status])
    run_event(status,set_gear,indi_table,gain)
end
function sub_job_change(new,old)
    send_command("gs r")
    local status = {end_event=false,stop_swapping_gear=true}
    local set_gear = {}
    set_gear = set_combine(set_gear, sets[player.status])
    run_event(status,set_gear,new,old)
end
function self_command(command)
    local status = {end_event=false,stop_swapping_gear=true}
    local set_gear = {}
    set_gear = set_combine(set_gear, sets[player.status])
    local commandArgs = command
    if type(commandArgs) == 'string' and #commandArgs:split(' ') >= 2 then
        commandArgs = T(commandArgs:split(' '))
    end
    run_event(status,set_gear,commandArgs)
    if File_Write_do then
        File_Write_do()
    end
    if updatedisplay then
        updatedisplay()
    end
end
function file_unload(new_job)
    local status = {end_event=false,stop_swapping_gear=true}
    local set_gear = {}
    set_gear = set_combine(set_gear, sets[player.status])
    run_event(status,set_gear,new_job)
    if File_Write_do then
        File_Write_do()
    end
end
----Check spell ruels-------------------------------------------------------------------------------------------------------------
function spell_stopper(spell)
    if world.in_mog_house or world.mog_house then return true end
    -- if midaction() or pet_midaction() then return true end
    -- if spell.action_type ~= "Ranged Attack"  and spell.action_type ~= 'Item' and spell_range_check(spell) then return true end
    if gearchang_stopper(spell) and not Disable_All then return true end
    if spell.en ~= 'Ranged' and spell.type ~= 'WeaponSkill' then
        if spell and spell.action_type == 'Ability' then
            if tonumber(windower.ffxi.get_ability_recasts()[spell.recast_id]) > 0 then
                return true
            end
        elseif spell and spell.action_type == 'Magic' then
            if tonumber(windower.ffxi.get_spell_recasts()[spell.id]) > 0 then
                return true
            end
        end
    end
    if spell then
        if spell.tp_cost and spell.tp_cost > player.tp then
            return true
        end
        if (spell.mp_cost and spell.mp_cost > player.mp) and not (buffactive['Manawell'] or buffactive['Manafont']) then
            return true
        end
    end
    if min_fm_for_flourishes[spell.en] then
        local fm_count = 0
        for i, v in pairs(buffactive) do
            if i:startswith("Finishing Move") then
                fm_count = tonumber(string.match(i, '%d+'))
            end
        end
        if min_fm_for_flourishes[spell.en] > fm_count then
            return true
        end
    end
    if player.tp < 1000 and spell.type == 'WeaponSkill'  then
        return true
    end
    if partynames.party1 then
        if spell.type == "Trust" and party.count > 1 then
            if player.in_combat then
                return true
            end
            if partynames.party1:contains(string.gsub(spell.en, "%s+", "")) then
                return true
            end
        end
    end
    if not transportation_spells:contains(spell.en) and cities:contains(world.area) then
        return true
    end
    if spell.target.name == nil then
        return true
    end
end
function spell_range_check(spell)
    local range_mult = {
        [0] = 0,
        [1] = 1.642276421172564,
        [2] = 1.642276421172564,
        [3] = 1.642276421172564,
        [4] = 1.642276421172564,
        [5] = 1.642276421172564,
        [6] = 1.642276421172564,
        [7] = 1.642276421172564,
        [8] = 1.642276421172564,
        [9] = 1.642276421172564,
        [10] = 1.642276421172564,
        [11] = 1.642276421172564,
        [12] = 1.642276421172564,
        }
    local spell_max_distance = spell.target.model_size + spell.range * range_mult[spell.range]
    if spell_max_distance < spell.target.distance then
        -- if player.target.type == "MONSTER" then
            -- add_to_chat(7,"Monster out of "..spell.name.."'s max range of "..spell_max_distance)
        -- elseif player.target.type == "NPC" then
            -- add_to_chat(7,"NPC out of "..spell.name.."'s max range of "..spell_max_distance)
        -- else
            -- add_to_chat(7,"Player out of "..spell.name.."'s max range of "..spell_max_distance)        
        -- end
        return true
    end
end
function gearchang_stopper(spell)
    if spell and spell.action_type == "Ability" then
        for i, v in ipairs({'Amnesia','Charm','Impairment','Petrification','Sleep','Stun','Terror'}) do
            if buffactive[v] then
                return true
            end
        end
    elseif spell and spell.action_type == "Magic" then
        for i, v in ipairs({'Charm','Mute','Omerta','Petrification','Silence','Sleep','Stun','Terror'}) do
            if buffactive[v] then
                return true
            end
        end
    end
end
----------------------------------------------------------------------------------------------------------------------------------
function load_includes()
    local includes_have = {
    ['MJi']={[1]=(MJi and gearswap.pathsearch({'includes/mjob/main_job_'..player.main_job..'.lua'})),[2]='includes/mjob/main_job_'..player.main_job..'.lua'},
    ['SJi']={[1]=(SJi and gearswap.pathsearch({'includes/sjob/sub_job_'..player.sub_job..'.lua'})),[2]='includes/sjob/sub_job_'..player.sub_job..'.lua'},
    ['MSi']={[1]=(MSi and jobs.magic:contains(player.main_job) and gearswap.pathsearch({'includes/more/MSi.lua'})),[2]='includes/more/MSi.lua'},
    ['Ammo']={[1]=(Ammo and jobs.ammo:contains(player.main_job) and gearswap.pathsearch({'includes/more/Ammo.lua'})),[2]='includes/more/Ammo.lua'},
    ['Special_Weapons']={[1]=(Special_Weapons and gearswap.pathsearch({'includes/more/Special_Weapons.lua'})),[2]='includes/more/Special_Weapons.lua'},
    ['Conquest_Gear']={[1]=(Conquest_Gear and gearswap.pathsearch({'includes/more/Conquest_Gear.lua'})),[2]='includes/more/Conquest_Gear.lua'},
    ['Registered_Events']={[1]=(Registered_Events and gearswap.pathsearch({'includes/more/Registered_Events.lua'})),[2]='includes/more/Registered_Events.lua'},
    ['Debug']={[1]=(Debug and gearswap.pathsearch({'includes/more/Debug.lua'})),[2]='includes/more/Debug.lua'},
    ['Display']={[1]=(Display and gearswap.pathsearch({'includes/more/Display.lua'})),[2]='includes/more/Display.lua'},
    ['File_Write']={[1]=(File_Write and gearswap.pathsearch({'includes/more/File_Write.lua'})),[2]='includes/more/File_Write.lua'},}
    for i, v in pairs(includes_have) do if includes_have[i][1] then include(includes_have[i][2]) end end
end
if Disable_All then
    return
else
    load_includes()
    load_includes = nil
end
----WS/Obi equip------------------------------------------------------------------------------------------------------------------
function WS_Gear_precast(status,set_gear,spell)
    if spell.type == "WeaponSkill" then
        if player.inventory["Fotia Gorget"] or player.wardrobe["Fotia Gorget"] then
            set_gear = set_combine(set_gear, {neck="Fotia Gorget"})
        else
            set_gear = set_combine(set_gear, sets.ws_neck[spell.element])
        end
        if player.inventory["Fotia Belt"] or player.wardrobe["Fotia Belt"] then
            set_gear = set_combine(set_gear, {neck="Fotia Belt"})
        elseif player.inventory[sets.ws_belt[spell.element].waist] or player.wardrobe[sets.ws_belt[spell.element].waist] then
            set_gear = set_combine(set_gear, sets.ws_belt[spell.element])
        end
        set_gear = set_combine(set_gear, sets.WS_types[spell.skill])
    end
    return set_gear
end
WS_Gear_midcast = WS_Gear_precast
function elemental_obi_midcast(status,set_gear,spell)
    if not Typ.abilitys:contains(spell.prefix) then
        if spell.element == world.weather_element or spell.element == world.day_element then
            if player.inventory["Hachirin-no-Obi"] or player.wardrobe["Hachirin-no-Obi"] then
                set_gear = set_combine(set_gear, {waist="Hachirin-no-Obi"})
            elseif player.inventory[sets.spell_obi[spell.element].waist] or player.wardrobe[sets.spell_obi[spell.element].waist] then
                set_gear = set_combine(set_gear, sets.spell_obi[spell.element])
            end
        end
    end
    return set_gear
end
--extra functions-----------------------------------------------------------------------------------------------------------------
function extra_self_command(status,set_gear,command)
    if type(command) == 'table' then
        if command[1]:lower() == 'set' or command[1]:lower() == 's' then
            if _G[command[2]:lower()..'_types'] then
                for i,v in pairs(_G[command[2]:lower()..'_types']) do
                    if tostring(v):lower() == command[3]:lower() then
                        _G[command[2]:lower()..'_types_count'] = i
                    end
                end
            end
        end
    else
        if command == "reload_gearswap" then
            if File_Write_do then
                File_Write_do()
            end
            send_command("gs r")
        elseif command == "toggledisplay" and Display then
            if window:visible() then
                window:hide()
                window_hidden = true
            else
                window:show()
                window_hidden = false
            end
        end
    end
end
if File_Write_do then
    File_Write_do()
end