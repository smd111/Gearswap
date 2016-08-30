--include setup -------------------------------------------------------------------------------------------------------------------
function include_setup()
    --Disable All Includes (Default: false)
    Disable_All = false
    --Use Display Include (Default: true)
    Display = true
    --Start with minimized window (Default: false)
    window_hidden = true
end
include('organizer-lib')
include('SMDinclude/includes/Include.lua')
--Job functions
function gear_setup()
    sets["Waltz"] = {} -- use this set for all Waltz
    sets.weapon['Katana'] = {main="Kaitsuburi",sub="Kakesu"}
    sets.weapon['None'] = {main=empty,sub=empty}
    sets.range['Throwing'] = {range="Chakram",ammo=empty}
    sets.range['Arrow'] = {range="Shortbow",ammo="Iron Arrow",}
    sets.armor['Basic'] = {}
    sets.armor['Capacity_Points'] = {back="Aptitude Mantle +1",}
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
function mf.file_load()
    if windower.ffxi.get_info().mog_house then
        send_command('gs org')
    end
end
function mf.file_unload(new_job)
end
function mf.status_change(status,current_event,new,old)
end
function mf.pet_change(status,current_event,pet,gain)
end
function mf.filtered_action(status,current_event,spell)
end
function mf.pretarget(status,current_event,spell)
end
function mf.precast(status,current_event,spell)
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
        sets.building[current_event] = set_combine(sets.building[current_event], {left_ring="Fistmele Ring",right_ring="Longshot Ring"})
    elseif spell.action_type == "Magic" then
        sets.building[current_event] = set_combine(sets.building[current_event], {left_ring="Acumen Ring",right_ring="Perception Ring"})
    end
end
function mf.buff_change(status,current_event,name,gain,buff_table)
end
function mf.midcast(status,current_event,spell)
    if spell.action_type == "Ranged Attack" then
        sets.building[current_event] = set_combine(sets.building[current_event], {left_ring="Fistmele Ring",right_ring="Longshot Ring"})
    elseif spell.action_type == "Magic" then
        sets.building[current_event] = set_combine(sets.building[current_event], {left_ring="Acumen Ring",right_ring="Perception Ring"})
    end
end
function mf.pet_midcast(status,current_event,spell)
end
function mf.aftercast(status,current_event,spell)
end
function mf.pet_aftercast(status,current_event,spell)
end
function mf.self_command(command)
end