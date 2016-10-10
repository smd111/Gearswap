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
        sets.weapon['Dagger'] = {main="Eminent Dagger",sub="Eminent Axe"}
    end
    sets.weapon['None'] = {main=empty,sub=empty}
    sets.range = {}
    sets.range['Archery'] = {range="Eminent Bow",ammo="Iron Arrow"}
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
        left_ear="Suppanomimi",
        right_ear="Terminus Earring",
        left_ring="Vehemence Ring",
        right_ring="Enlivened Ring",
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
        left_ear="Suppanomimi",
        right_ear="Terminus Earring",
        left_ring="Vehemence Ring",
        right_ring="Enlivened Ring",
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
        right_ear="Terminus Earring",
        left_ring="Vehemence Ring",
        right_ring="Enlivened Ring",
        back="Cerberus Mantle",
        }
    --send_command('lua load AutoRA')
end
function mf.file_load()
    if windower.ffxi.get_info().mog_house then
        send_command('gs org')
    end
end
function mf.file_unload(new_job)
    --send_command('lua unload AutoRA')
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