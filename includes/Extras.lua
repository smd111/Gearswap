--[[how to use(all go at the top of the functions)
	put extras_main() near the bottom of your getsets function
	put spell_stopper(spell) in pretarget and precast these will stop spells/gear swaps if the spell is in recast/another spell
		is in midcast/if sleep is active/and stop gear swaps if a Teleport spell is used
	put gearchang_stopper(spell) in midcast, pet_midcast, aftercast and pet_aftercast stops gear changes if sleep is active
	put sleepset(name,gain) in buff_change changes to sleep gear/locks all necessary gear when sleep is active]]
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
Registered_Events = false
--Use Debug Include (Default: false)
Debug = false
--Use Display Include (Default: true)
Display = true

--Variable Set-up -----------------------------------------------------------------------------------------------------------------
tool_bag_id = 0
lvlwatch = true
autolock = false
box = {}
box.pos = {}
Conquest = {}
Conquest.neck = {}
Conquest.ring = {}
partynames = {}
equip_status_change = {}
equip_pre_cast = {}
equip_mid_cast = {}
equip_after_cast = {}
equip_petmidcast = {}
equip_petaftercast = {}

--Saved Variable Recovery ---------------------------------------------------------------------------------------------------------
if gearswap.pathsearch({'Saves/job_'..player.main_job..'var.lua'}) then
	include('Saves/job_'..player.main_job..'var.lua')
end
if gearswap.pathsearch({'includes/map.lua'}) then
	include('includes/map.lua')
else
	add_to_chat(7,"Must Have includes/map.lua To Use Extras.lua")
	return
end
----------------------------------------------------------------------------------------------------------------------------------
function file_unload_include()
	if _G['main_job_file_unload'] then
		_G['main_job_file_unload']()
	end
	if _G['sub_job_file_unload'] then
		_G['sub_job_file_unload']()
	end
end
function status_change_include(new,old)
	if _G['debug_status_change'] then
		_G['debug_status_change'](new,old)
	end
	if _G['main_job_status_change'] then
		_G['main_job_status_change'](new,old)
	end
	if _G['sub_job_status_change'] then
		_G['sub_job_status_change'](new,old)
	end
	if _G['conquest_Gear'] then
		_G['conquest_Gear']()
	end
	equip(equip_status_change)
end
function filtered_action_include(spell)
	if _G['debug_filtered_action'] then
		_G['debug_filtered_action'](spell)
	end
	if _G['main_job_filtered_action'] then
		_G['main_job_filtered_action'](spell)
	end
	if _G['sub_job_filtered_action'] then
		_G['sub_job_filtered_action'](spell)
	end
end
function pretarget_include(spell)
	if _G['debug_pretarget'] then
		_G['debug_pretarget'](spell)
	end
	if _G['main_job_pretarget'] then
		_G['main_job_pretarget'](spell)
	end
	if _G['sub_job_pretarget'] then
		_G['sub_job_pretarget'](spell)
	end
	if _G['ammo_rule'] then
		_G['ammo_rule'](spell)
	end
end
function precast_include(spell)
	if _G['debug_precast'] then
		_G['debug_precast'](spell)
	end
	if _G['main_job_precast'] then
		_G['main_job_precast'](spell)
	end
	if _G['sub_job_precast'] then
		_G['sub_job_precast'](spell)
	end
	if _G['equip_elemental_ws_Gear'] then
		_G['equip_elemental_ws_Gear'](spell)
	end
	if _G['conquest_Gear'] then
		_G['conquest_Gear']()
	end
	equip(equip_pre_cast)
end
function buff_change_include(name,gain)
	if _G['debug_buff_change'] then
		_G['debug_buff_change'](name,gain)
	end
	if _G['main_job_buff_change'] then
		_G['main_job_buff_change'](name,gain)
	end
	if _G['sub_job_buff_change'] then
		_G['sub_job_buff_change'](name,gain)
	end
end
function midcast_include(spell)
	if _G['debug_midcast'] then
		_G['debug_midcast'](spell)
	end
	if _G['main_job_midcast'] then
		_G['main_job_midcast'](spell)
	end
	if _G['sub_job_midcast'] then
		_G['sub_job_midcast'](spell)
	end
	if _G['conquest_Gear'] then
		_G['conquest_Gear']()
	end
	if _G['equip_elemental_magic_staves'] then
		_G['equip_elemental_magic_staves'](spell)
	end
	if _G['equip_elemental_magic_obi'] and sets.obi then
		_G['equip_elemental_magic_obi'](spell)
	end
	equip(equip_mid_cast)
