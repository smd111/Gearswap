--include setup -------------------------------------------------------------------------------------------------------------------
function include_setup()
    --Disable All Includes (Default: false)
    Disable_All = false
    --Use Display Include (Default: true)
    Display = true
    --Start with minimized window (Default: false)
    window_hidden = true
    -----------------------------------------------------------------------------------------------------------------------------------
    jobneck = {neck={ name="Wivre Gorget", augments={'"Subtle Blow"+4','MP+3',}},} --if using the conquest include put the neck that you want as your main neck when conquest neck is not needed
    jobring = {left_ring="Enlivened Ring",} --if using the conquest include put the left_ring that you want as your main ring when conquest ring is not needed
end
include('includes/Include.lua')
--Job functions
function gear_setup()
    sets.weapon['Axe'] = {main="Eminent Axe",sub="Eminent Scimitar",}
    sets.weapon['Dagger'] = {main="Eminent Dagger",sub="Eminent Scimitar",}
    sets.weapon['Great_Axe'] = {main="Eminent Voulge",sub="Uther's Grip",}
    sets.weapon['Great_Sword'] = {main="Eminent Sword",sub="Uther's Grip",}
    sets.weapon['Hand-to-Hand'] = {main="Em. Baghnakhs",}
    sets.weapon['Scythe'] = {main="Eminent Sickle",sub="Uther's Grip",}
    sets.weapon['Sword'] = {main="Eminent Scimitar",sub="Eminent Dagger",}
    sets.weapon['None'] = {main=empty,sub=empty,}
    -- add_weapon_modes = {'name1','name2'}
    sets.range = {}
    sets.range['Marksmanship'] = {range="Lion Crossbow",ammo="",}
    sets.range['Throwing'] = {range="Snakeeye",ammo=empty,}
    -- add_range_modes = {'name1','name2'}
    sets.armor['Basic'] = {}
    -- add_armor_modes = {'name1','name2'}
    sets.Engaged = {
    head="Outrider Mask",
    body="Outrider Mail",
    hands="Outrider Mittens",
    legs="Outrider Hose",
    feet="Outrider Greaves",
    neck={ name="Wivre Gorget", augments={'"Subtle Blow"+4','MP+3',}},
    waist="Marid Belt",
    left_ear="Impreg. Earring",
    right_ear="Upsurge Earring",
    left_ring="Enlivened Ring",
    right_ring="Vehemence Ring",
    back="Cerberus Mantle",
    }
    sets.Idle = {
    head="Outrider Mask",
    body="Outrider Mail",
    hands="Outrider Mittens",
    legs="Outrider Hose",
    feet="Outrider Greaves",
    neck={ name="Wivre Gorget", augments={'"Subtle Blow"+4','MP+3',}},
    waist="Marid Belt",
    left_ear="Impreg. Earring",
    right_ear="Upsurge Earring",
    left_ring="Enlivened Ring",
    right_ring="Vehemence Ring",
    back="Cerberus Mantle",
    }
    sets.Resting = {
    head="Outrider Mask",
    body="Outrider Mail",
    hands="Outrider Mittens",
    legs="Outrider Hose",
    feet="Outrider Greaves",
    neck={ name="Wivre Gorget", augments={'"Subtle Blow"+4','MP+3',}},
    waist="Marid Belt",
    left_ear="Sanative Earring",
    right_ear="Upsurge Earring",
    left_ring="Enlivened Ring",
    right_ring="Vehemence Ring",
    back="Cerberus Mantle",
    }
end
function mf_file_unload(new_job)
    return
end
function mf_status_change(new,old,status,set_gear)
    return set_gear
end
function mf_pet_change(pet,gain,status,set_gear)
    return set_gear
end
function mf_filtered_action(spell,status,set_gear)
    return set_gear
end
function mf_pretarget(spell,status,set_gear)
    return set_gear
end
function mf_precast(spell,status,set_gear)
    return set_gear
end
function mf_buff_change(name,gain,buff_table)
    return set_gear
end
function mf_midcast(spell,status,set_gear)
    return set_gear
end
function mf_pet_midcast(spell,status,set_gear)
    return set_gear
end
function mf_aftercast(spell,status,set_gear)
    return set_gear
end
function mf_pet_aftercast(spell,status,set_gear)
    return set_gear
end
function mf_self_command(command)
    return
end