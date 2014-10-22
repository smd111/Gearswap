--Variable Set-up -----------------------------------------------------------------------------------------------------------------
tool_bag_id = 0
autolock = false
box = {}
box.pos = {}
box.pos.x = 0
box.pos.y = 0
gear_mode = T{'Normal', 'Acc', 'Att'}
gear_mode_count = 1
Conquest = {}
Conquest.neck = {}
Conquest.ring = {}
partynames = {}
sets.precast = {}
sets.midcast = {}
sets.aftercast = {}
sets.pet_midcast = {}
sets.pet_aftercast = {}
auto_use_shards = true
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
function run_event(spell, event_type)
	local status = {end_event=false, end_spell=false}
	local set_gear = {}
	set_gear = set_combine(set_gear, sets[player.status])
	if _G['mf_'..event_type] then
		 _G['mf_'..event_type](spell,status,set_gear)
	end
	if status.end_spell then cancel_spell() end
	if status.end_event then return end
	if _G['debug_'..event_type] then
		 _G['debug_'..event_type](spell,status,set_gear)
	end
	if status.end_spell then cancel_spell() end
	if status.end_event then return end
	if _G['main_job_'..event_type] then
		 _G['main_job_'..event_type](spell,status,set_gear)
	end
	if status.end_spell then cancel_spell() end
	if status.end_event then return end
	if _G['sub_job_'..event_type] then
		 _G['sub_job_'..event_type](spell,status,set_gear)
	end
	if status.end_spell then cancel_spell() end
	if status.end_event then return end
	if windower.wc_match(event_type, '*cast|pretarget') then
		if extra_events then
			extra_events(spell,status,set_gear)
		end
		equip(set_gear)
	end
end
function equip_set(set_gear, set)
	for i,v in pairs(set) do
		set_gear[i] = v
	end
end
function filtered_action(spell)
	if gearchang_stopper(spell) and not Disable_All then return end
	run_event(spell, 'filtered_action')
end
function pretarget(spell)
	if spell_stopper(spell) and not Disable_All then cancel_spell() return end
	run_event(spell, 'pretarget')
end
function precast(spell)
	if spell_stopper(spell) and not Disable_All then cancel_spell() return end
	run_event(spell, 'precast')
end
function midcast(spell)
	if gearchang_stopper(spell) and not Disable_All then return end
	run_event(spell, 'midcast')
end
function aftercast(spell)
	if gearchang_stopper(spell) and not Disable_All then return end
	run_event(spell, 'aftercast')
	if player.in_combat and auto_use_shards then
		if player.inventory['C. Ygg. Shard I'] then
			send_command('wait 3.0;input /item "C. Ygg. Shard I" <me>')
		elseif player.inventory['C. Ygg. Shard II'] then
			send_command('wait 3.0;input /item "C. Ygg. Shard II" <me>')
		elseif player.inventory['C. Ygg. Shard III'] then
			send_command('wait 3.0;input /item "C. Ygg. Shard III" <me>')
		elseif player.inventory['C. Ygg. Shard IV'] then
			send_command('wait 3.0;input /item "C. Ygg. Shard IV" <me>')
		elseif player.inventory['C. Ygg. Shard V'] then
			send_command('wait 3.0;input /item "C. Ygg. Shard V" <me>')
		elseif player.inventory['Z. Ygg. Shard I'] then
			send_command('wait 3.0;input /item "Z. Ygg. Shard I" <me>')
		elseif player.inventory['Z. Ygg. Shard II'] then
			send_command('wait 3.0;input /item "Z. Ygg. Shard II" <me>')
		elseif player.inventory['Z. Ygg. Shard III'] then
			send_command('wait 3.0;input /item "Z. Ygg. Shard III" <me>')
		elseif player.inventory['Z. Ygg. Shard IV'] then
			send_command('wait 3.0;input /item "Z. Ygg. Shard IV" <me>')
		elseif player.inventory['Z. Ygg. Shard V'] then
			send_command('wait 3.0;input /item "Z. Ygg. Shard V" <me>')
		elseif player.inventory['A. Ygg. Shard I'] then
			send_command('wait 3.0;input /item A. Ygg. Shard I" <me>')
		elseif player.inventory['A. Ygg. Shard II'] then
			send_command('wait 3.0;input /item "A. Ygg. Shard II" <me>')
		elseif player.inventory['A. Ygg. Shard III'] then
			send_command('wait 3.0;input /item "A. Ygg. Shard III" <me>')
		elseif player.inventory['A. Ygg. Shard IV'] then
			send_command('wait 3.0;input /item "A. Ygg. Shard IV" <me>')
		elseif player.inventory['A. Ygg. Shard V'] then
			send_command('wait 3.0;input /item "A. Ygg. Shard V" <me>')
		end
	end
end
function pet_midcast(spell)
	if gearchang_stopper(spell) and not Disable_All then return end
	run_event(spell, 'pet_midcast')
end
function pet_aftercast(spell)
	if gearchang_stopper(spell) and not Disable_All then return end
	run_event(spell, 'pet_aftercast')
end
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
end
function status_change(new,old)
	local set_gear = {}
	set_gear = set_combine(set_gear, sets.Idle)
	if mf_status_change then
		mf_status_change(new,old, status, set_gear)
	end
	if debug_status_change then
		debug_status_change(new,old,status,set_gear)
	end
	if main_job_status_change then
		main_job_status_change(new,old,status,set_gear)
	end
	if sub_job_status_change then
		sub_job_status_change(new,old,status,set_gear)
	end
	if conquest_Gear then	
		conquest_Gear(status,set_gear)
	end
	equip(set_gear)
