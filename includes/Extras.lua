--Variable Set-up -----------------------------------------------------------------------------------------------------------------
include_setup()
tool_bag_id = 0
menu = {}
menu.pos = {}
menu.pos.x = 0
menu.pos.y = 0
gear_mode = L{'Normal', 'Acc', 'Att'}
gear_mode_count = 1
Conquest = {}
Conquest.neck = {}
Conquest.ring = {}
partynames = {}
lock_gear={main=false,sub=false,range=false,ammo=false,head=false,body=false,hands=false,legs=false,feet=false,neck=false,waist=false,left_ear=false,right_ear=false,left_ring=false,right_ring=false,back=false,}
auto_use_shards = true
events = {"Debug_","extra_","MJi_","SJi_","MSi_","mf_"}
weapon_types_count = 1
range_type_count = 1
--Saved Variable Recovery ---------------------------------------------------------------------------------------------------------
if gearswap.pathsearch({'Saves/job_'..player.main_job..'var.lua'}) then
    include('Saves/job_'..player.main_job..'var.lua')
end
if gearswap.pathsearch({'includes/map.lua'}) then
    include('includes/map.lua')
else
    add_to_chat(7,"Must Have includes/map.lua To Use Extras.lua")
    return
end
----------------------------------------------------------------------------------------------------------------------------------
function add_gear_modes(...)
    local gear_table = ...
    for i, v in ipairs(...) do
        gear_mode:append(v)
    end
end
function run_event(event_type,...)
    local a,b = unpack{...}
    local check_function = {[1]={"pretarget","precast","midcast","aftercast","pet_midcast","pet_aftercast"},
                            [2]={"pretarget","precast","midcast","pet_midcast","pet_aftercast"},
                            [3]={"filtered_action","file_unload","self_command","pet_change","sub_job_change"},
                            [4]={"pretarget","precast","filtered_action"},}
    local status = {end_event=false,end_spell=false,stop_swapping_gear=false}
    local set_gear = {}
    set_gear = set_combine(set_gear, sets[player.status])
    if sets.weapon[weapon_types[weapon_types_count]] then
        set_gear = set_combine(set_gear, sets.weapon[weapon_types[weapon_types_count]])
    end
    if sets.range[range_type[range_type_count]] then
        set_gear = set_combine(set_gear, sets.range[range_type[range_type_count]])
    end
    if table.contains(check_function[1], event_type) then
        if Conquest_Gear_do then
            set_gear = set_combine(set_gear, Conquest_Gear_do(status,set_gear))
        end
    end
    if event_type == "precast" then
        if Ammo_rule then
            Ammo_rule(a,status,set_gear)
        end
        if Special_Weapon_do then
            Special_Weapon_do(a,status,set_gear)
        end
    end
    if status.end_spell and event_type == 'precast' then cancel_spell() end
    if status.end_event then return end
    if table.contains(check_function[2], event_type) then
        if WSi_Gear then
            set_gear = set_combine(set_gear, WSi_Gear(a,status,set_gear))
        end
        if MSi_equip then
            set_gear = set_combine(set_gear, MSi_equip(a,status,set_gear))
        end
        if equip_elemental_magic_obi and sets.obi then
            set_gear = set_combine(set_gear, equip_elemental_magic_obi(a,status,set_gear))
        end
    end
    for i, v in ipairs(events) do
        if b and _G[v..''..event_type] then
            set_gear = set_combine(set_gear, _G[v..''..event_type](a,b,status,set_gear))
        elseif _G[v..''..event_type] then
            set_gear = set_combine(set_gear, _G[v..''..event_type](a,status,set_gear))
        end
        if status.end_spell and table.contains(check_function[4], event_type) then cancel_spell() end
        if status.end_event then return end
    end
    if table.contains(check_function[3], event_type)  then
        status.stop_swapping_gear = true
    end
    if not status.stop_swapping_gear then
        equip(set_gear)
        --for i, v in pairs(lock_gear) do
            --if v then
                --disable(tostring(i))
            --elseif not v then
                --enable(tostring(i))
            --end
        --end
    end
end
function get_sets()
    gear_setup()
    if start_display then
        start_display()
    end
    if update_display then
        coroutine.schedule(update_display, 3)
    end
