--modded gearswap functions
function gearswap.refresh_item_list(itemlist)
    retarr = gearswap.make_user_table()
    for i,v in pairs(itemlist) do
        if type(v) == 'table' and v.id and v.id ~= 0 then
            if gearswap.res.items[v.id] and gearswap.res.items[v.id][language] and not retarr[gearswap.res.items[v.id][language]] then
                retarr[gearswap.res.items[v.id][language]] = {id=v.id,count=v.count,shortname=gearswap.res.items[v.id][language]:lower(),extdata = gearswap.extdata.decode(v)}
                if gearswap.res.items[v.id][language..'_log'] and gearswap.res.items[v.id][language..'_log']:lower() ~= gearswap.res.items[v.id][language]:lower() then
                    retarr[gearswap.res.items[v.id][language]].longname = gearswap.res.items[v.id][language..'_log']:lower()
                    retarr[gearswap.res.items[v.id][language..'_log']] = retarr[gearswap.res.items[v.id][language]]
                end
            elseif gearswap.res.items[v.id] and gearswap.res.items[v.id][language] then
                retarr[gearswap.res.items[v.id][language]].count = retarr[gearswap.res.items[v.id][language]].count + v.count
            end
        end
    end
    return retarr
end
gearswap.parse.i[0x044] = function (data)
    if data:unpack('C',0x05) == 0x12 then
        gearswap.player.skills.automaton_melee_level = data:unpack('H',0x71)
        gearswap.player.skills.automaton_archery_level = data:unpack('H',0x75)
        gearswap.player.skills.automaton_magic_level = data:unpack('H',0x79)
    end
end
gearswap.parse.i[0x01D] = function (data)
    --gearswap.refresh_globals()
    for i,bag in pairs(gearswap.res.bags) do
        local bag_name = gearswap.to_windower_bag_api(bag.en)
        if gearswap.items[bag_name] then gearswap.player[bag_name] = gearswap.refresh_item_list(gearswap.items[bag_name]) end
    end
    if not loaded then
        loaded = true
        include("SMDinclude/includes/Include.lua")
        if auto_ring and check_ring_buff() then
            schedule_xpcp_ring()
        end
    end
end
if not loaded then
    mf = {}
    return
end
include_setup()
--Saved Variable Recovery ---------------------------------------------------------------------------------------------------------
if gearswap.pathsearch({'SMDinclude/includes/map.lua'}) and gearswap.pathsearch({'SMDinclude/includes/extra.lua'}) then
    include('SMDinclude/includes/map.lua')
    include('SMDinclude/includes/extra')
else
    error("Must Have includes/map.lua and includes/extra.lua To Use This Include")
    return
end
if gearswap.pathsearch({'Saves/job_'..player.main_job..'var.lua'}) then
    include('Saves/job_'..player.main_job..'var.lua')
end

----Include functions-------------------------------------------------------------------------------------------------------------
function gear_equip_check(tab,event)
    if type(tab) == "table" and tab.type and S{"WeaponSkill","Samba","Waltz"}:contains(tab.type) and event == "precast" then
        return false
    end
    return true
end
function gear_equip(tab,event)
    sets.building[event] = sets[player.status]
    if sets.armor[armor_types[armor_types_count]] then
        sets.building[event] = set_combine(sets.building[event], sets.armor[armor_types[armor_types_count]])
    end
    if gear_equip_check(tab,event) then
        if sets.weapon[weapon_types[weapon_types_count]] then
            sets.building[event] = set_combine(sets.building[event], sets.weapon[weapon_types[weapon_types_count]])
        end
        if sets.range[range_types[range_types_count]] then
            sets.building[event] = set_combine(sets.building[event], sets.range[range_types[range_types_count]])
        end
    end
end
function run_event(status,a,b,c)
    local event = _global.current_event sets.building[event] = nil gear_equip(a,event)
    if type(a) == "table" and sets[event] then
        local types = {'action_type','skill',--[['type',]]'name'}
        for i=1,#types do 
            if sets[event][a[types[i]]] then
                sets.building[event] = set_combine(sets.building[event], sets[event][a[types[i]]])
            end
        end
    end
    for i, v in ipairs({"fdebug","s_weapon","ninja_wheel","ammo","msi","conq_gear","extra","mji","sji","WS_Gear","e_obi","mf"}) do
        if _G[v] and _G[v][event] then
            _G[v][event](status,event,a,b,c) end
        if S{"filtered_action","pretarget","precast"}:contains(event) and status.end_spell then
            cancel_spell()
        end
        if status.end_event then
            return
        end
    end
    if gearchang_stopper(spell) then
        return
    elseif not status.stop_swapping_gear then
        if not event == "pet_change" then
            local z = (type(a)=="table" and _G[a.type..'_'..event..'_equip_delay'] or nil)
        end
        if z and z >= 0 then
            c_equip(z, sets.building[event], event)
        else
            equip(sets.building[event])
        end
    end
end
function add_gear_modes(tbl,tbl_append)
    local sorted = T(tbl):keyset():sort()
    for i = 1,#sorted do
        _G[tbl_append]:append(sorted[i])
    end
end
----Gearswap basic functions------------------------------------------------------------------------------------------------------
function get_sets()
    gear_setup()
    add_gear_modes(sets.weapon,'weapon_types')
    add_gear_modes(sets.range,'range_types')
    add_gear_modes(sets.armor,'armor_types')
    for _,l in ipairs({"weapon_types","range_types","armor_types","rings","skill"}) do
        local name = (l == "skill" and reg_event.skill_type or _G[l])
        if _G[l.."_save"] and name:contains(_G[l.."_save"]) then
            for c,n in ipairs(name) do
                if n == _G[l.."_save"] then
                    _G[l.."_count"] = c
                    break
                else
                    _G[l.."_count"] = 1
                end
            end
        end
    end
    if update_display then
        update_display()
    end
    if mf.file_load then
        mf.file_load()
    end
    if file_write and file_write.write then
        file_write.write()
    end
