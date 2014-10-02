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
lvlwatch = false
-----------------------------------------------------------------------------------------------------------------------------------
jobneck = {neck={ name="Wivre Gorget", augments={'"Subtle Blow"+4','MP+3',}},} --if using the conquest include put the neck that you want as your main neck when conquest neck is not needed
jobring = {left_ring="Dasra's Ring",} --if using the conquest include put the left_ring that you want as your main ring when conquest ring is not needed
-- example:
-- jobneck = {neck={ name="Wivre Gorget", augments={'"Subtle Blow"+4','MP+3',}},}
-- jobring = {left_ring="Prouesse Ring",}
include('includes/Extras.lua')
function get_sets()
	sets.Engaged = {
    main="Ichimonji-Yofusa",
    sub="Danger Grip",
    range="Shortbow",
    ammo="Iron Arrow",
    head="Outrider Mask",
    body="Outrider Mail",
    hands="Outrider Mittens",
    legs="Outrider Hose",
    feet="Outrider Greaves",
    neck={ name="Wivre Gorget", augments={'"Subtle Blow"+4','MP+3',}},
    waist="Marid Belt",
    left_ear="Kemas Earring",
    right_ear="Terminus Earring",
    left_ring="Dasra's Ring",
    right_ring="Prouesse Ring",
    back="Unkai Sugemino",
	}
	sets.Idle = {
    main="Ichimonji-Yofusa",
    sub="Danger Grip",
    range="Shortbow",
    ammo="Iron Arrow",
    head="Outrider Mask",
    body="Outrider Mail",
    hands="Outrider Mittens",
    legs="Outrider Hose",
    feet="Danzo Sune-Ate",
    neck={ name="Wivre Gorget", augments={'"Subtle Blow"+4','MP+3',}},
    waist="Marid Belt",
    left_ear="Kemas Earring",
    right_ear="Terminus Earring",
    left_ring="Dasra's Ring",
    right_ring="Prouesse Ring",
    back="Unkai Sugemino",
	}
	sets.Resting = {
    main="Ichimonji-Yofusa",
    sub="Danger Grip",
    range="Shortbow",
    ammo="Iron Arrow",
    head="Outrider Mask",
    body="Outrider Mail",
    hands="Outrider Mittens",
    legs="Outrider Hose",
    feet="Danzo Sune-Ate",
    neck={ name="Wivre Gorget", augments={'"Subtle Blow"+4','MP+3',}},
    waist="Marid Belt",
    left_ear="Sanative Earring",
    right_ear="Terminus Earring",
    left_ring="Dasra's Ring",
    right_ring="Prouesse Ring",
    back="Unkai Sugemino",
	}
	---------------------------------------
	--put your sets here
	---------------------------------------
	if updatedisplay then
		coroutine.schedule(updatedisplay, 3)
	end
end
function mf_file_unload()
	---------------------------------------
	--put your file_unload rules here
	---------------------------------------
	return false
end
function mf_status_change(new,old)
	----------------------------------------
	--put your status_change rules here
	----------------------------------------
	--equip example: equip_status_change = set_combine(equip_status_change, sets.Engaged)
	----------------------------------------
	if new=='Engaged' then
		equip_status_change = set_combine(equip_status_change, sets.Engaged)
	elseif new=='Idle' then
		equip_status_change = set_combine(equip_status_change, sets.Idle)
	elseif new=='Resting' then
		equip_status_change = set_combine(equip_status_change, sets.Resting)
	end
	return false
end
function mf_pet_change(pet,gain)
	---------------------------------------
	--put your pet_change rules here
	--to stop processing of all precast rules use: return true
	---------------------------------------
	return false
end
function mf_filtered_action(spell)
	---------------------------------------
	--put your filtered_action rules here
	--to stop processing of all precast rules use: return true
	---------------------------------------
end
function mf_pretarget(spell)
	---------------------------------------
	--put your pretarget rules here
	---------------------------------------
	return false
end
function mf_precast(spell)
	if spell.name == 'Meditate' and (player.tp >= 2750 or buffactive['Invisible']) then
		cancel_spell()		
		return true
	end
	---------------------------------------
	--put your precast rules here
	---------------------------------------
	--equip example: equip_pre_cast = set_combine(equip_pre_cast, sets.Engaged)
	---------------------------------------
end
function mf_buff_change(name,gain)
	---------------------------------------
	--put your buff_change rules here
	---------------------------------------
	return false
end
function mf_midcast(spell)
	---------------------------------------
	--put your midcast rules here
	--to stop processing of all midcast rules use: return true
	---------------------------------------
	--equip example: equip_mid_cast = set_combine(equip_mid_cast, sets.Engaged)
	---------------------------------------
	return false
end
function mf_pet_midcast(spell)
	---------------------------------------
	--put your pet_midcast rules here
	--to stop processing of all pet_midcast rules use: return true
	---------------------------------------
	--equip example: equip_petmidcast = set_combine(equip_petmidcast, sets.Engaged)
	---------------------------------------
	return false
end
function mf_aftercast(spell)
	---------------------------------------
	--put your aftercast rules here
	--to stop processing of all aftercast rules use: return true
	---------------------------------------
	--equip example: equip_after_cast = set_combine(equip_after_cast, sets.Engaged)
	---------------------------------------
	equip_after_cast = set_combine(equip_after_cast, sets[player.status])--you can change this
	return false
end
function mf_pet_aftercast(spell)
	---------------------------------------
	--put your pet_aftercast rules here
	--to stop processing of all pet_aftercast rules use: return true
	---------------------------------------
	--equip example: equip_petaftercast = set_combine(equip_petaftercast, sets.Engaged)
	---------------------------------------
	equip_petaftercast = set_combine(equip_petaftercast, sets[player.status])--you can change this 
	return false
end
function mf_self_command(command)
	---------------------------------------
	--put your self_command rules here
	--to stop processing of all self_command rules use: return true
	---------------------------------------
	return false
end