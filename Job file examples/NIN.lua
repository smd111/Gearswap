--[[How To Use:
	1. make sure that the files for this include setup is in the gearswap/data/<players name> directory
	2. to create a new job file just coppy this and rename it to the correct job name I.e. for Dancer name it DNC.lua
	3. add your gearsets in to function get_sets ware shown
	4. add rules to each function below ware shown
	5. your ready to use
	notes: i have included basic layouts for 3 gearsets Engaged,Idle,Resting]]
--include setup -------------------------------------------------------------------------------------------------------------------
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
--Display Main Job and LVL (Default: false)
lvlwatch = true
--Start with minimized window (Default: false)
window_hidden = true
-----------------------------------------------------------------------------------------------------------------------------------
jobneck = {neck="Ninja Shusa",} --if using the conquest include put the neck that you want as your main neck when conquest neck is not needed
jobring = {left_ring="Bastokan Ring",} --if using the conquest include put the left_ring that you want as your main ring when conquest ring is not needed
-- example:
-- jobneck = {neck={ name="Wivre Gorget", augments={'"Subtle Blow"+4','MP+3',}},}
-- jobring = {left_ring="Prouesse Ring",}
include('includes/Extras.lua')
function get_sets()
	sets.Engaged = {
		main="",
		sub="",
		head="Aurore Beret",
		body="Aurore Doublet",
		hands="Aurore Gloves",
		legs="Aurore Brais",
		feet="Aurore Gaiters",
		neck="Ninja Shusa",
		waist="Silver Mog. Belt",
		left_ear="Terminus Earring",
		right_ear="Liminus Earring",
		left_ring="Bastokan Ring",
		right_ring="Prouesse Ring",
		back="Cerberus Mantle",
		range="Chakram",
	}
	sets.Idle = {
		main="",
		sub="",
		head="Aurore Beret",
		body="Aurore Doublet",
		hands="Aurore Gloves",
		legs="Aurore Brais",
		feet="Danzo Sune-Ate",
		neck="Ninja Shusa",
		waist="Silver Mog. Belt",
		left_ear="Terminus Earring",
		right_ear="Liminus Earring",
		left_ring="Bastokan Ring",
		right_ring="Prouesse Ring",
		back="Cerberus Mantle",
		range="Chakram",
	}
	sets.Resting = {
		main="",
		sub="",
		head="Aurore Beret",
		body="Aurore Doublet",
		hands="Aurore Gloves",
		legs="Aurore Brais",
		feet="Danzo Sune-Ate",
		neck="Ninja Shusa",
		waist="Silver Mog. Belt",
		left_ear="Sanative Earring",
		right_ear="Liminus Earring",
		left_ring="Bastokan Ring",
		right_ring="Prouesse Ring",
		back="Cerberus Mantle",
		range="Chakram",
	}
	---------------------------------------
	--put your sets here
	---------------------------------------
	if update_display then
		coroutine.schedule(update_display, 3)
	end
end
function mf_file_unload()
	---------------------------------------
	--put your file_unload rules here
	---------------------------------------
	return
end
function mf_status_change(new,old, status, set_gear)
	----------------------------------------
	--put your status_change rules here
	----------------------------------------
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
	---------------------------------------
	--put your pet_change rules here
	--to stop processing of all precast rules use: return true
	---------------------------------------
	return set_gear
end
function mf_filtered_action(spell,status,set_gear)
	---------------------------------------
	--put your filtered_action rules here
	--to stop processing of all precast rules use: return true
	---------------------------------------
	return
end
function mf_pretarget(spell,status,set_gear)
	---------------------------------------
	--put your pretarget rules here
	---------------------------------------
	return set_gear
end
function mf_precast(spell,status,set_gear)
	if spell.english == 'Utsusemi: Ichi' then
		if buffactive['Copy Image'] then
			send_command('cancel 66')
		elseif buffactive['Copy Image (2)'] then 
			send_command('cancel 444')
		elseif buffactive['Copy Image (3)'] then
			send_command('cancel 445')
		elseif buffactive['Copy Image (4+)'] then
			send_command('cancel 446')
		end
	elseif spell.english == 'Utsusemi: Ni' then
		if buffactive['Copy Image'] then
			send_command('cancel 66')
		elseif buffactive['Copy Image (2)'] then 
			send_command('cancel 444')
		elseif buffactive['Copy Image (3)'] then
			send_command('cancel 445')
		elseif buffactive['Copy Image (4+)'] then
			send_command('cancel 446')
		end
	end
	---------------------------------------
	--put your precast rules here
	--to stop processing of all precast rules use: return true
	---------------------------------------
	return set_gear
end
function mf_buff_change(name,gain,status,set_gear)
	---------------------------------------
	--put your buff_change rules here
	---------------------------------------
	return set_gear
end
function mf_midcast(spell,status,set_gear)
	---------------------------------------
	--put your midcast rules here
	--to stop processing of all midcast rules use: return true
	---------------------------------------
	return set_gear
end
function mf_pet_midcast(spell,status,set_gear)
	---------------------------------------
	--put your pet_midcast rules here
	--to stop processing of all pet_midcast rules use: return true
	---------------------------------------
	return set_gear
end
function mf_aftercast(spell,status,set_gear)
	---------------------------------------
	--put your aftercast rules here
	--to stop processing of all aftercast rules use: return true
	---------------------------------------
	set_gear = set_combine(set_gear, sets[player.status])--you can change this
	return set_gear
end
function mf_pet_aftercast(spell,status,set_gear)
	---------------------------------------
	--put your pet_aftercast rules here
	--to stop processing of all pet_aftercast rules use: return true
	---------------------------------------
	set_gear = set_combine(set_gear, sets[player.status])--you can change this 
	return set_gear
end
function mf_self_command(command)
	---------------------------------------
	--put your self_command rules here
	--to stop processing of all self_command rules use: return true
	---------------------------------------
	return
end