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
    sets.weapon['Club'] = {main="Eminent Wand",sub="Eminent Scimitar"}
    sets.weapon['Sword'] = {main="Eminent Scimitar",sub="Eminent Wand"}
    sets.weapon['Reserve'] = {main="Hannibal's Sword",sub="Firmament"}
    sets.weapon['None'] = {main=empty,sub=empty}
    sets.range['Throwing'] = {range="Chakram",ammo=empty}
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
        right_ear="Impreg. Earring",
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
        left_ear="Suppanomimi",
        right_ear="Impreg. Earring",
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
        right_ear="Relaxing Earring",
        left_ring="Enlivened Ring",
        right_ring="Vehemence Ring",
        back="Cerberus Mantle",
        }
end
function mf.file_load()
    send_command('lua load azuresets')
    if windower.ffxi.get_info().mog_house then
        send_command('gs org')
    end
end
function mf.file_unload(new_job)
    send_command('lua unload azuresets')
end
function mf.precast(status,current_event,spell)
    if spell.action_type == "Ranged Attack" then
        sets.building[current_event] = set_combine(sets.building[current_event], {left_ring="Fistmele Ring",right_ring="Longshot Ring"})
    elseif spell.action_type == "Magic" then
        sets.building[current_event] = set_combine(sets.building[current_event], {left_ring="Acumen Ring",right_ring="Perception Ring"})
    end
end
function mf.midcast(status,current_event,spell)
    if spell.action_type == "Ranged Attack" then
        sets.building[current_event] = set_combine(sets.building[current_event], {left_ring="Fistmele Ring",right_ring="Longshot Ring"})
    elseif spell.action_type == "Magic" then
        sets.building[current_event] = set_combine(sets.building[current_event], {left_ring="Acumen Ring",right_ring="Perception Ring"})
    end
end