include_setup()
--Saved Variable Recovery ---------------------------------------------------------------------------------------------------------
if gearswap.pathsearch({'SMDinclude/includes/map.lua'}) then include('SMDinclude/includes/map.lua') else error("Must Have includes/map.lua To Use This Include") return end
if gearswap.pathsearch({'Saves/job_'..player.main_job..'var.lua'}) then include('Saves/job_'..player.main_job..'var.lua') end
include('SMDinclude/includes/extra.lua')
----Include functions-------------------------------------------------------------------------------------------------------------
function gear_equip_check(tab,event)
    if type(tab) == "table" and tab.type and S{"WeaponSkill","Samba","Waltz"}:contains(tab.type) and event == "precast" then return false end return true
end
function gear_equip(tab,event)
    sets.building[event] = sets[player.status]
    if gear_equip_check(tab,event) then
        if sets.weapon[weapon_types[weapon_types_count]] then sets.building[event] = set_combine(sets.building[event], sets.weapon[weapon_types[weapon_types_count]]) end
        if sets.range[range_types[range_types_count]] then sets.building[event] = set_combine(sets.building[event], sets.range[range_types[range_types_count]]) end
    end
    if sets.armor[armor_types[armor_types_count]] then sets.building[event] = set_combine(sets.building[event], sets.armor[armor_types[armor_types_count]]) end
end
function run_event(status,a,b,c)
    local event = _global.current_event sets.building[event] = nil gear_equip(a,event)
    if type(a) == "table" and sets[event] then local types = {'action_type','type','skill','name'} for i=1,#types do if sets[event][a[types[i]]] then sets.building[event] = set_combine(sets.building[event], sets[event][a[types[i]]]) end end end
    for i, v in ipairs({"fdebug","s_weapon","ninja_wheel","ammo","msi","conq_gear","extra","mji","sji","WS_Gear","e_obi","mf"}) do
        if _G[v] and _G[v][event] then _G[v][event](status,event,a,b,c) end
        if S{"filtered_action","pretarget","precast"}:contains(event) and status.end_spell then cancel_spell() end
        if status.end_event then return end
    end
    if gearchang_stopper(spell) then return
    elseif not status.stop_swapping_gear then
        if event == "aftercast" then coroutine.schedule(equip:prepare(sets.building[event]),(Aftercast_equip_delay or 1)) 
        else equip(sets.building[event])
        end
    end
end
function add_gear_modes(tbl,tbl_append) local sorted = T(tbl):keyset():sort() for i = 1,#sorted do _G[tbl_append]:append(sorted[i]) end end
----Gearswap basic functions------------------------------------------------------------------------------------------------------
function get_sets()
    gear_setup() add_gear_modes(sets.weapon,'weapon_types') add_gear_modes(sets.range,'range_types') add_gear_modes(sets.armor,'armor_types')
    if update_display then coroutine.schedule(update_display, 1.5) end if mf.file_load then coroutine.schedule(mf.file_load, 1.5) end if file_write and file_write.write then file_write.write() end
end
function filtered_action(spell) local status = {end_event=false,end_spell=false,stop_swapping_gear=true} if spell_stopper(spell) then cancel_spell() end run_event(status,spell) end
function pretarget(spell)
    local status = {end_event=false,end_spell=false,stop_swapping_gear=true}
    if spell_stopper(spell) then cancel_spell() end
    run_event(status,spell)
end
function precast(spell) local status = {end_event=false,end_spell=false,stop_swapping_gear=false} if spell_stopper(spell) then cancel_spell() return end run_event(status,spell) end
function midcast(spell) if spell.action_type == "Ability" then return end local status = {end_event=false,stop_swapping_gear=false} if gearchang_stopper(spell) then return end run_event(status,spell) end
function aftercast(spell)
    local status = {end_event=false,stop_swapping_gear=false}
    if gearchang_stopper(spell) then return end run_event(status,spell)
    if player.in_combat and auto_use_shards then local a = T{'C.','Z.','A.','P.'} local b = T{'I','II','III','IV','V'} local c = ' Ygg. Shard ' for i=1,#a do for i2=1,#b do if player.inventory[a[i]..''..c..''..b[i2]] then send_command('wait 3.0;input /item "'..a[i]..''..c..''..b[i2]..'" <me>') end end end end
end
function status_change(new,old)
    local status = {end_event=false,stop_swapping_gear=false}
    if player.main_job == "THF" and reg_event and not reg_event.treasure_hunter[player.target.id] then thief_sub = thieftype['hunter'] end
    run_event(status,new,old)
