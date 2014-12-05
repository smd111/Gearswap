--[[How To Use:
    1. make sure that the files for this include setup is in the gearswap/data/<players name> directory
    2. to create a new job file just coppy this and rename it to the correct job name I.e. for Dancer name it DNC.lua
    3. add your gearsets in to function get_sets ware shown
    4. add rules to each function below ware shown
    5. your ready to use
    notes: i have included basic layouts for 3 gearsets Engaged,Idle,Resting]]
--include setup -------------------------------------------------------------------------------------------------------------------
function include_setup()
    --Disable All Includes (Default: false)
    Disable_All = false
    --Use Main Job includes (Default: true)
    MJi = true
    --Use Sub Job Includes (Default: true)
    SJi = true
    --Use Mage Stave Include (Default: true)
    MSi = true
    --Use Weapon Skill Include (Default: true)
    WSi = true
    --Use Ammo Include (Default: true)
    Ammo = true
    --Use Special_Weapons Include (Default: true)
    Special_Weapons = true
    --Use Conquest_Gear Include (Default: true)
    Conquest_Gear = true
    --Use File_Write Include (Default: true)
    File_Write = true
    --Use Registered_Events Include (Default: true)
    Registered_Events = true
    --Use Debug Include (Default: false)
    Debug = false
    --Use Display Include (Default: true)
    Display = true
    --Start with minimized window (Default: false)
    window_hidden = true
    -----------------------------------------------------------------------------------------------------------------------------------
    jobneck = {neck={ name="Magus Torque", augments={'MP+10','Mag. Acc.+1',}},} --if using the conquest include put the neck that you want as your main neck when conquest neck is not needed
    jobring = {left_ring="Onyx Ring",} --if using the conquest include put the left_ring that you want as your main ring when conquest ring is not needed
    -- example:
    -- jobneck = {neck={ name="Wivre Gorget", augments={'"Subtle Blow"+4','MP+3',}},}
    -- jobring = {left_ring="Prouesse Ring",}
end
include('includes/Extras.lua')
--Job functions
function gear_setup()
    sets.Engaged = {
    main="Eminent Lance",
    sub="Danger Grip",
    ammo="Fullmetal Bullet",
    head="Tema. Headband",
    body="Temachtiani Shirt",
    hands="Temachtiani Gloves",
    legs="Temachtiani Pants",
    feet="Temachtiani Boots",
    neck={ name="Wivre Gorget", augments={'"Subtle Blow"+4','MP+3',}},
    waist="Marid Belt",
    left_ear="Dragonkin Earring",
    right_ear="Terminus Earring",
    left_ring="Vehemence Ring",
    right_ring="Prouesse Ring",
    back="Cerberus Mantle",
    }
    sets.Idle = {
    main="Eminent Lance",
    sub="Danger Grip",
    ammo="Fullmetal Bullet",
    head="Tema. Headband",
    body="Temachtiani Shirt",
    hands="Temachtiani Gloves",
    legs="Temachtiani Pants",
    feet="Temachtiani Boots",
    neck={ name="Wivre Gorget", augments={'"Subtle Blow"+4','MP+3',}},
    waist="Marid Belt",
    left_ear="Dragonkin Earring",
    right_ear="Terminus Earring",
    left_ring="Vehemence Ring",
    right_ring="Prouesse Ring",
    back="Cerberus Mantle",
    }
    sets.Resting = {
    main="Eminent Lance",
    sub="Danger Grip",
    ammo="Fullmetal Bullet",
    head="Tema. Headband",
    body="Temachtiani Shirt",
    hands="Temachtiani Gloves",
    legs="Temachtiani Pants",
    feet="Temachtiani Boots",
    neck={ name="Wivre Gorget", augments={'"Subtle Blow"+4','MP+3',}},
    waist="Marid Belt",
    left_ear="Sanative Earring",
    right_ear="Terminus Earring",
    left_ring="Vehemence Ring",
    right_ring="Prouesse Ring",
    back="Cerberus Mantle",
    }
    sets.weapon = {}
    sets.weapon['Axe'] = {main="",sub="",}
    sets.weapon['Club'] = {main="",sub="",}
    sets.weapon['Dagger'] = {main="",sub="",}
    sets.weapon['Great_Axe'] = {main="",sub="",}
    sets.weapon['Great_Sword'] = {main="",sub="",}
    sets.weapon['Hand-to-Hand'] = {main="",sub="",}
    sets.weapon['Great_Katana'] = {main="",sub="",}
    sets.weapon['Katana'] = {main="",sub="",}
    sets.weapon['Polearm'] = {main="",sub="",}
    sets.weapon['Scythe'] = {main="",sub="",}
    sets.weapon['Staff'] = {main="",sub="",}
    sets.weapon['Sword'] = {main="",sub="",}
end
function mf_file_unload()
    return
end
function mf_status_change(new,old,status,set_gear)
    if new=='Engaged' then
        set_gear = set_combine(set_gear, sets.Engaged)
    elseif new=='Idle' then
        set_gear = set_combine(set_gear, sets.Idle)
    elseif new=='Resting' then
        set_gear = set_combine(set_gear, sets.Resting)
    end
    return set_gear
end
function mf_pet_change(pet,gain,status,set_gear)
    return
end
function mf_filtered_action(spell,status,set_gear)
    return
end
function mf_pretarget(spell,status,set_gear)
    return set_gear
end
function mf_precast(spell,status,set_gear)
    if pet.isvalid and spell.english == "Call Wyvern" then
        status.end_spell=true
        status.end_event=true
    end
    return set_gear
end
function mf_buff_change(name,gain)
    return
end
function mf_midcast(spell,status,set_gear)
    return set_gear
end
function mf_pet_midcast(spell,status,set_gear)
    return set_gear
end
function mf_aftercast(spell,status,set_gear)
    set_gear = set_combine(set_gear, sets[player.status])--you can change this
    return set_gear
end
function mf_pet_aftercast(spell,status,set_gear)
    set_gear = set_combine(set_gear, sets[player.status])
    return set_gear
end
function mf_self_command(command)
    return
end