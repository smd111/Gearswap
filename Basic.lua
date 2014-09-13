include('includes/Extras.lua')
function get_sets()
	jobneck = ""
	jobring = ""
	sets.Engaged = {
		main="",
		sub="",
		head="",
		body="",
		hands="",
		legs="",
		feet="",
		neck="",
		waist="",
		left_ear="",
		right_ear="",
		left_ring="",
		right_ring="",
		back="",
		range="",
		ammo=""
	}
	sets.Idle = {
		main="",
		sub="",
		head="",
		body="",
		hands="",
		legs="",
		feet="",
		neck="",
		waist="",
		left_ear="",
		right_ear="",
		left_ring="",
		right_ring="",
		back="",
		range="",
		ammo=""
	}
	sets.Resting = {
		main="",
		sub="",
		head="",
		body="",
		hands="",
		legs="",
		feet="",
		neck="",
		waist="",
		left_ear="",
		right_ear="",
		left_ring="",
		right_ring="",
		back="",
		range="",
		ammo=""
	}
	if _G['updatedisplay'] then
		_G['updatedisplay']()
	end
end
function file_unload()
    if _G['file_unload_include'] then
		_G['file_unload_include']()
	end
end
function status_change(new,old)
	if _G['status_change_include'] then
		_G['status_change_include'](new,old)
	end
	if new=='Engaged' then
		equip(sets.Engaged)
	elseif new=='Idle' then
		equip(sets.Idle)
	elseif new=='Resting' then
		equip(sets.Resting)
	end
end
function pet_change(pet,gain)
	if _G['pet_change_include'] then
		_G['pet_change_include'](spell)
	end
end
function filtered_action(spell)
	if _G['filtered_action_include'] then
		_G['filtered_action_include'](spell)
	end
end
function pretarget(spell)
	if spell_stopper(spell) and not Disable_All then cancel_spell() return end
	if _G['pretarget_include'] then
		_G['pretarget_include'](spell)
	end
end
function precast(spell)
	if spell_stopper(spell) and not Disable_All then cancel_spell() return end
	if _G['precast_include'] then
		_G['precast_include'](spell)
	end
end
function buff_change(name,gain)
	if _G['sleepset'] then
		_G['sleepset'](name,gain)
	end
	if _G['buff_change_include'] then
		_G['buff_change_include'](name,gain)
	end
end
function midcast(spell)
	if gearchang_stopper(spell) and not Disable_All then return end
	if _G['midcast_include'] then
		_G['midcast_include'](spell)
	end
end
function pet_midcast(spell)
	if spell_stopper(spell) and not Disable_All then cancel_spell() return end
	if _G['pet_midcast_include'] then
		_G['pet_midcast_include'](spell)
	end
end
function aftercast(spell)
	if gearchang_stopper(spell) and not Disable_All then return end
	if _G['aftercast_include'] then
		_G['aftercast_include'](spell)
	end
	equip(sets[player.status])
end
function pet_aftercast(spell)
	if spell_stopper(spell) and not Disable_All then cancel_spell() return end
	if _G['pet_aftercast_include'] then
		_G['pet_aftercast_include'](spell)
	end
	equip(sets[player.status])
end
function self_command(command)
	if _G['self_command_include'] then
		_G['self_command_include'](command)
	end
end