end
function aftercast_include(spell)
	if _G['debug_aftercast'] then
		_G['debug_aftercast'](spell)
	end
	if _G['main_job_aftercast'] then
		_G['main_job_aftercast'](spell)
	end
	if _G['sub_job_aftercast'] then
		_G['sub_job_aftercast'](spell)
	end
	if _G['conquest_Gear'] then
		_G['conquest_Gear']()
	end
	equip(equip_after_cast)
end
function self_command_include(command)
	if _G['debug_self_command'] then
		_G['debug_self_command'](command)
	end
	if _G['extracommands'] then
		_G['extracommands'](command)
	end
	if _G['main_jobs_command'] then
		_G['main_jobs_command'](command)
	end
	if _G['sub_jobs_command'] then
		_G['sub_jobs_command'](command)
	end
	if _G['equip_elemental_magic_Gear_command'] then
		_G['equip_elemental_magic_Gear_command'](command)
	end
	if _G['conquest_Gear_command'] then
		_G['conquest_Gear_command'](command)
	end
	if _G['file_write'] then
		_G['file_write']()
	end
	if _G['updatedisplay'] then
		_G['updatedisplay']()
	end
end
function pet_change_include(spell)
	if _G['debug_pet_change'] then
		_G['debug_pet_change'](spell)
	end
	if _G['main_job_pet_change'] then
		_G['main_job_pet_change'](spell)
	end
	if _G['sub_job_pet_change'] then
		_G['sub_job_pet_change'](spell)
	end
end
function pet_midcast_include(spell)
	if _G['debug_pet_midcast'] then
		_G['debug_pet_midcast'](spell)
	end
	if _G['main_job_pet_midcast'] then
		_G['main_job_pet_midcast'](spell)
	end
	if _G['sub_job_pet_midcast'] then
		_G['sub_job_pet_midcast'](spell)
	end
	if _G['conquest_Gear'] then
		_G['conquest_Gear']()
	end
	equip(equip_petmidcast)
end
function pet_aftercast_include(spell)
	if _G['debug_pet_aftercast'] then
		_G['debug_pet_aftercast'](spell)
	end
	if _G['main_job_pet_aftercast'] then
		_G['main_job_pet_aftercast'](spell)
	end
	if _G['sub_job_pet_aftercast'] then
		_G['sub_job_pet_aftercast'](spell)
	end
	if _G['conquest_Gear'] then
		_G['conquest_Gear']()
	end
	equip(equip_petaftercast)
end
-----------------------------------------------------------------------------------------------------------------------------------
if MJi and not Disable_All and gearswap.pathsearch({'includes/mjob/main_job_'..player.main_job..'.lua'}) then
	include('includes/mjob/main_job_'..player.main_job..'.lua')
end
if SJi and not Disable_All and gearswap.pathsearch({'includes/extra_more/SJi.lua'}) then
	include('includes/extra_more/SJi.lua')
end
if MSi and not Disable_All and windower.wc_match(player.main_job, "WHM|BLM|RDM|BRD|SMN|SCH|GEO") and 
														gearswap.pathsearch({'includes/extra_more/MSi.lua'}) then
	include('includes/extra_more/MSi.lua')
end
if WSi and not Disable_All and gearswap.pathsearch({'includes/extra_more/WSi.lua'}) then
	include('includes/extra_more/WSi.lua')
end
if Ammo and not Disable_All and windower.wc_match(player.main_job, "WAR|RDM|THF|PLD|DRK|BST|RNG|SAM|NIN|COR") and 
															gearswap.pathsearch({'includes/extra_more/Ammo.lua'}) then
	include('includes/extra_more/Ammo.lua')
end
if Special_Weapons and not Disable_All and gearswap.pathsearch({'includes/extra_more/Special_Weapons.lua'}) then
	include('includes/extra_more/Special_Weapons.lua')
end
if Conquest_Gear and not Disable_All and gearswap.pathsearch({'includes/extra_more/Conquest_Gear.lua'}) then
	include('includes/extra_more/Conquest_Gear.lua')
end
if Registered_Events and not Disable_All and gearswap.pathsearch({'includes/extra_more/Registered_Events.lua'}) then
	include('includes/extra_more/Registered_Events.lua')
end
if Debug and not Disable_All and gearswap.pathsearch({'includes/extra_more/Debug.lua'}) then
	include('includes/extra_more/Debug.lua')
