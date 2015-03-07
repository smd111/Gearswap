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
    sets.weapon['Dagger'] = {main="Eminent Dagger",sub={ name="Kartika", augments={'Attack+5',}},}
    sets.weapon['None'] = {main=empty,sub=empty,}
    -- add_weapon_modes = {'name1','name2'}
    sets.range = {}
    sets.range['Throwing'] = {range="Chakram",ammo=empty,}
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
    waist="Marid Belt",
    left_ear="Terminus Earring",
    right_ear="Suppanomimi",
    left_ring="Dasra's Ring",
    right_ring="Prouesse Ring",
    back="Cerberus Mantle",
    }
    sets.Idle = {
    main="Eminent Dagger",
    sub={ name="Kartika", augments={'Attack+5',}},
    head="Tema. Headband",
    body="Temachtiani Shirt",
    hands="Temachtiani Gloves",
    legs="Temachtiani Pants",
    feet="Temachtiani Boots",
    neck={ name="Wivre Gorget", augments={'"Subtle Blow"+4','MP+3',}},
    waist="Marid Belt",
    left_ear="Terminus Earring",
    right_ear="Suppanomimi",
    left_ring="Dasra's Ring",
    right_ring="Prouesse Ring",
    back="Cerberus Mantle",
    }
    sets.Resting = {
    main="Eminent Dagger",
    sub={ name="Kartika", augments={'Attack+5',}},
    range="Chakram",
    head="Tema. Headband",
    body="Temachtiani Shirt",
    hands="Temachtiani Gloves",
    legs="Temachtiani Pants",
    feet="Temachtiani Boots",
    neck={ name="Wivre Gorget", augments={'"Subtle Blow"+4','MP+3',}},
    waist="Marid Belt",
    left_ear="Terminus Earring",
    right_ear="Sanative Earring",
    left_ring="Dasra's Ring",
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
    if spell.type == 'Waltz' and  buffactive == 'saber dance' then
        send_command('cancel 410')
    elseif spell.type == 'Samba' and buffactive == 'fan dance' then
        send_command('cancel 411')
    elseif spell.english == 'Spectral Jig' then
        send_command('cancel 71')
    end
    if Waltz.spells:contains(spell.english) and spell.target.type == 'SELF' then
        if player.tp >= 200 and player.hpp >= 75 and has_any_buff_of(Waltz.debuff) and player.main_job_level >= 35 then
            if spell.english ~= 'Healing Waltz' then
                send_command('@input /ja "Healing Waltz" <me>')
                status.end_spell=true
                status.end_event=true
                return
            end
        elseif player.tp >= 800 and player.hpp <= 75 and player.main_job_level >= 87 then
            if spell.english ~= 'Curing Waltz V' then
                send_command('@input /ja "Curing Waltz V" <me>')
                status.end_spell=true
                status.end_event=true
                return
            end
        elseif player.tp >= 650 and player.hpp <= 75 and player.main_job_level >= 70 then
            if spell.english ~= 'Curing Waltz IV' then
                send_command('@input /ja "Curing Waltz IV" <me>')
                status.end_spell=true
                status.end_event=true
                return
            end
        elseif player.tp >= 500 and player.hpp <= 75 and player.main_job_level >= 45 then
            if spell.english ~= 'Curing Waltz III' then
                cancel_spell()
                send_command('@input /ja "Curing Waltz III" <me>')
                status.end_spell=true
                status.end_event=true
                return
            end
        elseif player.tp >= 350 and player.hpp <= 75 and player.main_job_level >= 30 then
            if spell.english ~= 'Curing Waltz II' then
                send_command('@input /ja "Curing Waltz II" <me>')
                status.end_spell=true
                status.end_event=true
                return
            end
        elseif player.tp >= 200 and player.hpp <= 75 and player.main_job_level >= 15 then
            if spell.english ~= 'Curing Waltz' then
                send_command('@input /ja "Curing Waltz" <me>')
                status.end_spell=true
                status.end_event=true
                return
            end
        else
            status.end_spell=true
            status.end_event=true
            return
        end
    end
    if spell.english == 'Spectral Jig' then
        send_command('cancel 71')
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