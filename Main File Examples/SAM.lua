--include setup -------------------------------------------------------------------------------------------------------------------
function include_setup()
    --Disable All Includes (Default: false)
    Disable_All = false
    --Use Display Include (Default: true)
    Display = true
    --Start with minimized window (Default: false)
    window_hidden = true
end
include('includes/Include.lua')
--Job functions
function gear_setup()
    sets.weapon['Great_Katana'] = {main="Ichimonji-Yofusa",sub="Danger Grip",}
    sets.weapon['None'] = {main=empty,sub=empty,}
    sets.range = {}
    sets.range['Archery'] = {range="Shortbow",ammo="Iron Arrow",}
    sets.armor['Basic'] = {}
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
    left_ring="Vehemence Ring",
    right_ring="Enlivened Ring",
    back="Unkai Sugemino",
    }
    sets.Idle = {
    head="Outrider Mask",
    body="Outrider Mail",
    hands="Outrider Mittens",
    legs="Outrider Hose",
    feet="Danzo Sune-Ate",
    neck={ name="Wivre Gorget", augments={'"Subtle Blow"+4','MP+3',}},
    waist="Marid Belt",
    left_ear="Impreg. Earring",
    right_ear="Upsurge Earring",
    left_ring="Vehemence Ring",
    right_ring="Enlivened Ring",
    back="Unkai Sugemino",
    }
    sets.Resting = {
    head="Outrider Mask",
    body="Outrider Mail",
    hands="Outrider Mittens",
    legs="Outrider Hose",
    feet="Danzo Sune-Ate",
    neck={ name="Wivre Gorget", augments={'"Subtle Blow"+4','MP+3',}},
    waist="Marid Belt",
    left_ear="Sanative Earring",
    right_ear="Terminus Earring",
    left_ring="Vehemence Ring",
    right_ring="Enlivened Ring",
    back="Unkai Sugemino",
    }
end
function mf_file_unload(new_job)
    return
end
function mf_status_change(status,set_gear,new,old)
    return set_gear
end
function mf_pet_change(status,set_gear,pet,gain)
    return set_gear
end
function mf_filtered_action(status,set_gear,spell)
    return set_gear
end
function mf_pretarget(status,set_gear,spell)
    return set_gear
end
function mf_precast(status,set_gear,spell)
    if spell.en == 'Meditate' and (player.tp >= 2750 or buffactive['Invisible']) then
        status.end_spell=true
        status.end_event=true
        return set_gear
    end
    if spell.action_type == "Ranged Attack" then
        set_gear = set_combine(set_gear, {left_ring="Fistmele Ring",right_ring="Longshot Ring"})
    end
    return set_gear
end
function mf_buff_change(status,set_gear,name,gain,buff_table)
    return set_gear
end
function mf_midcast(status,set_gear,spell)
    if spell.action_type == "Ranged Attack" then
        set_gear = set_combine(set_gear, {left_ring="Fistmele Ring",right_ring="Longshot Ring"})
    end
    return set_gear
end
function mf_pet_midcast(status,set_gear,spell)
    return set_gear
end
function mf_aftercast(status,set_gear,spell)
    return set_gear
end
function mf_pet_aftercast(status,set_gear,spell)
    return set_gear
end
function mf_self_command(command)
    return
end