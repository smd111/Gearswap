--Variable Set-up -----------------------------------------------------------------------------------------------------------------
tool_bag_id = 0
autolock = false
menu = {}
menu.pos = {}
menu.pos.x = 0
menu.pos.y = 0
gear_mode = T{'Normal', 'Acc', 'Att'}
gear_mode_count = 1
Conquest = {}
Conquest.neck = {}
Conquest.ring = {}
partynames = {}
lock_gear={main=false,sub=false,range=false,ammo=false,head=false,body=false,hands=false,legs=false,feet=false,neck=false,waist=false,left_ear=false,right_ear=false,left_ring=false,right_ring=false,back=false,}
auto_use_shards = true
events = {"debug_","extra_","main_job_","sub_job_","equip_elemental_magic_Gear_","conquest_Gear_","mf_"}
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
function run_event(event_type,...)
	local a,b = unpack{...}
	local check_function = {[1]={"pretarget","precast","midcast","aftercast","pet_midcast","pet_aftercast"},
							[2]={"pretarget","precast","midcast","pet_midcast","pet_aftercast"},
							[3]={"filtered_action","file_unload","buff_change","self_command","pet_change","sub_job_change"},}
	local status = {end_event=false,end_spell=false,stop_swapping_gear=false}
	local set_gear = {}
	set_gear = set_combine(set_gear, sets[player.status])
	if table.contains(check_function[1], event_type) then
		if conquest_Gear then
			set_gear = set_combine(set_gear, conquest_Gear(status,set_gear))
		end
	end
	if event_type == "precast" then
		if ammo_rule then
			ammo_rule(a,status,set_gear)
		end
		if special_weapon then
			special_weapon(a,status,set_gear)
		end
	end
	if status.end_spell and event_type == 'precast' then cancel_spell() end
	if status.end_event then return end
	if table.contains(check_function[2], event_type)  then
		if equip_elemental_ws_Gear then
			set_gear = set_combine(set_gear, equip_elemental_ws_Gear(a,status,set_gear))
		end
		if equip_elemental_magic_staves then
			set_gear = set_combine(set_gear, equip_elemental_magic_staves(a,status,set_gear))
		end
		if equip_elemental_magic_obi and sets.obi then
			set_gear = set_combine(set_gear, equip_elemental_magic_obi(a,status,set_gear))
		end
	end
	for i, v in ipairs(events) do
		if b and _G[v..''..event_type] then
			set_gear = set_combine(set_gear, _G[v..''..event_type](a,b,status,set_gear))
			if status.end_spell and event_type == 'precast' then cancel_spell() end
			if status.end_event then return end
		elseif _G[v..''..event_type] then
			set_gear = set_combine(set_gear, _G[v..''..event_type](a,status,set_gear))
			if status.end_spell and event_type == 'precast' then cancel_spell() end
			if status.end_event then return end
		end
	end
	if table.contains(check_function[3], event_type)  then
		status.stop_swapping_gear = true
	end
	if not status.stop_swapping_gear then
		equip(set_gear)
		--for i, v in pairs(lock_gear) do
			--if v then
				--disable(tostring(i))
			--elseif not v then
				--enable(tostring(i))
			--end
		--end
	end
end
function get_sets()
	gear_setup()
	if update_display then
		coroutine.schedule(update_display, 3)
	end
end
function filtered_action(spell)
	if gearchang_stopper(spell) and not Disable_All then return end
	run_event('filtered_action',spell)
end
function pretarget(spell)
	if spell_stopper(spell) and not Disable_All then cancel_spell() return end
	run_event('pretarget',spell)
end
function precast(spell)
	if spell_stopper(spell) and not Disable_All then cancel_spell() return end
	run_event('precast',spell)
end
function midcast(spell)
	if gearchang_stopper(spell) and not Disable_All then return end
	run_event('midcast',spell)
end
function aftercast(spell)
	--sleep(3)
	if gearchang_stopper(spell) and not Disable_All then return end
	run_event('aftercast',spell)
	if player.in_combat and auto_use_shards then
		local shard_name = {'C. Ygg. Shard ','Z. Ygg. Shard ','A. Ygg. Shard I'}
		for sni, snv in ipairs(shard_name) do
			local shard_count = {'I','II','III','IV','V'}
			for sci, scv in ipairs(shard_count) do
				if player.inventory[snv..''..scv] then
					send_command('wait 3.0;input /item "'..snv..''..scv..'" <me>')
				end
			end
		end
	end
