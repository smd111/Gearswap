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
    sets.weapon['Club'] = {main="Eminent Wand",sub="Eminent Scimitar",}
    sets.weapon['Sword'] = {main="Eminent Scimitar",sub="Eminent Wand",}
    sets.weapon['Reserve'] = {main="Hannibal's Sword",sub="Firmament",}
    sets.weapon['None'] = {main=empty,sub=empty,}
    sets.range['Throwing'] = {range="Chakram",ammo=empty,}
    sets.armor['Basic'] = {}
    sets.Engaged = {
    head="Wayfarer Circlet",
    body="Wayfarer Robe",
    hands="Wayfarer Cuffs",
    legs="Wayfarer Slops",
    feet="Wayfarer Clogs",
    neck={ name="Wivre Gorget", augments={'"Subtle Blow"+4','MP+3',}},
    waist="Marid Belt",
    left_ear="Suppanomimi",
    right_ear="Impreg. Earring",
    left_ring="Enlivened Ring",
    right_ring="Vehemence Ring",
    back="Cerberus Mantle",
    }
    sets.Idle = {
    head="Wayfarer Circlet",
    body="Wayfarer Robe",
    hands="Wayfarer Cuffs",
    legs="Wayfarer Slops",
    feet="Wayfarer Clogs",
    neck={ name="Wivre Gorget", augments={'"Subtle Blow"+4','MP+3',}},
    waist="Marid Belt",
    left_ear="Suppanomimi",
    right_ear="Impreg. Earring",
    left_ring="Enlivened Ring",
    right_ring="Vehemence Ring",
    back="Cerberus Mantle",
    }
    sets.Resting = {
    head="Wayfarer Circlet",
    body="Wayfarer Robe",
    hands="Wayfarer Cuffs",
    legs="Wayfarer Slops",
    feet="Wayfarer Clogs",
    neck={ name="Wivre Gorget", augments={'"Subtle Blow"+4','MP+3',}},
    waist="Marid Belt",
    left_ear="Sanative Earring",
    right_ear="Relaxing Earring",
    left_ring="Enlivened Ring",
    right_ring="Vehemence Ring",
    back="Cerberus Mantle",
    }
    send_command('lua load azuresets')
end
function mf_file_unload(new_job)
    send_command('lua unload azuresets')
    return
end
function mf_status_change(status,set_gear,event_type,new,old)
    return set_gear
end
function mf_pet_change(status,set_gear,event_type,pet,gain)
    return set_gear
end
function mf_filtered_action(status,set_gear,event_type,spell)
    return set_gear
end
function mf_pretarget(status,set_gear,event_type,spell)
    return set_gear
end
function mf_precast(status,set_gear,event_type,spell)
    if spell.action_type == "Ranged Attack" then
        set_gear = set_combine(set_gear, {left_ring="Fistmele Ring",right_ring="Longshot Ring"})
    elseif spell.action_type == "Magic" then
        set_gear = set_combine(set_gear, {left_ring="Acumen Ring",right_ring="Perception Ring"})
    end
    return set_gear
end
function mf_buff_change(status,set_gear,event_type,name,gain,buff_table)
    return set_gear
end
function mf_midcast(status,set_gear,event_type,spell)
    if spell.action_type == "Ranged Attack" then
        set_gear = set_combine(set_gear, {left_ring="Fistmele Ring",right_ring="Longshot Ring"})
    elseif spell.action_type == "Magic" then
        set_gear = set_combine(set_gear, {left_ring="Acumen Ring",right_ring="Perception Ring"})
    end
    return set_gear
end
function mf_pet_midcast(status,set_gear,event_type,spell)
    return set_gear
end
function mf_aftercast(status,set_gear,event_type,spell)
    return set_gear
end
function mf_pet_aftercast(status,set_gear,event_type,spell)
    return set_gear
end
function mf_self_command(command)
    return
end