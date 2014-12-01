menu.text = {}
menu.text.font = 'Segoe UI Symbol'
menu.text.size = 9
menu.bg = {}
menu.bg.alpha = 200
menu.flags = {}
menu.flags.draggable = true
min_window = {}
min_window.text = {}
min_window.text.font = 'Segoe UI Symbol'
min_window.text.size = 9
min_window.bg = {}
min_window.bg.alpha = 200
min_window.flags = {}
min_window.flags.draggable = false
min_window.pos = {}
min_window.pos.x = 0
min_window.pos.y = 400
auto_hide_cycle = 0
skill_select = {}
skill_select.pos = {}
skill_select.pos.x = (menu.pos.x - 120)
skill_select.pos.y = (menu.pos.y - 209)
skill_select.text = {}
skill_select.text.font = 'Segoe UI Symbol'
skill_select.text.size = 9
skill_select.bg = {}
skill_select.bg.alpha = 200
skill_select.flags = {}
skill_select.flags.draggable = false
skillwatch = false
lvlwatch = false
--display functions---------------------------------------------------------------------------------------------------------------
--Display Creator
if not tswap then
	tswap = false
end
if not debugmod then
	debugmod = false
end
menu_set = 1
window = texts.new(menu)
button = texts.new(min_window)
function initialize(text, settings, a)
	if a == 'window' then
		local properties = L{}
		properties:append('${listm}')
		properties:append('Gearswap   \\cs(255,255,0)HIDE\\cr')
		if menu_set == 1 then -- job menu
			properties:append('--Job Settings--')
			if (windower.ffxi.get_player().main_job == 'DNC' and MJi) or (windower.ffxi.get_player().sub_job == 'DNC' and SJi) then
				properties:append('-Steps-')
				properties:append('   Max Step = ${stepm}')
				properties:append('   Stop Steps   ${ssteps}')
			end
			if lvlwatch then
				properties:append('${mjob}cr')
				properties:append('   lvl = ${mjob_lvl}')
			end
			if skillwatch and Registered_Events then
				properties:append('${skill}')
				properties:append('   lvl = ${skill_lvl}')
			end
		elseif menu_set == 2 then -- armor menu
			properties:append('--Armor Settings--')
			properties:append('Mode = \\cs(255,255,0)${amode}\\cr')
			if table.contains(jobs.magic, player.main_job) and WSi then
				properties:append('-Mage Staves-')
				properties:append('   Auto Change   ${cstaff}')
				properties:append('   Type \\cs(255,255,0)${ustaff}\\cr')
			end
			if Conquest_Gear then
				properties:append('-Conquest Gear-')
				properties:append('  Change Neck   ${cneckc}')
				properties:append('  Neck Type = \\cs(255,255,0)${cneck}\\cr')
				properties:append('  Change Ring   ${cringc}')
				properties:append('  Ring Type = \\cs(255,255,0)${cring}\\cr')
			end
		elseif menu_set == 3 then -- system menu
			properties:append('--System Settings--')
			if autolock and Registered_Events then
				properties:append('Auto Lock')
				properties:append('  \\cs(255,255,0)Enabled\\cr')
			end
			if autotarget then
				properties:append('Auto Self Target')
				properties:append('After Battle \\cs(255,255,0)Enabled\\cr')
			end
			if stoponskillcap and Registered_Events then
				properties:append('Auto Stop On')
				properties:append('  \\cs(255,255,0)'..string.gsub(stopskilltyp[stopskill_count], "_", " ")..'\\cr Cap')
				if lvl then
					properties:append('Current Skill')
					properties:append('  Level = \\cs(255,255,0)'..lvl[stopskilltyp[stopskill_count]]..'\\cr')
				end
			end
			properties:append('Display Main Job')
			properties:append('and LVL   ${tmjl}')
			properties:append('Show Current ')
			properties:append('Skill Level   ${tskill}')
			properties:append('Show Swaps   ${tswap}')
			properties:append('Debug Mode   ${debugm}')
			if File_Write then
				properties:append('Force File Write')
			end
			properties:append('Gearswap Export')
			properties:append('Reload Gearswap')
		elseif menu_set == 4 then -- include menu
			properties:append('--Include Settings--')
			properties:append('Ammo   ${tammo}')
			properties:append('Conquest Gear   ${tcgi}')
			properties:append('Debug   ${tdebug}')
			properties:append('File Write   ${tfwi}')
			properties:append('Main Job   ${tmji}')
			properties:append('Mage Stave   ${tmsi}')
			properties:append('Registered Events   ${trei}')
			properties:append('Special Weapons   ${tswi}')
			properties:append('Sub Job   ${tsji}')
			properties:append('Weapon Skill   ${twsi}')
		elseif menu_set == 5 then --custom menu
			properties:append('Custom Menu')
			for i,v in pairs(custom_menu()) do
				if type(v) == 'string' then
					properties:append(v)
				end
			end
		end
		text:clear()
		text:append(properties:concat('\n'))
		grab_switches(properties)
	end
	if a == 'button' then
		local properties_button = L{}
		if lvlwatch then
			properties_button:append('${mjob}   lvl = ${mjob_lvl}')
		end
		if skillwatch and Registered_Events then
			properties_button:append('${skill}   lvl = ${skill_lvl}')
		end
		if not skillwatch and not lvlwatch then
			properties_button:append('\n > \n ')
		end
		text:clear()
		text:append(properties_button:concat('\n'))
	end
	if a == 'skill_select_window' then
		local properties = L{}
		properties:append('Select Skill')
		properties:append('${ax|Axe}')
		properties:append('${cl|Club}')
		properties:append('${dg|Dagger}')
		properties:append('${ga|Great Axe}')
		properties:append('${gk|Great Katana}')
		properties:append('${gs|Great Sword}')
		properties:append('${hh|Hand-to-Hand}')
		properties:append('${kt|Katana}')
		properties:append('${pl|Polearm}')
		properties:append('${sc|Scythe}')
		properties:append('${st|Staff}')
		properties:append('${sw|Sword}')
		properties:append('${ar|Archery}')
		properties:append('${mk|Marksmanship}')
		properties:append('${th|Throwing}')
		properties:append('${ev|Evasion}')
		properties:append('${gr|Guard}')
		properties:append('${pa|Parrying}')
		properties:append('${sh|Shield}')
		properties:append('${bm|Blue Magic}')
		properties:append('${dm|Dark Magic}')
		properties:append('${dvm|Divine Magic}')
		properties:append('${em|Elemental Magic}')
		properties:append('${efm|Enfeebling Magic}')
		properties:append('${ehm|Enhancing Magic}')
		properties:append('${go|Geomancy}')
		properties:append('${hb|Handbell}')
		properties:append('${hm|Healing Magic}')
		properties:append('${nin|Ninjutsu}')
		properties:append('${so|Singing}')
		properties:append('${sti|Stringed Instrument}')
		properties:append('${smm|Summoning Magic}')
		properties:append('${wi|Wind Instrument}')
		properties:append('${aa|Automaton Archery}')
		properties:append('${amg|Automaton Magic}')
		properties:append('${am|Automaton Melee}')
		text:clear()
		text:append(properties:concat('\n'))
		my_table_skill = properties
		for i,v in pairs(my_table_skill) do
			for w in string.gmatch (v, '%a+%d') do
				if type(my_table_skill[i]) ~= 'table' then
					my_table_skill[i] = T{}
				end
				my_table_skill[i]:append(w)
			end
		end
	end
