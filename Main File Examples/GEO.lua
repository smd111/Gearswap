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
    sets.weapon['Club'] = {main="Rose Wand",sub="Rose Wand",}
    sets.weapon['None'] = {main=empty,sub=empty,}
    sets.range['Handbells'] = {range="Matre Bell",ammo=empty,}
    sets.armor['Basic'] = {}
    sets.Engaged = {
    head="Tct.Mgc. Hat",
    body="Tct.Mgc. Coat",
    hands="Tct.Mgc. Cuffs",
    legs="Tct.Mgc. Slops",
    feet="Tct.Mgc. Pigaches",
    waist="Mrc.Cpt. Belt",
    left_ear="Ardent Earring",
    right_ear="Zircon Earring",
    left_ring="Rajas Ring",
    right_ring="Bastokan Ring",
    }
    sets.Idle = {
    head="Tct.Mgc. Hat",
    body="Tct.Mgc. Coat",
    hands="Tct.Mgc. Cuffs",
    legs="Tct.Mgc. Slops",
    feet="Tct.Mgc. Pigaches",
    waist="Mrc.Cpt. Belt",
    left_ear="Ardent Earring",
    right_ear="Zircon Earring",
    left_ring="Rajas Ring",
    right_ring="Bastokan Ring",
    }
    sets.Resting = {
    head="Tct.Mgc. Hat",
    body="Tct.Mgc. Coat",
    hands="Tct.Mgc. Cuffs",
    legs="Tct.Mgc. Slops",
    feet="Tct.Mgc. Pigaches",
    waist="Mrc.Cpt. Belt",
    left_ear="Ardent Earring",
    right_ear="Zircon Earring",
    left_ring="Rajas Ring",
    right_ring="Bastokan Ring",
    }
    --send_command('@lua load PetTP')
end
function mf_file_unload(new_job)
    --send_command('@lua unload PetTP')
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
    elseif spell.action_type == "Magic" then
        set_gear = set_combine(set_gear, {left_ring="Acumen Ring",right_ring="Perception Ring"})
    end
    return set_gear
end
function mf_buff_change(status,set_gear,name,gain,buff_table)
    return set_gear
end
function mf_midcast(status,set_gear,spell)
    if spell.action_type == "Ranged Attack" then
        set_gear = set_combine(set_gear, {left_ring="Fistmele Ring",right_ring="Longshot Ring"})
    elseif spell.action_type == "Magic" then
        set_gear = set_combine(set_gear, {left_ring="Acumen Ring",right_ring="Perception Ring"})
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
function mf_indi_change(indi_table,gain,status,set_gear)
    return set_gear
end