--include setup -------------------------------------------------------------------------------------------------------------------
function include_setup()
    --Disable All Includes (Default: false)
    Disable_All = false
    --Use Display Include (Default: true)
    Display = true
    --Start with minimized window (Default: false)
    window_hidden = true
    -----------------------------------------------------------------------------------------------------------------------------------
    jobneck = {neck={ name="Magus Torque", augments={'MP+10','Mag. Acc.+1',}},} --if using the conquest include put the neck that you want as your main neck when conquest neck is not needed
    jobring = {left_ring="Onyx Ring",} --if using the conquest include put the left_ring that you want as your main ring when conquest ring is not needed
end
include('includes/Include.lua')
--Job functions
function gear_setup()
    sets.weapon['Katana'] = {main="",sub="",}
    sets.weapon['None'] = {main=empty,sub=empty,}
    -- add_weapon_modes = {'name1','name2'}
    sets.range['Throwing'] = {range="Chakram",ammo=empty,}
    -- add_range_modes = {'name1','name2'}
    sets.armor['Basic'] = {}
    -- add_armor_modes = {'name1','name2'}
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