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
    if dwsj() then
        sets.weapon['Sword'] = {main="Eminent Scimitar",sub={ name="Firmament", augments={'Wind resistance-2 Earth resistance+2',}}}
    end
    sets.weapon['None'] = {main=empty,sub=empty}
    sets.range['Marksmanship'] = {range="Eminent Gun",ammo="Bullet"}
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
        left_ring="Rajas Ring",
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
        left_ring="Rajas Ring",
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
        waist="Mrc.Cpt. Belt",
        left_ear="Terminus Earring",
        right_ear="Sanative Earring",
        left_ring="Rajas Ring",
        right_ring="Prouesse Ring",
        back="Cerberus Mantle",
        }
end
function mf.file_load()
    send_command('lua load rolltracker')
    if windower.ffxi.get_info().mog_house then
        send_command('gs org')
    end
end
function mf.file_unload(new_job)
    send_command('lua unload rolltracker')
end
function mf.precast(status,current_event,spell)
    if spell.action_type == "Ranged Attack" then
        sets.building[current_event] = set_combine(sets.building[current_event], {left_ring="Fistmele Ring",right_ring="Longshot Ring"})
    elseif spell.action_type == "Ability" then
        if spell.type == "CorsairRoll" then
            sets.building[current_event] = set_combine(sets.building[current_event], {left_ring="Merirosvo Ring"})
        end
    end
end
function mf.midcast(status,current_event,spell)
    if spell.action_type == "Ranged Attack" then
        sets.building[current_event] = set_combine(sets.building[current_event], {left_ring="Fistmele Ring",right_ring="Longshot Ring"})
    elseif spell.action_type == "Ability" then
        if spell.type == "CorsairRoll" then
            sets.building[current_event] = set_combine(sets.building[current_event], {left_ring="Merirosvo Ring"})
        end
    end
end