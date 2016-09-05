--include setup -------------------------------------------------------------------------------------------------------------------
function include_setup()
    --Disable All Includes (Default: false)
    Disable_All = false
    --Use Display Include (Default: true)
    Display = true
    --Start with minimized window (Default: false)
    window_hidden = true
    --WeaponSkill after cast equip delay (Default: 2)
    WeaponSkill_aftercast_equip_delay = 2
end
include('organizer-lib')
include('SMDinclude/includes/Include.lua')
--Job functions
function gear_setup()
    sets["Waltz"] = {} -- use this set for Waltz
    if dwsj() then
        sets.weapon['Axe'] = {main="Eminent Axe",sub="Eminent Scimitar"}
        sets.weapon['Dagger'] = {main="Eminent Dagger",sub="Eminent Scimitar"}
        sets.weapon['Sword'] = {main="Eminent Scimitar",sub="Eminent Dagger"}
    end
    sets.weapon['Great_Axe'] = {main="Eminent Voulge",sub="Uther's Grip"}
    sets.weapon['Great_Sword'] = {main="Eminent Sword",sub="Uther's Grip"}
    sets.weapon['Hand-to-Hand'] = {main="Em. Baghnakhs",ammo=empty}
    sets.weapon['Scythe'] = {main="Eminent Sickle",sub="Uther's Grip"}
    sets.weapon['None'] = {main=empty,sub=empty}
    sets.weapon['Great_Axe Su2'] = {main="Blurred Cleaver",sub="Uther's Grip"}
    sets.range['Marksmanship'] = {range="Lion Crossbow",ammo="Crossbow Bolt"}
    sets.range['Throwing'] = {range="Snakeeye",ammo=empty}
    sets.armor['Basic'] = {}
    sets.armor['Capacity_Points'] = {back="Aptitude Mantle +1",}
    sets.Engaged = {
        head="Gefechtschaller",
        body="Gefechtbrust",
        hands="Gefechthentzes",
        legs="Gefechtdiechlings",
        feet="Gefechtschuhs",
        neck={ name="Wivre Gorget", augments={'"Subtle Blow"+4','MP+3',}},
        waist="Marid Belt",
        left_ear="Impreg. Earring",
        right_ear="Upsurge Earring",
        left_ring="Enlivened Ring",
        right_ring="Vehemence Ring",
        back="Cerberus Mantle",
        }
    sets.Idle = {
        head="Gefechtschaller",
        body="Gefechtbrust",
        hands="Gefechthentzes",
        legs="Gefechtdiechlings",
        feet="Gefechtschuhs",
        neck={ name="Wivre Gorget", augments={'"Subtle Blow"+4','MP+3',}},
        waist="Marid Belt",
        left_ear="Impreg. Earring",
        right_ear="Upsurge Earring",
        left_ring="Enlivened Ring",
        right_ring="Vehemence Ring",
        back="Cerberus Mantle",
        }
    sets.Resting = {
        head="Gefechtschaller",
        body="Gefechtbrust",
        hands="Gefechthentzes",
        legs="Gefechtdiechlings",
        feet="Gefechtschuhs",
        neck={ name="Wivre Gorget", augments={'"Subtle Blow"+4','MP+3',}},
        waist="Marid Belt",
        left_ear="Sanative Earring",
        right_ear="Upsurge Earring",
        left_ring="Enlivened Ring",
        right_ring="Vehemence Ring",
        back="Cerberus Mantle",
        }
    sets.pretarget["Tomahawk"] = {range=empty,ammo="Thr. Tomahawk"}
    sets.precast["Mighty Strikes"] = {hands="Agoge Mufflers +1"}
    sets.precast["Berserk"] = {body="Pumm. Lorica +1",feet="Agoge Calligae +1"}
    sets.precast["Warcry"] = {head="Agoge Mask +1"}
    sets.precast["Aggressor"] = {head="Pumm. Mask +1",body="Agoge Lorica +1"}
    sets.precast["Retaliation"] = {hands="Pumm. Mufflers +1",feet="Boii Calligae +1"}
    sets.precast["Warrior's Charge"] = {legs="Agoge Cuisses +1"}
    sets.precast["Tomahawk"] = {range=empty,ammo="Thr. Tomahawk",feet="Agoge Calligae +1"}
    sets.precast["Restraint"] = {hands="Boii Mufflers +1"}
    sets.precast["Blood Rage"] = {body="Boii Lorica +1"}
    -- organizer_items = {}
end
function mf.file_load()
    if windower.ffxi.get_info().mog_house then
        send_command('gs org')
    end
end
function mf.file_unload(new_job)
end
function mf.status_change(status,current_event,new,old)
end
function mf.filtered_action(status,current_event,spell)
end
function mf.pretarget(status,current_event,spell)
    if spell.en == "Provoke" and player.sub_job == "DNC" and not check_recast('ability',spell.recast_id) then
        status.end_event=true status.end_spell=true
        send_command('input /ja "Animated Flourish" <t>')
    end
    if spell.en == 'Spectral Jig' then
        send_command('cancel 71')
    end
end
function mf.precast(status,current_event,spell)
    if spell.action_type == "Ranged Attack" then
        sets.building[current_event] = set_combine(sets.building[current_event], {left_ring="Fistmele Ring",right_ring="Longshot Ring"})
    end
    local t = windower.ffxi.get_mob_by_target('t')
end
function mf.buff_change(status,current_event,name,gain,buff_table)
end
function mf.midcast(status,current_event,spell)
    if spell.action_type == "Ranged Attack" then
        sets.building[current_event] = set_combine(sets.building[current_event], {left_ring="Fistmele Ring",right_ring="Longshot Ring"})
    end
end
function mf.aftercast(status,current_event,spell)
end
function mf.self_command(status,current_event,command)
end
function mf.zone_change(new,old)
end