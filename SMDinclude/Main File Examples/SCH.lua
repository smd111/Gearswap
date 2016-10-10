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
    sets.weapon['Staff'] = {main="Elm Staff",sub="Tenax Strap"}
    sets.weapon['None'] = {main=empty,sub=empty}
    sets.range['Other'] = {range="",ammo=""}
    sets.armor['Basic'] = {}
    sets.armor['Capacity_Points'] = {back="Aptitude Mantle +1",}
    sets.Engaged = {
        body="Cmb.Cst. Cloak",
        hands="Cmb.Cst. Mitts",
        legs="Cmb.Cst. Slacks",
        feet="Cmb.Cst. Shoes",
        neck="Scholar's Torque",
        waist="Mrc.Cpt. Belt",
        left_ear="Ardent Earring",
        left_ring="Bastokan Ring",
        right_ring="Rajas Ring",
        back="White Cape",
        }
    sets.Idle = {
        body="Cmb.Cst. Cloak",
        hands="Cmb.Cst. Mitts",
        legs="Cmb.Cst. Slacks",
        feet="Cmb.Cst. Shoes",
        neck="Scholar's Torque",
        waist="Mrc.Cpt. Belt",
        left_ear="Ardent Earring",
        left_ring="Bastokan Ring",
        right_ring="Rajas Ring",
        back="White Cape",
        }
    sets.Resting = {
        body="Cmb.Cst. Cloak",
        hands="Cmb.Cst. Mitts",
        legs="Cmb.Cst. Slacks",
        feet="Cmb.Cst. Shoes",
        neck="Scholar's Torque",
        waist="Mrc.Cpt. Belt",
        left_ear="Ardent Earring",
        left_ring="Bastokan Ring",
        right_ring="Rajas Ring",
        back="White Cape",
        }
end
function mf.file_load()
    if windower.ffxi.get_info().mog_house then
        send_command('gs org')
    end
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