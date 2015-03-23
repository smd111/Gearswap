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
    sets.weapon['Katana'] = {main="",sub="",}
    sets.weapon['None'] = {main=empty,sub=empty,}
    sets.range['Throwing'] = {range="Chakram",ammo=empty,}
    sets.armor['Basic'] = {}
    sets.Engaged = {
        head="Aurore Beret",
        body="Aurore Doublet",
        hands="Aurore Gloves",
        legs="Aurore Brais",
        feet="Aurore Gaiters",
        neck="Ninja Shusa",
        waist="Silver Mog. Belt",
        left_ear="Terminus Earring",
        right_ear="Liminus Earring",
        left_ring="Bastokan Ring",
        right_ring="Prouesse Ring",
        back="Cerberus Mantle",
    }
    sets.Idle = {
        head="Aurore Beret",
        body="Aurore Doublet",
        hands="Aurore Gloves",
        legs="Aurore Brais",
        feet="Danzo Sune-Ate",
        neck="Ninja Shusa",
        waist="Silver Mog. Belt",
        left_ear="Terminus Earring",
        right_ear="Liminus Earring",
        left_ring="Bastokan Ring",
        right_ring="Prouesse Ring",
        back="Cerberus Mantle",
    }
    sets.Resting = {
        head="Aurore Beret",
        body="Aurore Doublet",
        hands="Aurore Gloves",
        legs="Aurore Brais",
        feet="Danzo Sune-Ate",
        neck="Ninja Shusa",
        waist="Silver Mog. Belt",
        left_ear="Sanative Earring",
        right_ear="Liminus Earring",
        left_ring="Bastokan Ring",
        right_ring="Prouesse Ring",
        back="Cerberus Mantle",
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
    if spell.english == 'Utsusemi: Ichi' then
        if buffactive['Copy Image'] then
            send_command('cancel 66')
        elseif buffactive['Copy Image (2)'] then 
            send_command('cancel 444')
        elseif buffactive['Copy Image (3)'] then
            send_command('cancel 445')
        elseif buffactive['Copy Image (4+)'] then
            send_command('cancel 446')
        end
    elseif spell.english == 'Utsusemi: Ni' then
        if buffactive['Copy Image'] then
            send_command('cancel 66')
        elseif buffactive['Copy Image (2)'] then 
            send_command('cancel 444')
        elseif buffactive['Copy Image (3)'] then
            send_command('cancel 445')
        elseif buffactive['Copy Image (4+)'] then
            send_command('cancel 446')
        end
    end
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