end
function buff_change(name,gain)
	local status = {end_event=false, end_spell=false}
	local set_gear = {}
	set_gear = set_combine(set_gear, sets[player.status])
	if sleepset then
		sleepset(name,gain,status,set_gear)
	end
	if mf_buff_change then
		mf_buff_change(name,gain,status,set_gear)
	end
	if debug_buff_change then
		debug_buff_change(name,gain,status,set_gear)
	end
	if status.end_spell then cancel_spell() end
	if status.end_event then return end
	if main_job_buff_change then
		main_job_buff_change(name,gain,status,set_gear)
	end
	if status.end_spell then cancel_spell() end
	if status.end_event then return end
	if sub_job_buff_change then
		sub_job_buff_change(name,gain,status,set_gear)
	end
	if status.end_spell then cancel_spell() end
	if status.end_event then return end
	equip(set_gear)
end
function self_command(command)
	if mf_self_command then
		mf_self_command(command)
	end
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
function pet_change(pet,gain)
	local status = {end_event=false, end_spell=false}
	local set_gear = {}
	set_gear = set_combine(set_gear, sets[player.status])
	if mf_pet_change then
		mf_pet_change(pet,gain,status,set_gear)
	end
	if status.end_spell then cancel_spell() end
	if status.end_event then return end
	if debug_pet_change then
		debug_pet_change(pet,gain,status,set_gear)
	end
	if main_job_pet_change then
		main_job_pet_change(pet,gain,status,set_gear)
	end
	if status.end_spell then cancel_spell() end
	if status.end_event then return end
	if sub_job_pet_change then
		sub_job_pet_change(pet,gain,status,set_gear)
	end
	if status.end_spell then cancel_spell() end
	if status.end_event then return end
	equip(set_gear)
end
function sub_job_change(new,old)
	send_command("gs r")
	if mf_sub_job_change then
		mf_sub_job_change(new,old)
	end
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
function extra_events(spell,status,set_gear)
	if ammo_rule then
		ammo_rule(spell,status,set_gear)
	end
	if conquest_Gear then
		conquest_Gear(set_gear)
	end
	if equip_elemental_ws_Gear then
		equip_elemental_ws_Gear(spell,status,set_gear)
	end
	if equip_elemental_magic_staves then
		equip_elemental_magic_staves(spell,status,set_gear)
	end
	if equip_elemental_magic_obi and sets.obi then
		equip_elemental_magic_obi(spell,status,set_gear)
	end
end
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
end
function equip_elemental_magic_obi(spell,set_gear)
	if not Typ.abilitys:contains(spell.prefix) then
		if spell.element == world.weather_element or spell.element == world.day_element then
			set_gear = set_combine(set_gear, sets.obi[spell.element])
		end
	end
end
function spell_stopper(spell)
	if spell.english ~= 'Ranged' and spell.type ~= 'WeaponSkill' then
		if spell and spell.action_type == 'Ability' then
			if tonumber(windower.ffxi.get_ability_recasts()[spell.recast_id]) > 0 then
				add_to_chat(7, tostring(spell.name).." cancelled with recast of "..windower.ffxi.get_ability_recasts()[spell.recast_id])
				return true
			end
		elseif spell and spell.action_type == 'Magic' then
			if tonumber(windower.ffxi.get_spell_recasts()[spell.id]) > 0 then
				add_to_chat(7, tostring(spell.name).." cancelled with recast of "..windower.ffxi.get_spell_recasts()[spell.id])
				return true
			end
		end
	end
	if spell then
		if spell.tp_cost > player.tp then
			return true
		end
		if spell.mp_cost > player.mp and not (buffactive['Manawell'] or buffactive['Manafont']) then
			return true
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
	-- if min_fm_for_flourishes[spell.name] then
		-- local fm_count = 0
		-- for i, v in pairs(buffactive) do
			-- if string.startswith(i, 'finishing move') then
				-- for w in string.gmatch (i, '%d') do
					-- fm_count = tonumber(w)
					-- if min_fm_for_flourishes[spell.name] < fm_count then
						-- return true
					-- end
				-- end
			-- end
		-- end
	-- end
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
	--if spell.english ~= 'Ranged' and spell.type ~= 'Item' and spell_range_check(spell) then	return true	end
	return false
end
function spell_range_check(spell)
	local range_mult = {
        [0] = 0,
		[1] = 1.642276421172564,
        [2] = 1.642276421172564,
        [3] = 1.642276421172564,
        [4] = 1.642276421172564,
        [5] = 1.642276421172564,
        [6] = 1.642276421172564,
        [7] = 1.642276421172564,
        [8] = 1.642276421172564,
        [9] = 1.642276421172564,
        [10] = 1.642276421172564,
        [11] = 1.642276421172564,
        [12] = 1.642276421172564,
        }
	local spell_max_distance = spell.target.model_size + spell.range * range_mult[spell.range]
	if spell_max_distance < spell.target.distance then
		if player.target.type == "MONSTER" then
			add_to_chat(7,"Monster out of "..spell.name.."'s max range of "..spell_max_distance)
		elseif player.target.type == "NPC" then
			add_to_chat(7,"NPC out of "..spell.name.."'s max range of "..spell_max_distance)
		else
			add_to_chat(7,"Player out of "..spell.name.."'s max range of "..spell_max_distance)		
		end
		return true
	else
		return false
	end
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
			equip_set(set_gear, {neck="Opo-opo Necklace",back="Aries Mantle"})
			disable("neck","back","main","sub","range","ammo")
		else
			enable("neck","back","main","sub","range","ammo")
			equip_set(set_gear, sets[player.status])
		end
	end
end
if file_write then
	file_write()
end
--has buff functions--------------------------------------------------------------------------------------------------------------
function has_any_buff_of(buff_set)
    return buff_set:any(has_buff())
end
function has_buff()
    return function (b) return buffactive[b] end
end