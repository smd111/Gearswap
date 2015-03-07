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
    Changesumstaff = false --Togle with //gs c tchangeSMNstaff (true for change staves, false for do not change staves)
    Pettype = {}
    Pettype.Summon = {}
    Pettype.Summon.weapon = {
        ['None'] = {name="Eminent Pole"},
        ['Fire'] = {name="Atar III"},
        ['Ice'] = {name="Vourukasha III"},
        ['Wind'] = {name="Vayuvata III"},
        ['Earth'] = {name="Vishrava III"},
        ['Thunder'] = {name="Apamajas III"},
        ['Water'] = {name="Haoma III"},
        ['Light'] = {name="Arka III"},
        ['Dark'] = {name="Xsaeta III"},
    }
    pet_main = Pettype.Summon.weapon['None']
    sets.weapon['Staff'] = {main=pet_main,sub="Danger Grip",}
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
        waist="Mrc.Cpt. Belt",
        left_ear="Signal Pearl",
        right_ear="Ardent Earring",
        left_ring="Leather Ring",
        right_ring="Prouesse Ring"
    }
    sets.Idle = {
        head="Tema. Headband",
        body="Temachtiani Shirt",
        hands="Temachtiani Gloves",
        legs="Temachtiani Pants",
        feet="Temachtiani Boots",
        neck={ name="Wivre Gorget", augments={'"Subtle Blow"+4','MP+3',}},
        waist="Mrc.Cpt. Belt",
        left_ear="Signal Pearl",
        right_ear="Ardent Earring",
        left_ring="Leather Ring",
        right_ring="Prouesse Ring"
    }
    sets.Resting = {
        head="Tema. Headband",
        body="Temachtiani Shirt",
        hands="Temachtiani Gloves",
        legs="Temachtiani Pants",
        feet="Temachtiani Boots",
        neck={ name="Wivre Gorget", augments={'"Subtle Blow"+4','MP+3',}},
        waist="Mrc.Cpt. Belt",
        left_ear="Sanative Earring",
        right_ear="Ardent Earring",
        left_ring="Rajas Ring",
        right_ring="Prouesse Ring",
        back="Jester's Cape",
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
    if command == "tchangeSMNstaff" and Display then
        Changesumstaff = not Changesumstaff
    end
    return
end