end
function pet_change(pet,gain) local status = {end_event=false,stop_swapping_gear=false} run_event(status,pet,gain) end
function pet_midcast(spell) local status = {end_event=false,stop_swapping_gear=false} if gearchang_stopper(spell) then return end run_event(status,spell) end
function pet_aftercast(spell) local status = {end_event=false,stop_swapping_gear=false} if gearchang_stopper(spell) then return end run_event(status,spell) end
function pet_status_change(new,old) local status = {end_event=false,stop_swapping_gear=true} run_event(status,new,old) end
function buff_change(name,gain,buff_table)
    local status = {end_event=false,stop_swapping_gear=true}
    if S{2,19}:contains(buff_table.id) then if gain then equip({neck="Opo-opo Necklace",back="Aries Mantle"}) disable("neck","back") else enable("neck","back") equip(gear_equip(name,'buff_change')) end
    elseif buff_table.id == 582 then Contradance_potency = (gain and 100 or 0)
    elseif buff_table.id == 267 then allied_tags = (gain and true or false)
    elseif buff_table.id == 364 then Rapture = (gain and true or false)
    elseif buff_table.id == 78 then Divine_seal = (gain and true or false)
    elseif buff_table.id == 511 then Reive_mark = (gain and true or false)
    elseif buff_table.id == 257 then Besieged = (gain and true or false)
    end
    run_event(status,name,gain,buff_table)
end
function indi_change(indi_table,gain) local status = {end_event=false,stop_swapping_gear=true} run_event(status,indi_table,gain) if updatedisplay then updatedisplay() end end
function sub_job_change(new,old) 
    --[[gearswap.refresh_user_env()]] 
    --local status = {end_event=false,stop_swapping_gear=true} run_event(status,new,old) 
    menu_commands("{regs|Reload Gearswap}")
end
function self_command(com)
    local status = {end_event=false,stop_swapping_gear=true} local comArgs = com if #comArgs:split(' ') >= 2 then comArgs = T(comArgs:split(' ')) end
    run_event(status,comArgs) if file_write and file_write.write then file_write.write() end if updatedisplay then updatedisplay() end
end
function file_unload(new_job)
    mf.file_unload(new_job) 
    if file_write and file_write.write then file_write.write() end
    --if button then button:hide() button:destroy() end if window then window:hide() window:destroy() end
end
----------------------------------------------------------------------------------------------------------------------------------
function load_includes()
    local includes_have = {['MJi']={[1]=(MJi and gearswap.pathsearch({'SMDinclude/includes/mjob/main_job_'..player.main_job..'.lua'})),[2]='SMDinclude/includes/mjob/main_job_'..player.main_job..'.lua'},['SJi']={[1]=(SJi and gearswap.pathsearch({'SMDinclude/includes/sjob/sub_job_'..player.sub_job..'.lua'})),[2]='SMDinclude/includes/sjob/sub_job_'..player.sub_job..'.lua'},['MSi']={[1]=(MSi and jobs.magic:contains(player.main_job) and gearswap.pathsearch({'SMDinclude/includes/more/MSi.lua'})),[2]='SMDinclude/includes/more/MSi.lua'},['Ammo']={[1]=(Ammo and jobs.ammo:contains(player.main_job) and gearswap.pathsearch({'SMDinclude/includes/more/Ammo.lua'})),[2]='SMDinclude/includes/more/Ammo.lua'},['Special_Weapons']={[1]=(Special_Weapons and gearswap.pathsearch({'SMDinclude/includes/more/Special_Weapons.lua'})),[2]='SMDinclude/includes/more/Special_Weapons.lua'},['Conquest_Gear']={[1]=(Conquest_Gear and gearswap.pathsearch({'SMDinclude/includes/more/Conquest_Gear.lua'})),[2]='SMDinclude/includes/more/Conquest_Gear.lua'},['Registered_Events']={[1]=(Registered_Events and gearswap.pathsearch({'SMDinclude/includes/more/Registered_Events.lua'})),[2]='SMDinclude/includes/more/Registered_Events.lua'},['Debug']={[1]=(Debug and gearswap.pathsearch({'SMDinclude/includes/more/Debug.lua'})),[2]='SMDinclude/includes/more/Debug.lua'},['Display']={[1]=(Display and gearswap.pathsearch({'SMDinclude/includes/more/Display.lua'})),[2]='SMDinclude/includes/more/Display.lua'},['File_Write']={[1]=(File_Write and gearswap.pathsearch({'SMDinclude/includes/more/File_Write.lua'})),[2]='SMDinclude/includes/more/File_Write.lua'},}
    for i, v in pairs(includes_have) do if includes_have[i][1] then include(includes_have[i][2]) end end
end
if Disable_All then return else load_includes() end