end
function grab_switches(a)
	my_table = a
	for i,v in pairs(my_table) do
		for w in string.gmatch (v, '{.-}') do
			if type(my_table[i]) ~= 'table' then
				my_table[i] = T{}
			end
			my_table[i]:append(w)
		end
	end
end
initialize(window, menu, 'window')
initialize(button, min_window, 'button')
--Display Updater
function update_display()
	windower.prim.create('window_button')
	windower.prim.set_color('window_button', 200, 255, 255, 255)
	windower.prim.set_visibility('window_button', false)
	updatedisplay()
end
function updatedisplay()
	local menu_list ={'[J]  A  S1  S2  C','J  [A]  S1  S2  C','J  A  [S1]  S2  C','J  A  S1  [S2]  C','J  A  S1  S2  [C]'}
	initialize(window, menu, 'window')
	initialize(button, min_window, 'button')
	local info = {}
	if SJi then
		info.stepm = Stepmax
		info.ssteps = Stopsteps and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
	end
	if WSi then
		info.cstaff = Changestaff and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
		info.ustaff = Usestaff
	end
	if Conquest_Gear then
		info.cneckc = Conquest.neck.change and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
		info.cringc = Conquest.ring.change and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
		info.cneck = Conquest.neck.case[Conquest.neck.case_id]
		info.cring = Conquest.ring.case[Conquest.ring.case_id]
	end
	info.mjob = windower.ffxi.get_player().main_job_full
	info.mjob_lvl = windower.ffxi.get_player().main_job_level
	info.amode = gear_mode[gear_mode_count]
	if menu_set == 5 then
		info = custom_rules()
	end
	info.listm = menu_list[menu_set]
	info.tmji = MJi and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
	info.tsji = SJi and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
	info.tmsi = MSi and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
	info.twsi = WSi and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
	info.tammo = Ammo and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
	info.tfwi = File_Write and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
	info.tswi = Special_Weapons and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
	info.tcgi = Conquest_Gear and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
	info.trei = Registered_Events and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
	info.tdebug = Debug and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
	info.tmjl = lvlwatch and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
	info.skill = skill_type[skill_count]
	info.skill_lvl = (skill[skill_type[skill_count]..' Capped'] and "Capped" or skill[skill_type[skill_count]..' Level'])
	info.tskill = skillwatch and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
	info.tswap = tswap and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
	info.debugm = debugmod and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
	window:update(info)
	button:update(info)
	if not window_hidden then
		window:show()
	else
		button:show()
	end