end
function filtered_action(spell)
    local status = {end_event=false,end_spell=false,stop_swapping_gear=true}
    if spell_stopper(spell) then
        cancel_spell()
    end
    run_event(status,spell)
end
function pretarget(spell)
    local status = {end_event=false,end_spell=false,stop_swapping_gear=true}
    if spell_stopper(spell) then
        cancel_spell()
    end
    if spell.name:endswith(" Key") or spell.name:endswith("カギ") then
        midaction(false)
    end
    run_event(status,spell)
end
function precast(spell)
    local status = {end_event=false,end_spell=false,stop_swapping_gear=false}
    if spell_stopper(spell) then
        cancel_spell()
        return
    end
    run_event(status,spell)
end
function midcast(spell)
    if spell.action_type == "Ability" then
        return
    end
    local status = {end_event=false,stop_swapping_gear=false}
    if gearchang_stopper(spell) then
        return
    end
    run_event(status,spell)
end
function aftercast(spell)
    local status = {end_event=false,stop_swapping_gear=false}
    if gearchang_stopper(spell) then
        return
    end
    run_event(status,spell)
    if player.in_combat and auto_use_shards then
        local a = T{'C.','Z.','A.','P.'}
        local b = T{'I','II','III','IV','V'}
        for i=1,#a do
            for i2=1,#b do
                if player.inventory[a[i]..' Ygg. Shard '..b[i2]] then
                    send_command('wait 3.0;input /item "'..a[i]..' Ygg. Shard '..b[i2]..'" <me>')
                end
            end
        end
    end
end
function status_change(new,old)
    local status = {end_event=false,stop_swapping_gear=false}
    if thfsub and player.main_job == "THF" and reg_event and not reg_event.treasure_hunter[player.target.id] then
        thief_sub = thieftype['hunter']
    end
    if new == "Idle" and reg_event and reg_event.clear_aggro_count then
        reg_event.clear_aggro_count:schedule(1.5)
        if updatedisplay then
            updatedisplay:schedule(1.5)
        end
    end
    run_event(status,new,old)
end
function pet_change(pet,gain)
    local status = {end_event=false,stop_swapping_gear=false}
    run_event(status,pet,gain)
end
function pet_midcast(spell)
    local status = {end_event=false,stop_swapping_gear=false}
    if gearchang_stopper(spell) then
        return
    end
    run_event(status,spell)
end
function pet_aftercast(spell)
    local status = {end_event=false,stop_swapping_gear=false}
    if gearchang_stopper(spell) then
        return
    end
    run_event(status,spell)
end
function pet_status_change(new,old)
    local status = {end_event=false,stop_swapping_gear=true}
    run_event(status,new,old)
end
function buff_change(name,gain,buff_table)
    local status = {end_event=false,stop_swapping_gear=true}
    if S{2,19}:contains(buff_table.id) then
        if gain then
            equip({neck="Opo-opo Necklace",back="Aries Mantle"})
            disable("neck","back")
        else
            enable("neck","back")
            equip(gear_equip(name,'buff_change'))
        end
    elseif buff_table.id == 582 then
        Contradance_potency = (gain and 100 or 0)
    elseif buff_table.id == 267 then
        allied_tags = (gain and true or false)
    elseif buff_table.id == 364 then
        Rapture = (gain and true or false)
    elseif buff_table.id == 78 then
        Divine_seal = (gain and true or false)
    elseif buff_table.id == 511 then
        Reive_mark = (gain and true or false)
    elseif buff_table.id == 257 then
        Besieged = (gain and true or false)
    end
    run_event(status,name,gain,buff_table)
end
function indi_change(indi_table,gain)
    local status = {end_event=false,stop_swapping_gear=true}
    run_event(status,indi_table,gain)
    if updatedisplay then
        updatedisplay()
    end
end
function sub_job_change(new,old)
    if file_write and file_write.write then
        file_write.write()
    end
    windower.prim.delete('window_button')
    include('SMDinclude/includes/map.lua')
    include('SMDinclude/includes/extra')
    if gearswap.pathsearch({'Saves/job_'..player.main_job..'var.lua'}) then
        include('Saves/job_'..player.main_job..'var.lua')
    end
    load_rings()
    get_sets()
end
function self_command(com)
    local status = {end_event=false,stop_swapping_gear=true}
    local comArgs = com
    if #comArgs:split(' ') >= 2 then
        comArgs = T(comArgs:split(' '))
    end
    run_event(status,comArgs)
    if file_write and file_write.write then
        file_write.write()
    end
    if updatedisplay then
        updatedisplay()
    end
end
function file_unload(new_job)
    if mf.file_unload then
        mf.file_unload(new_job)
    end
    if file_write and file_write.write then
        file_write.write()
    end
end
--Load includes------------------------------------------------------------------------------------------------------------------
load_include(MJi, 'mjob/main_job_'..player.main_job..'.lua')
load_include(SJi, 'sjob/sub_job_'..player.sub_job..'.lua')
load_include((MSi and jobs.magic:contains(player.main_job)), 'more/MSi.lua')
load_include((Ammo and jobs.ammo:contains(player.main_job)), 'more/Ammo.lua')
load_include(Special_Weapons, 'more/Special_Weapons.lua')
load_include(Conquest_Gear, 'more/Conquest_Gear.lua')
load_include(Registered_Events, 'more/Registered_Events.lua')
load_include(Debug, 'more/Debug.lua')
load_include(Display, 'more/Display.lua')
load_include(File_Write, 'more/File_Write.lua')
get_sets()