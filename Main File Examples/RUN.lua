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
    sets.weapon['Great_Axe'] = {main="Huge Moth Axe",sub="Tenax Strap",}
    sets.weapon['None'] = {main=empty,sub=empty,}
    sets.range['Other'] = {range="",ammo="",}
    sets.armor['Basic'] = {}
    sets.Engaged = {
    body="Cmb.Cst. Cloak",
    hands="Cmb.Cst. Mitts",
    legs="Cmb.Cst. Slacks",
    feet="Cmb.Cst. Shoes",
    waist="Mrc.Cpt. Belt",
    left_ear="Ardent Earring",
    left_ring="Rajas Ring",
    right_ring="Bastokan Ring",
    back="Invisible Mantle",
    }
    sets.Idle = {
    body="Cmb.Cst. Cloak",
    hands="Cmb.Cst. Mitts",
    legs="Cmb.Cst. Slacks",
    feet="Cmb.Cst. Shoes",
    left_ear="Ardent Earring",
    left_ring="Rajas Ring",
    right_ring="Bastokan Ring",
    back="Invisible Mantle",
    }
    sets.Resting = {
    body="Cmb.Cst. Cloak",
    hands="Cmb.Cst. Mitts",
    legs="Cmb.Cst. Slacks",
    feet="Cmb.Cst. Shoes",
    waist="Mrc.Cpt. Belt",
    left_ear="Ardent Earring",
    left_ring="Rajas Ring",
    right_ring="Bastokan Ring",
    back="Invisible Mantle",
    }
    Rune = {}
    Rune.spells = S{'Ignis','Gelus','Flabra','Sulpor','Unda','Lux','Tenebrae'}
end
function mf_file_unload(new_job)
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