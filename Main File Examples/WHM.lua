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
    sets.weapon['Staff'] = {main="Eminent Staff",sub="Danger Grip",}
    sets.weapon['None'] = {main=empty,sub=empty,}
    -- add_weapon_modes = {'name1','name2'}
    sets.range['Other'] = {range="",ammo="",}
    -- add_range_modes = {'name1','name2'}
    sets.armor['Basic'] = {}
    -- add_armor_modes = {'name1','name2'}
    sets.Engaged = {
    head="Tema. Headband",
    body="Temachtiani Shirt",
    hands="Temachtiani Gloves",
    legs="Temachtiani Pants",
    feet="Temachtiani Boots",
    neck={ name="Wivre Gorget", augments={'"Subtle Blow"+4','MP+3',}},
    waist={ name="Tarutaru Sash", augments={'CHR+2','INT+2','HP+15',}},
    left_ear="Liminus Earring",
    right_ear="Ardent Earring",
    left_ring="Rajas Ring",
    right_ring="Prouesse Ring",
    back="Jester's Cape",
    }
    sets.Idle = {
    head="Tema. Headband",
    body="Temachtiani Shirt",
    hands="Temachtiani Gloves",
    legs="Temachtiani Pants",
    feet="Temachtiani Boots",
    neck={ name="Wivre Gorget", augments={'"Subtle Blow"+4','MP+3',}},
    waist={ name="Tarutaru Sash", augments={'CHR+2','INT+2','HP+15',}},
    left_ear="Liminus Earring",
    right_ear="Ardent Earring",
    left_ring="Rajas Ring",
    right_ring="Prouesse Ring",
    back="Jester's Cape",
    }
    sets.Resting = {
    head="Tema. Headband",
    body="Temachtiani Shirt",
    hands="Temachtiani Gloves",
    legs="Temachtiani Pants",
    feet="Temachtiani Boots",
    neck={ name="Wivre Gorget", augments={'"Subtle Blow"+4','MP+3',}},
    waist={ name="Tarutaru Sash", augments={'CHR+2','INT+2','HP+15',}},
    left_ear="Liminus Earring",
    right_ear="Relaxing Earring",
    left_ring="Rajas Ring",
    right_ring="Prouesse Ring",
    back="Jester's Cape",
    }
    Curenegstat = false
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
    if Curenegstat then
        if name == 'blindness' then
            send_command('@input /ma "Blindna" <me>')
        elseif (name == 'curse' or name == 'bane') and gain then
            send_command('@input /ma "Cursna" <me>')
        elseif name == 'paralysis' and gain then
            send_command('@input /ma "Paralyna" <me>')
        elseif name == 'poison' and gain then
            send_command('@input /ma "Poisona" <me>')
        elseif name == 'petrification' and gain then
            send_command('@input /ma "Stona" <me>')
        elseif (name == 'disease' or name == 'plague') and gain then
            send_command('@input /ma "Viruna" <me>')
        end
    end
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
    if command == 'tcurenegstat' then
        Curenegstat = not Curenegstat
        add_to_chat(123,'----- WILL ' .. (Curenegstat and '' or 'NOT ') .. 'AUTO CURE NEGITAVE STATUS -----')
    end
    return
end