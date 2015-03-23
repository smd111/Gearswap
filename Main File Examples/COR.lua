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
    sets.weapon['Sword'] = {main="Eminent Scimitar",sub={ name="Firmament", augments={'Wind resistance-2 Earth resistance+2',}},}
    sets.weapon['None'] = {main=empty,sub=empty,}
    sets.range = {}
    sets.range['Marksmanship'] = {range="Eminent Gun",ammo="Bullet",}
    sets.armor['Basic'] = {}
    sets.Engaged = {
    head="Tema. Headband",
    body="Temachtiani Shirt",
    hands="Temachtiani Gloves",
    legs="Temachtiani Pants",
    feet="Temachtiani Boots",
    neck={ name="Wivre Gorget", augments={'"Subtle Blow"+4','MP+3',}},
    waist="Marid Belt",
    left_ear="Terminus Earring",
    right_ear="Suppanomimi",
    left_ring="Rajas Ring",
    right_ring="Prouesse Ring",
    back="Cerberus Mantle",
    }
    sets.Idle = {
    main="Eminent Scimitar",
    sub={ name="Firmament", augments={'Wind resistance-2 Earth resistance+2',}},
    range="Eminent Gun",
    ammo="Bullet",
    head="Tema. Headband",
    body="Temachtiani Shirt",
    hands="Temachtiani Gloves",
    legs="Temachtiani Pants",
    feet="Temachtiani Boots",
    neck={ name="Wivre Gorget", augments={'"Subtle Blow"+4','MP+3',}},
    waist="Marid Belt",
    left_ear="Terminus Earring",
    right_ear="Suppanomimi",
    left_ring="Rajas Ring",
    right_ring="Prouesse Ring",
    back="Cerberus Mantle",
    }
    sets.Resting = {
    main="Eminent Scimitar",
    sub={ name="Firmament", augments={'Wind resistance-2 Earth resistance+2',}},
    range="Eminent Gun",
    ammo="Bullet",
    head="Tema. Headband",
    body="Temachtiani Shirt",
    hands="Temachtiani Gloves",
    legs="Temachtiani Pants",
    feet="Temachtiani Boots",
    neck={ name="Wivre Gorget", augments={'"Subtle Blow"+4','MP+3',}},
    waist="Mrc.Cpt. Belt",
    left_ear="Terminus Earring",
    right_ear="Sanative Earring",
    left_ring="Rajas Ring",
    right_ring="Prouesse Ring",
    back="Cerberus Mantle",
    }
    send_command('lua load rolltracker')
end
function mf_file_unload(new_job)
    send_command('lua unload rolltracker')
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
    if spell.action_type == "Ranged Attack" then
        set_gear = set_combine(set_gear, {left_ring="Fistmele Ring",right_ring="Longshot Ring"})
    elseif spell.action_type == "Ability" then
        if spell.type == "CorsairRoll" then
            set_gear = set_combine(set_gear, {left_ring="Merirosvo Ring"})
        end
    end
    return set_gear
end
function mf_buff_change(status,set_gear,name,gain,buff_table)
    return set_gear
end
function mf_midcast(status,set_gear,spell)
    if spell.action_type == "Ranged Attack" then
        set_gear = set_combine(set_gear, {left_ring="Fistmele Ring",right_ring="Longshot Ring"})
    elseif spell.action_type == "Ability" then
        if spell.type == "CorsairRoll" then
            set_gear = set_combine(set_gear, {left_ring="Merirosvo Ring"})
        end
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