end
function auto_hide_window()
	if auto_hide_cycle == 3 then
		if windower.ffxi.get_info().menu_open and not windower.ffxi.get_player().in_combat and not window_hidden then
			window:hide()
			button:hide()
		elseif not windower.ffxi.get_info().menu_open and not windower.ffxi.get_player().in_combat then
			if not window_hidden then
				window:show()
			else
				button:show()
			end
		end
		auto_hide_cycle = 0
	else
		auto_hide_cycle = auto_hide_cycle +1
	end
end
--windower.raw_register_event('prerender', auto_hide_window)
function mouse(mtype, x, y, delta, blocked)
	local hide_button = {'{mjob}','{mjob_lvl}','{skill_lvl}'}
	local mx, my = windower.text.get_extents(window._name)
	local button_lines = window:text():count('\n') + 1
	local hx = (x - menu.pos.x)
	local hy = (y - menu.pos.y)
	local bmx, bmy = windower.text.get_extents(button._name)
	if skillwatch and skill_select_window:hover(x, y) then
		mx, my = windower.text.get_extents(skill_select_window._name)
		button_lines = skill_select_window:text():count('\n') + 1
		hx = (x - skill_select.pos.x)
		hy = (y - skill_select.pos.y)
	end
	local first_pos = 99
	local last_pos = 0
	local location = {}
	location.offset = my / button_lines
	location[1] = {}
	location[1].ya = 1
	location[1].yb = location.offset
	local count = 2
	while count  <= button_lines do
         location[count] = {}
		 location[count].ya = location[count - 1].yb
		 location[count].yb = location[count - 1].yb + location.offset
         count = count + 1
    end
	if (window:hover(x, y) and window:visible()) or (button:hover(x, y) and button:visible()) or (skillwatch and skill_select_window:hover(x, y) and skill_select_window:visible()) then
		windower.prim.set_visibility('window_button', true)
	else
		windower.prim.set_visibility('window_button', false)
	end
	if mtype == 0 then
		if window:hover(x, y) and window:visible() then
			if (hy > location[2].ya and hy < location[2].yb) then
				windower.prim.set_position('window_button', menu.pos.x, (menu.pos.y + location[2].ya))
				windower.prim.set_size('window_button', mx, (location[2].yb - location[2].ya))
			elseif (hy > location[(button_lines - 2)].ya and hy < location[(button_lines - 2)].yb) and menu_set == 3 and File_Write then
				windower.prim.set_position('window_button', menu.pos.x, (menu.pos.y + location[(button_lines - 2)].ya))
				windower.prim.set_size('window_button', mx, (location[(button_lines - 2)].yb - location[(button_lines - 2)].ya))
			elseif (hy > location[(button_lines - 1)].ya and hy < location[(button_lines - 1)].yb) and menu_set == 3 then
				windower.prim.set_position('window_button', menu.pos.x, (menu.pos.y + location[(button_lines - 1)].ya))
				windower.prim.set_size('window_button', mx, (location[(button_lines - 1)].yb - location[(button_lines - 1)].ya))
			elseif (hy > location[(button_lines)].ya and hy < location[(button_lines)].yb) and menu_set == 3 then
				windower.prim.set_position('window_button', menu.pos.x, (menu.pos.y + location[(button_lines)].ya))
				windower.prim.set_size('window_button', mx, (location[(button_lines)].yb - location[(button_lines)].ya))
			else
				for i, v in ipairs(location) do
					if (hy > location[i].ya and hy < location[i].yb) then
						if type(my_table[i]) == 'table' and not table.contains(hide_button, my_table[i][1]) then
							if not table.contains(hide_button, my_table[i][1]) then
								windower.prim.set_position('window_button', menu.pos.x, (menu.pos.y + location[i].ya))
								windower.prim.set_size('window_button', mx, (location[i].yb - location[i].ya))
							else
								windower.prim.set_visibility('window_button', false)
							end
						else
							windower.prim.set_visibility('window_button', false)
						end
					end
				end
			end
		elseif button:hover(x, y) and button:visible() then
			windower.prim.set_position('window_button', min_window.pos.x, min_window.pos.y)
			windower.prim.set_size('window_button', bmx, bmy)
		elseif skillwatch and skill_select_window:hover(x, y) and skill_select_window:visible() then
			for i, v in ipairs(location) do
				if (hy > location[i].ya and hy < location[i].yb) then
					if not table.contains(hide_button, my_table_skill[i][1]) then
						windower.prim.set_position('window_button', skill_select.pos.x, (skill_select.pos.y + location[i].ya))
						windower.prim.set_size('window_button', mx, (location[i].yb - location[i].ya))
					else
						windower.prim.set_visibility('window_button', false)
					end
				end
			end
		else
			windower.prim.set_visibility('window_button', false)
		end
	elseif mtype == 2 then
		if window:hover(x, y) and window:visible() then
			if (hy > location[2].ya and hy < location[2].yb) then
				window:hide()
				window_hidden = true
				button:show()
			elseif (hy > location[(button_lines - 2)].ya and hy < location[(button_lines - 2)].yb) and menu_set == 3  and File_Write then
				file_write()
			elseif (hy > location[(button_lines - 1)].ya and hy < location[(button_lines - 1)].yb) and menu_set == 3 then
				send_command('gs export')
			elseif (hy > location[(button_lines)].ya and hy < location[(button_lines)].yb) and menu_set == 3 then
				send_command('gs r')
			else
				for i, v in ipairs(location) do
					if (hy > location[i].ya and hy < location[i].yb) then
						if type(my_table[i]) == 'table' then
							if my_table[i][1] then
								menu_commands(my_table[i][1])
								updatedisplay()
							end
						end
					end
				end
			end
		end
		if button:hover(x, y) and button:visible() then
			button:hide()
			window_hidden = false
			updatedisplay()
		end
		if skillwatch and skill_select_window:hover(x, y) and skill_select_window:visible() then
			local skill_code = {['${ax|Axe}']=1,['${cl|Club}']=2,['${dg|Dagger}']=3,['${ga|Great Axe}']=4,['${gk|Great Katana}']=5,['${gs|Great Sword}']=6,
				['${hh|Hand-to-Hand}']=7,['${kt|Katana}']=8,['${pl|Polearm}']=9,['${sc|Scythe}']=10,['${st|Staff}']=11,['${sw|Sword}']=12,
				['${ar|Archery}']=13,['${mk|Marksmanship}']=14,['${th|Throwing}']=15,['${ev|Evasion}']=16,['${gr|Guard}']=17,['${pa|Parrying}']=18,
				['${sh|Shield}']=19,['${bm|Blue Magic}']=20,['${dm|Dark Magic}']=21,['${dvm|Divine Magic}']=22,['${em|Elemental Magic}']=23,
				['${efm|Enfeebling Magic}']=24,['${ehm|Enhancing Magic}']=25,['${go|Geomancy}']=26,['${hb|Handbell}']=27,['${hm|Healing Magic}']=28,
				['${nin|Ninjutsu}']=29,['${so|Singing}']=30,['${sti|Stringed Instrument}']=31,['${smm|Summoning Magic}']=32,['${wi|Wind Instrument}']=33,
				['${aa|Automaton Archery}']=34,['${amg|Automaton Magic}']=35,['${am|Automaton Melee}']=36}
			for i, v in ipairs(location) do
				if (hy > location[i].ya and hy < location[i].yb) then
					skill_count = skill_code[my_table_skill[i]]
					skill_select_window:hide()
					updatedisplay()
				end
			end
		end
	end
