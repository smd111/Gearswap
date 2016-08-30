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
    sets.weapon['Staff'] = {main=pet_main,sub="Danger Grip"}
    sets.weapon['None'] = {main=empty,sub=empty}
    sets.range['Other'] = {range="",ammo=""}
    sets.armor['Basic'] = {}
    sets.armor['Capacity_Points'] = {back="Aptitude Mantle +1",}
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
function mf.file_load()
    send_command('lua load PetTP')
    if windower.ffxi.get_info().mog_house then
        send_command('gs org')
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
    if Changesumstaff then
		if gain then
			pet_main.name = Pettype.Summon.weapon[pet.element].name
		else
			pet_main.name = Pettype.Summon.weapon["None"].name
		end
	end
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
    if command == "tchangeSMNstaff" then
        Changesumstaff = not Changesumstaff
        if Changesumstaff then
            pet_main.name = Pettype.Summon.weapon[pet.element].name
        else
            pet_main.name = Pettype.Summon.weapon["None"].name
        end
    end
end
function mf.save()
    local save = '\nChangesumstaff = '..tostring(Changesumstaff or false)..''
    return save
end