end
function filtered_action(spell)
    if gearchang_stopper(spell) and not Disable_All then cancel_spell() return end
    run_event('filtered_action',spell)
end
function pretarget(spell)
    if gearchang_stopper(spell) and not Disable_All then cancel_spell() return end
    run_event('pretarget',spell)
end
function precast(spell)
    if spell_stopper(spell) and not Disable_All then cancel_spell() return elseif spell_stopper(spell) == false and not Disable_All then cancel_spell() end
    run_event('precast',spell)
end
function midcast(spell)
    if gearchang_stopper(spell) and not Disable_All then return end
    run_event('midcast',spell)
end
function aftercast(spell)
    if gearchang_stopper(spell) and not Disable_All then return end
    run_event('aftercast',spell)
    if player.in_combat and auto_use_shards then
        local shard_name = {'C. Ygg. Shard ','Z. Ygg. Shard ','A. Ygg. Shard '}
        for sni, snv in ipairs(shard_name) do
            local shard_count = {'I','II','III','IV','V'}
            for sci, scv in ipairs(shard_count) do
                if player.inventory[snv..''..scv] then
                    send_command('wait 3.0;input /item "'..snv..''..scv..'" <me>')
                end
            end
        end
    end
end
function pet_midcast(spell)
    if gearchang_stopper(spell) and not Disable_All then return end
    run_event('pet_midcast',spell)
end
function pet_aftercast(spell)
    if gearchang_stopper(spell) and not Disable_All then return end
    run_event('pet_aftercast',spell)
end
function file_unload()
    run_event('file_unload',nil)
    if File_Write_do then
        File_Write_do()
    end
end
function status_change(new,old)
    run_event('status_change',new,old)
end
function buff_change(name,gain)
    if name == "sleep" then
        if gain then
            equip({neck="Opo-opo Necklace",back="Aries Mantle"})
            disable("neck","back")
        else
            enable("neck","back")
            equip(sets[player.status], sets.weapon[weapon_types[weapon_types_count]])
        end
    end
    if mf_buff_change then
        mf_buff_change(name,gain)
    end
    if sub_job_buff_change then
        sub_job_buff_change(name,gain)
    end
    if mf_buff_change then
        mf_buff_change(name,gain)
    end
end
function self_command(command)
    run_event('self_command',command)
    if File_Write_do then
        File_Write_do()
    end
    if updatedisplay then
        updatedisplay()
    end
end
function pet_change(pet,gain)
    run_event('pet_change',pet,gain)
end
function sub_job_change(new,old)
    send_command("gs r") run_event('sub_job_change',new,old)
end
function indi_change(indi_table,gain)
    run_event('sub_job_change',new,old)
end
-----------------------------------------------------------------------------------------------------------------------------------
function load_includes()
    local includes_have = {
    ['MJi']={[1]=(MJi and gearswap.pathsearch({'includes/mjob/main_job_'..player.main_job..'.lua'})),[2]='includes/mjob/main_job_'..player.main_job..'.lua'},
    ['SJi']={[1]=(SJi and gearswap.pathsearch({'includes/sjob/sub_job_'..player.sub_job..'.lua'})),[2]='includes/sjob/sub_job_'..player.sub_job..'.lua'},
    ['MSi']={[1]=(MSi and table.contains(jobs.magic, player.main_job) and gearswap.pathsearch({'includes/extra_more/MSi.lua'})),[2]='includes/extra_more/MSi.lua'},
    ['WSi']={[1]=(_G[v] and gearswap.pathsearch({'includes/extra_more/WSi.lua'})),[2]='includes/extra_more/WSi.lua'},
    ['Ammo']={[1]=(Ammo and table.contains(jobs.ammo, player.main_job) and gearswap.pathsearch({'includes/extra_more/Ammo.lua'})),[2]='includes/extra_more/Ammo.lua'},
    ['Special_Weapons']={[1]=(Special_Weapons and gearswap.pathsearch({'includes/extra_more/Special_Weapons.lua'})),[2]='includes/extra_more/Special_Weapons.lua'},
    ['Conquest_Gear']={[1]=(Conquest_Gear and gearswap.pathsearch({'includes/extra_more/Registered_Events.lua'})),[2]='includes/extra_more/Registered_Events.lua'},
    ['Registered_Events']={[1]=(Registered_Events and gearswap.pathsearch({'includes/extra_more/Registered_Events.lua'})),[2]='includes/extra_more/Registered_Events.lua'},
    ['Debug']={[1]=(Debug and gearswap.pathsearch({'includes/extra_more/Debug.lua'})),[2]='includes/extra_more/Debug.lua'},
    ['Display']={[1]=(Display and gearswap.pathsearch({'includes/extra_more/Display.lua'})),[2]='includes/extra_more/Display.lua'},
    ['File_Write']={[1]=(File_Write and gearswap.pathsearch({'includes/extra_more/File_Write.lua'})),[2]='includes/extra_more/File_Write.lua'},}
    for i, v in pairs(includes_have) do if includes_have[i][1] then include(includes_have[i][2]) end end
