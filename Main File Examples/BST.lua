--include setup -------------------------------------------------------------------------------------------------------------------
function include_setup()
    --Disable All Includes (Default: false)
    Disable_All = false
    --Use Display Include (Default: true)
    Display = true
    --Start with minimized window (Default: false)
    window_hidden = true
end
include('includes/Include.lua')
--Job functions
function gear_setup()
    waltz_stats = {vit=64,chr=77} --these are the stats need to calulate curing waltz hp recovery
    sets.weapon['Axe'] = {main="Eminent Axe",sub="Eminent Dagger"}
    sets.weapon['None'] = {main=empty,sub=empty}
    sets.armor['Basic'] = {}
    sets.Engaged = {
    head="Tema. Headband",
    body="Temachtiani Shirt",
    hands="Temachtiani Gloves",
    legs="Temachtiani Pants",
    feet="Temachtiani Boots",
    neck={ name="Wivre Gorget", augments={'"Subtle Blow"+4','MP+3',}},
    waist="Koenigs Belt",
    left_ear="Terminus Earring",
    right_ear="Suppanomimi",
    left_ring="Rajas Ring",
    right_ring="Prouesse Ring",
    back="Invisible Mantle",
    }
    sets.Idle = {
    head="Tema. Headband",
    body="Temachtiani Shirt",
    hands="Temachtiani Gloves",
    legs="Temachtiani Pants",
    feet="Temachtiani Boots",
    neck={ name="Wivre Gorget", augments={'"Subtle Blow"+4','MP+3',}},
    waist="Koenigs Belt",
    left_ear="Terminus Earring",
    right_ear="Suppanomimi",
    left_ring="Rajas Ring",
    right_ring="Prouesse Ring",
    back="Invisible Mantle",
    }
    sets.Resting = {
    head="Tema. Headband",
    body="Temachtiani Shirt",
    hands="Temachtiani Gloves",
    legs="Temachtiani Pants",
    feet="Temachtiani Boots",
    neck={ name="Wivre Gorget", augments={'"Subtle Blow"+4','MP+3',}},
    waist="Koenigs Belt",
    left_ear="Terminus Earring",
    right_ear="Sanative Earring",
    left_ring="Rajas Ring",
    right_ring="Prouesse Ring",
    back="Invisible Mantle",
    }
end
function mf.file_load()
    send_command('lua load PetTP')
    if windower.ffxi.get_info().mog_house then
        send_command('org organize')
    end
end
function mf.file_unload(new_job)
    if not S{'BST','PUP','GEO','DRG','SMN'}:contains(new_job) then
        send_command('lua unload PetTP')
    end
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
    if spell.action_type == "Ranged Attack" then
        sets.building[current_event] = set_combine(sets.building[current_event], {left_ring="Fistmele Ring",right_ring="Longshot Ring"})
    end
end
function mf.buff_change(status,current_event,name,gain,buff_table)
end
function mf.midcast(status,current_event,spell)
    if spell.action_type == "Ranged Attack" then
        sets.building[current_event] = set_combine(sets.building[current_event], {left_ring="Fistmele Ring",right_ring="Longshot Ring"})
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