end
if Display and not Disable_All and gearswap.pathsearch({'includes/extra_more/Display.lua'}) then
	include('includes/extra_more/Display.lua')
end
if File_Write and not Disable_All and gearswap.pathsearch({'includes/extra_more/File_Write.lua'}) then
	include('includes/extra_more/File_Write.lua')
end
if Disable_All then
	return
end
--extra functions-----------------------------------------------------------------------------------------------------------------
function extracommands(command)
	if command == "tautolock" and Display then
		autolock = not autolock
	end
	if command == "toggledisplay" and Display then
		if window:visible() then
			window:hide()
			window_hidden = true
		else
			window:show()
			window_hidden = false
		end
	end
end
function spell_range_check(spell)
	local range_mult = {
		[0] = 0,
		[2] = 1.70,
		[3] = 1.490909,
		[4] = 1.44,
		[5] = 1.377778,
		[6] = 1.30,
		[7] = 1.20,
		[8] = 1.30,
		[9] = 1.377778,
		[10] = 1.45,
		[11] = 1.490909,
		[12] = 1.70,
		}
	if (spell.target.model_size + spell.range * range_mult[spell.range]) < spell.target.distance then
		if player.target.type == "MONSTER" then
			add_to_chat(7,"Monster out of range of spell")
		elseif player.target.type == "NPC" then
			add_to_chat(7,"NPC out of range of spell")
		else
			add_to_chat(7,"Player out of range of spell")		
		end
		cancel_spell()
		return
	end
end
function equip_elemental_magic_obi(spell)
	if not Typ.abilitys:contains(spell.prefix) then
		if spell.element == world.weather_element or spell.element == world.day_element then
			equip_mid_cast = set_combine(equip_mid_cast, sets.obi[spell.element])
		end
	end
end
function sub_job_change(new,old)
	send_command("gs r")
end
function spell_stopper(spell)
	if spell.english ~= 'Ranged' and spell.type ~= 'WeaponSkill' then
		if spell.action_type == 'Ability' then
			if spell and (windower.ffxi.get_ability_recasts()[spell.recast_id] > 0) then
				return true
			elseif spell then
				if spell.tp_cost > player.tp then
					return true
				end
				if spell.mp_cost > player.mp and not (buffactive['Manawell'] or buffactive['Manafont']) then
					return true
				end
			end
		elseif spell.action_type == 'Magic' then
			if spell and (windower.ffxi.get_spell_recasts()[spell.recast_id] > 0)then
				return true
			elseif spell then
				if spell.tp_cost > player.tp then
					return true
				end
				if spell.mp_cost > player.mp and not (buffactive['Manawell'] or buffactive['Manafont']) then
					return true
				end
			end
		end
	end
	if buffactive['sleep'] then
		return true
	end
	if spell.target.name == nil then
		return true
	end
	if partynames.party1 then
		if spell.type == "Trust" and party.count > 1 then
			if player.in_combat then
				return true
			end
			if partynames.party1:contains(string.gsub(spell.english, "%s+", "")) then
				return true
			end
		end
	end
	if not windower.wc_match(spell.english, 'Warp*|Teleport*|Recall*|Retrace|Escape') and cities:contains(world.area) then
		return true
	end
	-- if midaction() or pet_midaction() then
		-- return true
	-- end
	if  player.tp < 1000 and spell.type == 'WeaponSkill'  then
		return true
	end
	if player.main_job == "NIN" or player.sub_job == "NIN" then	if nin_tool_check(spell) then return true end end
	return false
end
function gearchang_stopper(spell)
	if buffactive['sleep'] then
		return true
	end
	return false
end
function sleepset(name,gain)
	if name == "sleep" then
		if gain then
			enable("neck","back")
			equip({neck="Opo-opo Necklace",back="Aries Mantle"})
			disable("neck","back","main","sub","range","ammo")
		else
			enable("neck","back","main","sub","range","ammo")
			equip(sets[player.status])
		end
	end
end
function main_job_change()
	if _G['file_write'] then
		_G['file_write'](true)
	end
end
if _G['file_write'] then
	_G['file_write'](true)
end
--has buff functions--------------------------------------------------------------------------------------------------------------
function equipsets(set)
	equip(set)
end
function has_any_buff_of(buff_set)
    return buff_set:any(has_buff())
end
function has_buff()
    return function (b) return buffactive[b] end
end