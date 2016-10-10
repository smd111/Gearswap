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
    thieftype = {
        ['hunter'] = {name="Thief's Knife"},
        ['Dagger'] = {name="Peeler"},
    }
    thief_sub = thieftype['hunter']
    sets.weapon['Dagger'] = {main="Eminent Dagger",sub=thief_sub}
    sets.weapon['None'] = {main=empty,sub=empty}
    sets.range['Throwing'] = {range="Long Boomerang",ammo=""}
    sets.armor['Basic'] = {}
    sets.armor['Capacity_Points'] = {back="Aptitude Mantle +1",}
    sets.Engaged = {
        head="Wayfarer Circlet",
        body="Wayfarer Robe",
        hands="Wayfarer Cuffs",
        legs="Wayfarer Slops",
        feet="Wayfarer Clogs",
        neck={ name="Wivre Gorget", augments={'"Subtle Blow"+4','MP+3',}},
        waist="Marid Belt",
        left_ear="Zircon Earring",
        right_ear="Suppanomimi",
        left_ring="Enlivened Ring",
        right_ring="Vehemence Ring",
        back="Cerberus Mantle",
        }
    sets.Idle = {
        head="Wayfarer Circlet",
        body="Wayfarer Robe",
        hands="Wayfarer Cuffs",
        legs="Wayfarer Slops",
        feet="Wayfarer Clogs",
        neck={ name="Wivre Gorget", augments={'"Subtle Blow"+4','MP+3',}},
        waist="Marid Belt",
        left_ear="Zircon Earring",
        right_ear="Suppanomimi",
        left_ring="Enlivened Ring",
        right_ring="Vehemence Ring",
        back="Cerberus Mantle",
        }
    sets.Resting = {
        head="Wayfarer Circlet",
        body="Wayfarer Robe",
        hands="Wayfarer Cuffs",
        legs="Wayfarer Slops",
        feet="Wayfarer Clogs",
        neck={ name="Wivre Gorget", augments={'"Subtle Blow"+4','MP+3',}},
        waist="Marid Belt",
        left_ear="Sanative Earring",
        right_ear="Suppanomimi",
        left_ring="Enlivened Ring",
        right_ring="Vehemence Ring",
        back="Cerberus Mantle",
        }
end
function mf.file_load()
    send_command('lua load thtracker')
    if windower.ffxi.get_info().mog_house then
        send_command('gs org')
    end
end
function mf.file_unload(new_job)
    send_command('lua unload thtracker')
end
function mf.precast(status,current_event,spell)
    if spell.action_type == "Ranged Attack" then
        sets.building[current_event] = set_combine(sets.building[current_event], {left_ring="Fistmele Ring",right_ring="Longshot Ring"})
    end
end
function mf.midcast(status,current_event,spell)
    if spell.action_type == "Ranged Attack" then
        sets.building[current_event] = set_combine(sets.building[current_event], {left_ring="Fistmele Ring",right_ring="Longshot Ring"})
    end
end
function treasure_hunter_change(gain,th_count,name,target_table)
    if thfsub and gain and name == player.target.name then
        if thieftype[weapon_types[weapon_types_count]] then
            thief_sub = thieftype[weapon_types[weapon_types_count]]
        end
        if sets.weapon[weapon_types[weapon_types_count]] then
            equip(sets.weapon[weapon_types[weapon_types_count]])
        end
    end
end