end
function menu_commands(a)
	if a == "{stepm}" then
		Stepmax = (Stepmax % 5) + 1
	elseif a == "{ssteps}" then
		Stopsteps = not Stopsteps
	elseif a == "{cstaff}" then
		Changestaff = not Changestaff
	elseif a == "{ustaff}" then
		Usestaff = (Usestaff=='Atk' and 'Acc' or 'Atk')
	elseif a == "{cneckc}" then
		Conquest.neck.change = not Conquest.neck.change
	elseif a == "{cringc}" then
		Conquest.ring.change = not Conquest.ring.change
	elseif a == "{cneck}" then
		Conquest.neck.case_id = (Conquest.neck.case_id % #Conquest.neck.case) + 1
	elseif a == "{cring}" then
		Conquest.ring.case_id = (Conquest.ring.case_id % #Conquest.ring.case) + 1
	elseif a == "{amode}" then
		gear_mode_count = (gear_mode_count % #gear_mode) + 1
	elseif a == '{tmji}' then
		MJi = not MJi
		if MJi and not Disable_All and gearswap.pathsearch({'includes/mjob/main_job_'..player.main_job..'.lua'}) then
			include('includes/mjob/main_job_'..player.main_job..'.lua')
		else
			remove_functions('MJi')
		end
	elseif a == '{tsji}' then
		SJi = not SJi
		if SJi and not Disable_All and gearswap.pathsearch({'includes/sjob/sub_job_'..player.sub_job..'.lua'}) then
			include('includes/sjob/sub_job_'..player.sub_job..'.lua')
		else
			remove_functions('SJi')
		end
	elseif a == '{tmsi}' then
		MSi = not MSi
		if MSi and not Disable_All and table.contains(jobs.magic, player.main_job) and 
														gearswap.pathsearch({'includes/extra_more/MSi.lua'}) then
			include('includes/extra_more/MSi.lua')
		else
			remove_functions('MSi')
		end
	elseif a == '{tfwi}' then
		File_Write = not File_Write
		if file_write then
			file_write()
		end
		if File_Write and not Disable_All and gearswap.pathsearch({'includes/extra_more/File_Write.lua'}) then
			include('includes/extra_more/File_Write.lua')
		else
			remove_functions('File_Write')
		end
	elseif a == '{twsi}' then
		WSi = not WSi
		if WSi and not Disable_All and gearswap.pathsearch({'includes/extra_more/WSi.lua'}) then
			include('includes/extra_more/WSi.lua')
		else
			remove_functions('WSi')
		end
	elseif a == '{tammo}' then
		Ammo = not Ammo
		if Ammo and not Disable_All and table.contains(jobs.ammo, player.main_job) and 
															gearswap.pathsearch({'includes/extra_more/Ammo.lua'}) then
			include('includes/extra_more/Ammo.lua')
		else
			remove_functions('Ammo')
		end
	elseif a == '{tswi}' then
		Special_Weapons = not Special_Weapons
		if Special_Weapons and not Disable_All and gearswap.pathsearch({'includes/extra_more/Special_Weapons.lua'}) then
			include('includes/extra_more/Special_Weapons.lua')
		else
			remove_functions('Special_Weapons')
		end
	elseif a == '{tcgi}' then
		Conquest_Gear = not Conquest_Gear
		if Conquest_Gear and not Disable_All and gearswap.pathsearch({'includes/extra_more/Conquest_Gear.lua'}) then
			include('includes/extra_more/Conquest_Gear.lua')
		else
			remove_functions('Conquest_Gear')
		end
	elseif a == '{trei}' then
		Registered_Events = not Registered_Events
		if Registered_Events and not Disable_All and gearswap.pathsearch({'includes/extra_more/Registered_Events.lua'}) then
			include('includes/extra_more/Registered_Events.lua')
		else
			remove_functions('Registered_Events')
		end
	elseif a == '{tdebug}' then
		Debug = not Debug
		if Debug and not Disable_All and gearswap.pathsearch({'includes/extra_more/Debug.lua'}) then
			include('includes/extra_more/Debug.lua')
		else
			remove_functions('Debug')
		end
	elseif a == '{tmjl}' then
		lvlwatch = not lvlwatch
	elseif a == "{listm}" then
		if custom_menu then
			menu_set = (menu_set % 5) + 1
			initialize(window, menu, 'window')
		else
			menu_set = (menu_set % 4) + 1
			initialize(window, menu, 'window')
		end
	elseif a == "{skill}" then
		skill_select_window:show()
	elseif a == "{tskill}" then
		skillwatch = not skillwatch
		if skillwatch then
			skill_select_window = texts.new(skill_select)
			initialize(skill_select_window, skill_select, 'skill_select_window')
		else
			skill_select_window:destroy()
			my_table_skill = nil
		end
	elseif a == "{tswap}" then
		tswap = not tswap
		if tswap then
			show_swaps(true)
		else
			show_swaps(false)
		end
	elseif a == "{debugm}" then
		debugmod = not debugmod
		if debugmod then
			debug_mode(true)
		else
			debug_mode(false)
		end
	end
	if custom_menu_commands then
		custom_menu_commands(a)
	end
	if file_write then
		file_write()
	end
end
mouse_id = windower.raw_register_event('mouse', mouse)
function remove_functions(a)
	local removeable_functions = {
	['WSi'] = {"sets.weaponskill","equip_elemental_ws_Gear"},
	['Special_Weapons'] = {"special_weapon"},
	['Registered_Events'] = {'skill_type','event_action','level_up','incoming_chunk','target_change,',events = {'action_id','level_up_id','level_down_id','incoming_chunk_id','target_change_id'}},
	['MJi'] = {'cards','card_rule','card_getmore','card_check','nin_tools','nin_tool_rule','nin_tool_check','nin_tool_open','main_job_file_unload','main_job_status_change','main_job_pretarget','main_job_precast','main_job_buff_change','main_job_midcast','main_job_aftercast','main_jobs_self_command','main_job_pet_change','main_job_pet_midcast','main_job_pet_aftercast','main_job_filtered_action','main_job_file_unload'},
	['SJi'] = {'cards','card_rule','card_getmore','card_check','nin_tools','nin_tool_rule','nin_tool_check','nin_tool_open','sub_job_file_unload','sub_job_status_change','sub_job_pretarget','sub_job_precast','sub_job_buff_change','sub_job_midcast','sub_job_aftercast','main_jobs_self_command','sub_job_pet_change','sub_job_pet_midcast','sub_job_pet_aftercast','sub_job_filtered_action','sub_job_file_unload'},
	['MSi'] = {'equip_elemental_magic_staves','equip_elemental_magic_Gear_self_command','sets.staff'},
	['Ammo'] = {'combined_ammo','ammo_check','ammo_reequip','ammo_rule'},
	['Conquest_Gear'] = {'conquest_Gear','conquest_Gear_self_command'},
	['Debug'] = {'debug_status_change','debug_pet_change','debug_filtered_action','debug_pretarget','debug_precast','debug_buff_change','debug_midcast','debug_pet_midcast','debug_aftercast','debug_pet_aftercast','debug_self_command'},
	['Display'] = {'initialize','grab_switches','update_display','updatedisplay','auto_hide_window','mouse','menu_commands','remove_functions',events = {'mouse_id'}},
	['File_Write'] = {'file_write'},}
	if removeable_functions[a].events then
		for i, v in pairs(removeable_functions[a].events) do
			if _G[v] then
				windower.unregister_event(_G[v])
			end
		end
	end
	if removeable_functions[a] then
		for i, v in pairs(removeable_functions[a]) do
			if _G[v] then
				_G[v] = nil
			end
		end
	end
end