end
function pet_midcast(spell)
	if gearchang_stopper(spell) and not Disable_All then return end
	run_event('pet_midcast',spell)
end
function pet_aftercast(spell)
	if gearchang_stopper(spell) and not Disable_All then return end
	run_event('pet_aftercast',spell)
end
function file_unload()
	run_event('file_unload',nil)
	if file_write then
		file_write()
	end
end
function status_change(new,old)
	run_event('status_change',new,old)
end
function buff_change(name,gain)
	run_event('buff_change',name,gain)
	if name == "sleep" then
		if gain then
			equip({neck="Opo-opo Necklace",back="Aries Mantle"})
		else
			equip(sets[player.status])
		end
	end
end
function self_command(command)
	run_event('self_command',command)
	if file_write then
		file_write()
	end
	if updatedisplay then
		updatedisplay()
	end
end
function pet_change(pet,gain)
	run_event('pet_change',pet,gain)
end
function sub_job_change(new,old)
	send_command("gs r")
	run_event('sub_job_change',new,old)
end
-----------------------------------------------------------------------------------------------------------------------------------
function load_includes()
	local includes = {'MJi','SJi','MSi','WSi','Ammo','Special_Weapons','Conquest_Gear','Registered_Events','Debug','Display','File_Write'}
	for i, v in pairs(includes) do
		if v == 'MJi' and MJi and gearswap.pathsearch({'includes/sjob/sub_job_'..player.main_job..'.lua'}) then
			include('includes/mjob/main_job_'..player.main_job..'.lua')
		elseif v == 'SJi' and SJi and gearswap.pathsearch({'includes/sjob/sub_job_'..player.main_job..'.lua'}) then
			include('includes/sjob/sub_job_'..player.sub_job..'.lua')
		elseif v =='MSi' and MSi and table.contains(jobs.magic, player.main_job) and gearswap.pathsearch({'includes/extra_more/MSi.lua'}) then
			include('includes/extra_more/MSi.lua')
		elseif v == 'Ammo' and Ammo and table.contains(jobs.ammo, player.main_job) and gearswap.pathsearch({'includes/extra_more/Ammo.lua'}) then
			include('includes/extra_more/Ammo.lua')
		elseif _G[v] and gearswap.pathsearch({'includes/extra_more/'..v..'.lua'}) then
			include('includes/extra_more/'..v..'.lua')
		end
	end
end
if Disable_All then
	return
else
	load_includes()
end
--extra functions-----------------------------------------------------------------------------------------------------------------
function extra_self_commands(command)
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
function equip_elemental_magic_obi(spell,status)
	if not Typ.abilitys:contains(spell.prefix) then
		if spell.element == world.weather_element or spell.element == world.day_element then
			set_gear = set_combine(set_gear, sets.obi[spell.element])
		end
	end
	return set_gear
end
function spell_stopper(spell)
	if spell.en ~= 'Ranged' and spell.type ~= 'WeaponSkill' then
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
			if partynames.party1:contains(string.gsub(spell.en, "%s+", "")) then
				return true
			end
		end
	end
	if min_fm_for_flourishes[spell.en] then
		local fm_count = 0
		for i, v in pairs(buffactive) do
			if string.startswith(tostring(i), 'Finishing Move') then
				for w in string.gmatch (i, '%d') do
					fm_count = tonumber(w)
					if min_fm_for_flourishes[spell.en] < fm_count then
						return true
					end
				end
			end
		end
	end
	local transportation_spells = {'Escape','Recall-Jugner','Recall-Meriph','Recall-Pashh','Retrace','Teleport-Altep','Teleport-Dem','Teleport-Holla','Teleport-Mea',
									'Teleport-Vahzl','Teleport-Yhoat','Warp','Warp II'}
	if not table.contains(transportation_spells, spell.en) and table.contains(cities, world.area) then
		return true
	end
	-- if midaction() or pet_midaction() then
		-- return true
	-- end
	if  player.tp < 1000 and spell.type == 'WeaponSkill'  then
		return true
	end
	if player.main_job == "NIN" or player.sub_job == "NIN" then	if nin_tool_check(spell) then return true end end
	--if spell.en ~= 'Ranged' and spell.type ~= 'Item' and spell_range_check(spell) then return true end
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