end
if Disable_All then
    return
else
    load_includes()
end
--extra functions-----------------------------------------------------------------------------------------------------------------
function extra_self_command(command)
    if command == "reload_gearswap" then
        if File_Write_do then
            File_Write_do()
        end
        send_command("gs r")
    end
    if command == "toggledisplay" and Display then
        if window:visible() then
            window:hide()
            window_hidden = true
        else
            window:show()
            window_hidden = false
        end
    end
    if command:lower():startswith('set ') or command:lower():startswith('s ') then
        local commandArgs = command
        if type(commandArgs) == 'string' then
            commandArgs = T(commandArgs:split(' '))
        end
        if commandArgs[2]:lower() == 'steps' then
            if tonumber(commandArgs[3]) <= 5 then
                gear_mode_count = tonumber(commandArgs[3])
            else
                add_to_chat(7, "Cannot set max steps to weapon to "..weapon_types[commandArgs[3]].." because weapon set does not exist.")
            end
        end
        if commandArgs[2]:lower() == 'armor' or commandArgs[2]:lower() == 'a' then
            for i, v in ipairs(gear_mode) do
                if v:lower() == string.lower(commandArgs[3]) then
                    commandArgs[3] = i
                end
            end
            gear_mode_count = tonumber(commandArgs[3])
        end
        if commandArgs[2]:lower() == 'range' or commandArgs[2]:lower() == 'r' then
            local corrections_for_set_range = {['archery']='archery',['bow']='archery',['marksmanship']='marksmanship',['xbow']='marksmanship',['gun']='marksmanship',
            ['throwing']='throwing',['throw']='throwing',['fishing']='fishing',['fish']='fishing',['soultrapper']='soultrapper',['camera']='soultrapper',
            ['wind_instruments']='wind_instruments',['flute']='wind_instruments',['string_instruments']='string_instruments',['harp']='string_instruments',
            ['handbells']='handbells',['bell']='handbells',['other']='other',}
            for i, v in ipairs(range_type) do
                if corrections_for_set_range[commandArgs[3]] and corrections_for_set_range[string.lower(commandArgs[3])] == v:lower() then
                    commandArgs[3] = i
                else
                    add_to_chat(7, "Unknown range weapon type "..range_type[commandArgs[3]])
                end
            end
            if sets.range[range_type[commandArgs[3]]] then
                range_type_count = tonumber(commandArgs[3])
            else
                add_to_chat(7, "Cannot switch range weapon to "..range_type[commandArgs[3]].." because range set does not exist.")
            end
        end
        if commandArgs[2]:lower() == 'weapon' or commandArgs[2]:lower() == 'w' then
            local corrections_for_set_weapon = {['axe']='axe',['club']='club',['dagger']='dagger',['great_axe']='great_axe',['ga']='great_axe',
            ['great_sword']='great_sword',['gs']='great_sword',['hand-to-hand']='hand-to-hand',['h2h']='hand-to-hand',['polearm']='polearm',['scythe']='scythe',
            ['staff']='staff',['sword']='sword',['great_katana']='great_katana',['gk']='great_katana',['katana']='katana',}
            for i, v in ipairs(weapon_types) do
                if corrections_for_set_weapon[string.lower(commandArgs[3])] == v:lower() then
                    commandArgs[3] = i
                else
                    add_to_chat(7, "Unknown weapon type "..range_type[commandArgs[3]])
                end
            end
            if sets.weapon[weapon_types[commandArgs[3]]] then
                weapon_types_count = tonumber(commandArgs[3])
            else
                add_to_chat(7, "Cannot switch weapon to "..weapon_types[commandArgs[3]].." because weapon set does not exist.")
            end
        end
        if updatedisplay then
            updatedisplay()
        end
    end
