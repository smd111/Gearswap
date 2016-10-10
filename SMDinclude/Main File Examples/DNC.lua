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
    sets.weapon['Dagger'] = {main="Eminent Dagger",sub={ name="Kartika", augments={'Attack+5',}}}
    sets.weapon['None'] = {main=empty,sub=empty}
    sets.range['Throwing'] = {range="Chakram",ammo=empty}
    sets.armor['Basic'] = {}
    sets.armor['Capacity_Points'] = {back="Aptitude Mantle +1",}
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
function mf.file_load()
    if windower.ffxi.get_info().mog_house then
        send_command('gs org')
    end
end
function mf.precast(status,current_event,spell)
    if spell.type == 'Waltz' and spell.en:startswith('Curing Waltz') then
        if windower.ffxi.get_ability_recasts()[229] and windower.ffxi.get_ability_recasts()[229] < 1 then
            send_command('input /ja "'..res.job_abilities[384][gearswap.language]..'" <me>;wait 2;input /ja "'..spell.name..'" <me>')
            status.end_spell=true
            status.end_event=true
            return
        end
        if buffactive == 'saber dance' then
            send_command('cancel 410')
        end
    elseif spell.type == 'Samba' and buffactive == 'fan dance' then
        send_command('cancel 411')
    end
    if spell.action_type == "Ranged Attack" then
        sets.building[current_event] = set_combine(sets.building[current_event], {left_ring="Fistmele Ring",right_ring="Longshot Ring"})
    end
end
function mf.midcast(status,current_event,spell)
    if spell.action_type == "Ranged Attack" then
        sets.building[current_event] = set_combine(sets.building[current_event], {left_ring="Fistmele Ring",right_ring="Longshot Ring"})
    end
end