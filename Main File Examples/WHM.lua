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
    sets.weapon['Staff'] = {main="Eminent Staff",sub="Danger Grip",}
    sets.weapon['None'] = {main=empty,sub=empty,}
    sets.range['Other'] = {range="",ammo="",}
    sets.armor['Basic'] = {}
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
    if command == 'tcurenegstat' then
        Curenegstat = not Curenegstat
        add_to_chat(123,'----- WILL ' .. (Curenegstat and '' or 'NOT ') .. 'AUTO CURE NEGITAVE STATUS -----')
    end
    return
end