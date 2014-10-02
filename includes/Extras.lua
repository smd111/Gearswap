--Variable Set-up -----------------------------------------------------------------------------------------------------------------
tool_bag_id = 0
autolock = false
box = {}
box.pos = {}
box.pos.x = 0
box.pos.y = 0
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
function file_unload()
	mf_file_unload()
	if main_job_file_unload then
		main_job_file_unload()
	end
	if sub_job_file_unload then
		sub_job_file_unload()
	end
	if file_write then
		file_write()
	end
	if window and Display then
		window:destroy()
	end
end
function status_change(new,old)
	equip_status_change = sets[player.status]
	mf_status_change(new,old)
	if debug_status_change then
		debug_status_change(new,old)
	end
	if main_job_status_change then
		main_job_status_change(new,old)
	end
	if sub_job_status_change then
		sub_job_status_change(new,old)
	end
	if conquest_Gear then
		conquest_Gear()
	end
	equip(equip_status_change)
end
function filtered_action(spell)
	if gearchang_stopper(spell) and not Disable_All then return end
	if mf_filtered_action(spell) then return end
	if debug_filtered_action then
		debug_filtered_action(spell)
	end
	if main_job_filtered_action then
		main_job_filtered_action(spell)
	end
	if sub_job_filtered_action then
		sub_job_filtered_action(spell)
	end
end
function pretarget(spell)
	if spell_stopper(spell) and not Disable_All then cancel_spell() return end
	if mf_pretarget(spell) then return end
	if debug_pretarget then
		debug_pretarget(spell)
	end
	if main_job_pretarget then
		main_job_pretarget(spell)
	end
	if sub_job_pretarget then
		sub_job_pretarget(spell)
	end
	if ammo_rule then
		ammo_rule(spell)
	end
end
function precast(spell)
	if spell_stopper(spell) and not Disable_All then cancel_spell() return end
	equip_pre_cast = sets[player.status]
	if mf_precast(spell) then return end
	if debug_precast then
		debug_precast(spell)
	end
	if main_job_precast then
		main_job_precast(spell)
	end
	if sub_job_precast then
		sub_job_precast(spell)
	end
	if equip_elemental_ws_Gear then
		equip_elemental_ws_Gear(spell, false)
	end
	if conquest_Gear then
		conquest_Gear()
	end
	equip(equip_pre_cast)
end
function buff_change(name,gain)
	if sleepset then
		sleepset(name,gain)
	end
	mf_buff_change(name,gain)
	if debug_buff_change then
		debug_buff_change(name,gain)
	end
	if main_job_buff_change then
		main_job_buff_change(name,gain)
	end
	if sub_job_buff_change then
		sub_job_buff_change(name,gain)
	end
end
function midcast(spell)
	if gearchang_stopper(spell) and not Disable_All then return end
	equip_mid_cast = sets[player.status]
	if mf_midcast(spell) then return end
	if debug_midcast then
		debug_midcast(spell)
	end
	if main_job_midcast then
		main_job_midcast(spell)
	end
	if sub_job_midcast then
		sub_job_midcast(spell)
	end
	if equip_elemental_ws_Gear then
		equip_elemental_ws_Gear(spell, true)
	end
	if conquest_Gear then
		conquest_Gear()
	end
	if equip_elemental_magic_staves then
		equip_elemental_magic_staves(spell)
	end
	if equip_elemental_magic_obi and sets.obi then
		equip_elemental_magic_obi(spell)
	end
	equip(equip_mid_cast)
end
function aftercast(spell)
	if gearchang_stopper(spell) and not Disable_All then return end
	equip_after_cast = sets[player.status]
	if mf_aftercast(spell) then return end
	if debug_aftercast then
		debug_aftercast(spell)
	end
	if main_job_aftercast then
		main_job_aftercast(spell)
	end
	if sub_job_aftercast then
		sub_job_aftercast(spell)
	end
	if conquest_Gear then
		conquest_Gear()
	end
	equip(equip_after_cast)
end
function self_command(command)
	mf_self_command(command)
	if debug_self_command then
		debug_self_command(command)
	end
	if extracommands then
		extracommands(command)
	end
	if main_jobs_command then
		main_jobs_command(command)
	end
	if sub_jobs_command then
		sub_jobs_command(command)
	end
	if equip_elemental_magic_Gear_command then
		equip_elemental_magic_Gear_command(command)
	end
	if conquest_Gear_command then
		conquest_Gear_command(command)
	end
	if file_write then
		file_write()
	end
	if updatedisplay then
		updatedisplay()
	end
end
function pet_change(spell)
	if gearchang_stopper(spell) and not Disable_All then return end
	if mf_pet_change(spell) then return end
	if debug_pet_change then
		debug_pet_change(spell)
	end
	if main_job_pet_change then
		main_job_pet_change(spell)
	end
	if sub_job_pet_change then
		sub_job_pet_change(spell)
	end
end
function pet_midcast(spell)
	if gearchang_stopper(spell) and not Disable_All then return end
	equip_petmidcast = sets[player.status]
	if mf_pet_midcast(spell) then return end
	if debug_pet_midcast then
		debug_pet_midcast(spell)
	end
	if main_job_pet_midcast then
		main_job_pet_midcast(spell)
	end
	if sub_job_pet_midcast then
		sub_job_pet_midcast(spell)
	end
	if conquest_Gear then
		conquest_Gear()
	end
	equip(equip_petmidcast)
end
function pet_aftercast(spell)
	if gearchang_stopper(spell) and not Disable_All then return end
	equip_petaftercast = sets[player.status]
	if mf_pet_aftercast(spell) then return end
	if debug_pet_aftercast then
		debug_pet_aftercast(spell)
	end
	if main_job_pet_aftercast then
		main_job_pet_aftercast(spell)
	end
	if sub_job_pet_aftercast then
		sub_job_pet_aftercast(spell)
	end
	if conquest_Gear then
		conquest_Gear()
	end
	equip(equip_petaftercast)
end
-----------------------------------------------------------------------------------------------------------------------------------
if MJi and not Disable_All and gearswap.pathsearch({'includes/mjob/main_job_'..player.main_job..'.lua'}) then
	include('includes/mjob/main_job_'..player.main_job..'.lua')
end
if SJi and not Disable_All and gearswap.pathsearch({'includes/sjob/sub_job_'..player.sub_job..'.lua'}) then
	include('includes/sjob/sub_job_'..player.sub_job..'.lua')
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
	if command == "reload_gearswap" then
		if file_write then
			file_write()
		end
		send_command("gs r")
	end
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
	if command == "test" and Display then
		table.foreach(windower.ffxi.get_info() , PrintSomething)
	end
end
function PrintSomething(_index)
	print( _index, windower.ffxi.get_info()[_index] ) 
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
	if file_write then
		file_write()
	end
end
if file_write then
	file_write()
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