end
function equip_elemental_magic_obi(spell,status)
    if not Typ.abilitys:contains(spell.prefix) then
        if spell.element == world.weather_element or spell.element == world.day_element then
            set_gear = set_combine(set_gear, sets.obi[spell.element])
        end
    end
    return set_gear
end
function spell_stopper(spell)
    if spell.en ~= 'Ranged' and spell.type ~= 'WeaponSkill' then
        if spell and spell.action_type == 'Ability' then
            if tonumber(windower.ffxi.get_ability_recasts()[spell.recast_id]) > 0 then
                --add_to_chat(7, tostring(spell.name).." cancelled with recast of "..windower.ffxi.get_ability_recasts()[spell.recast_id])
                return false
            end
        elseif spell and spell.action_type == 'Magic' then
            if tonumber(windower.ffxi.get_spell_recasts()[spell.id]) > 0 then
                --add_to_chat(7, tostring(spell.name).." cancelled with recast of "..windower.ffxi.get_spell_recasts()[spell.id])
                return false
            end
        end
    end
    if spell then
        if spell.tp_cost > player.tp then
            return true
        end
        if spell.mp_cost > player.mp and not (buffactive['Manawell'] or buffactive['Manafont']) then
            return true
        end
    end
    if gearchang_stopper(spell) and not Disable_All then return true end
    if spell.target.name == nil then
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
    if min_fm_for_flourishes[spell.en] then
        local fm_count = 0
        for i, v in pairs(buffactive) do
            if string.startswith(tostring(i), 'finishing move') then
                fm_count = tonumber(string.sub(i, 16))
                if min_fm_for_flourishes[spell.en] > fm_count then
                    return true
                end
            end
        end
    end
    local transportation_spells = {'Escape','Recall-Jugner','Recall-Meriph','Recall-Pashh','Retrace','Teleport-Altep','Teleport-Dem','Teleport-Holla','Teleport-Mea',
                                    'Teleport-Vahzl','Teleport-Yhoat','Warp','Warp II'}
    if not table.contains(transportation_spells, spell.en) and table.contains(cities, world.area) then
        return true
    end
    -- if midaction() or pet_midaction() then
        -- return true
    -- end
    if  player.tp < 1000 and spell.type == 'WeaponSkill'  then
        return true
    end
    if player.main_job == "NIN" or player.sub_job == "NIN" then if nin_tool_check(spell) then return true end end
    --if spell.en ~= 'Ranged' and spell.type ~= 'Item' and spell_range_check(spell) then return true end
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
        if player.target.type == "MONSTER" then
            add_to_chat(7,"Monster out of "..spell.name.."'s max range of "..spell_max_distance)
        elseif player.target.type == "NPC" then
            add_to_chat(7,"NPC out of "..spell.name.."'s max range of "..spell_max_distance)
        else
            add_to_chat(7,"Player out of "..spell.name.."'s max range of "..spell_max_distance)        
        end
        return true
    else
        return false
    end
end
function gearchang_stopper(spell)
    local stop_job_ability = {'Amnesia','Charm','Impairment','Petrification','Sleep','Stun','Terror'}
    local stop_spell = {'Charm','Mute','Omerta','Petrification','Silence','Sleep','Stun','Terror'}
    if spell.action_type == "Ability" then
        for i, v in ipairs(stop_job_ability) do
            if buffactive[v] then
                return true
            end
        end
    elseif spell.action_type == "Magic" then
        for i, v in ipairs(stop_spell) do
            if buffactive[v] then
                return true
            end
        end
    end
end
if File_Write_do then
    File_Write_do()
end
--has buff functions--------------------------------------------------------------------------------------------------------------
function has_any_buff_of(buff_set)
    return buff_set:any(has_buff())
end
function has_buff()
    return function (b) return buffactive[b] end
end