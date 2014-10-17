box.text = {}
box.text.font = 'Dotum'
box.text.size = 9
box.text.red = 255
box.text.green = 0
box.text.blue = 0
box.bg = {}
box.bg.alpha = 100
box.flags = {}
box.flags.draggable = true
boxb = {}
boxb.text = {}
boxb.text.font = 'Dotum'
boxb.text.size = 9
boxb.text.red = 255
boxb.text.green = 0
boxb.text.blue = 0
boxb.bg = {}
boxb.bg.alpha = 100
boxb.flags = {}
boxb.flags.draggable = false
boxb.pos = {}
boxb.pos.x = 0
boxb.pos.y = 400
auto_hide_cycle = 0
--display functions---------------------------------------------------------------------------------------------------------------
--Display Creator
menu_list ={'\\cs(255,255,0)[J]\\cr  A  S1  S2  C','J  \\cs(255,255,0)[A]\\cr  S1  S2  C','J  A  \\cs(255,255,0)[S1]\\cr  S2  C','J  A  S1  \\cs(255,255,0)[S2]\\cr  C','J  A  S1  S2  \\cs(255,255,0)[C]\\cr'}
menu_set = 1
window = texts.new(box)
button = texts.new(boxb)
function initialize(text, settings, a)
	if a == 'window' then
		local properties = L{}
		properties:append('Gearswap   \\cs(255,255,0)HIDE\\cr')
		if menu_set == 1 then -- job menu
			properties:append('Job Settings')
			if windower.ffxi.get_player().sub_job == 'DNC' and SJi then
				properties:append('Max Step = \\cs(255,255,0)${stepm}\\cr')
				properties:append('Steps')
				properties:append('  \\cs(255,255,0)Will ${ssteps}Stop\\cr')
			end
			if windower.ffxi.get_player().main_job == 'DNC' and MJi then
				properties:append('Max Step = \\cs(255,255,0)${stepm}\\cr')
				properties:append('Steps')
				properties:append('  \\cs(255,255,0)Will ${ssteps}Stop\\cr')
			end
			if lvlwatch then
				properties:append('\\cs(0,255,0)${mjob}\\cr')
				properties:append('   lvl = \\cs(255,255,0)${mjob_lvl}\\cr')
			end
		elseif menu_set == 2 then -- armor menu
			properties:append('Armor Settings')
			if windower.wc_match(windower.ffxi.get_player().main_job, "WHM|BLM|RDM|BRD|SMN|SCH|GEO") and WSi then
				properties:append('Staves')
				properties:append('  \\cs(255,255,0)Will ${cstaff}Change\\cr')
				properties:append('Staves Set To \\cs(255,255,0)${ustaff}\\cr')
			end
			properties:append('Mode = \\cs(255,255,0)${amode}\\cr')
			if Conquest_Gear then
				properties:append('Conquest Neck')
				properties:append('  \\cs(255,255,0)Will ${cneckc}Change\\cr')
				properties:append('Conquest Ring')
				properties:append('  \\cs(255,255,0)Will ${cringc}Change\\cr')
				properties:append('Conquest')
				properties:append('  \\cs(0,255,0)Neck Type = \\cs(255,255,0)${cneck}\\cr')
				properties:append('  \\cs(0,255,0)Ring Type = \\cs(255,255,0)${cring}\\cr')
			end
		elseif menu_set == 3 then -- system menu
			properties:append('System Settings')
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
			properties:append('\\cs(255,255,0)Reload Gearswap\\cr')
		elseif menu_set == 4 then -- system menu2
			properties:append('System Settings')
			properties:append('Main Job includes')
			properties:append('   ${tmji}')
			properties:append('Sub Job Includes')
			properties:append('   ${tsji}')
			properties:append('Mage Stave Include')
			properties:append('   ${tmsi}')
			properties:append('Weapon Skill Include')
			properties:append('   ${twsi}')
			properties:append('Ammo Include')
			properties:append('   ${tammo}')
			properties:append('Special Weapons Include')
			properties:append('   ${tswi}')--
			properties:append('Conquest Gear Include')
			properties:append('   ${tcgi}')
			properties:append('Registered Events Include')
			properties:append('   ${trei}')
			properties:append('Debug Include')
			properties:append('   ${tdebug}')
			properties:append('Display Main Job and LVL')
			properties:append('   ${tmjl}')
		elseif menu_set == 5 then --custom menu
			properties:append('Custom Menu')
			for i,v in pairs(custom_menu()) do
				if type(v) == 'string' then
					properties:append(v)
				end
			end
		end
		properties:append('${listm}')
		text:clear()
		text:append(properties:concat('\n'))
		grab_switches(properties)
	end
	if a == 'button' then
		local properties_button = L{}
		properties_button:append('Gearswap  \\cs(255,255,0)SHOW\\cr')
		if lvlwatch then
			properties_button:append('\\cs(0,255,0)${mjob}\\cr\n   lvl = \\cs(255,255,0)${mjob_lvl}\\cr')
		end
		text:clear()
		text:append(properties_button:concat('\n'))
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
initialize(window, box, 'window')
initialize(button, boxb, 'button')
--Display Updater
function update_display()
	windower.prim.create('window_button')
	windower.prim.set_color('window_button', 100, 255, 255, 255)
	windower.prim.set_visibility('window_button', false)
	updatedisplay()
end
function updatedisplay()
	initialize(window, box, 'window')
	initialize(button, boxb, 'button')
	local info = {}
	if SJi then
		info.stepm = Stepmax
		info.ssteps = Stopsteps and '' or 'Not '
	end
	if WSi then
		info.cstaff = Changestaff and '' or 'Not '
		info.ustaff = Usestaff
	end
	if Conquest_Gear then
		info.cneckc = Conquest.neck.change and '' or 'Not '
		info.cringc = Conquest.ring.change and '' or 'Not '
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
	info.tmji = MJi and '\\cs(0,255,0)Enabled\\cr' or '\\cs(255,255,0)Disabled\\cr'
	info.tsji = SJi and '\\cs(0,255,0)Enabled\\cr' or '\\cs(255,255,0)Disabled\\cr'
	info.tmsi = MSi and '\\cs(0,255,0)Enabled\\cr' or '\\cs(255,255,0)Disabled\\cr'
	info.twsi = WSi and '\\cs(0,255,0)Enabled\\cr' or '\\cs(255,255,0)Disabled\\cr'
	info.tammo = Ammo and '\\cs(0,255,0)Enabled\\cr' or '\\cs(255,255,0)Disabled\\cr'
	info.tswi = Special_Weapons and '\\cs(0,255,0)Enabled\\cr' or '\\cs(255,255,0)Disabled\\cr'
	info.tcgi = Conquest_Gear and '\\cs(0,255,0)Enabled\\cr' or '\\cs(255,255,0)Disabled\\cr'
	info.trei = Registered_Events and '\\cs(0,255,0)Enabled\\cr' or '\\cs(255,255,0)Disabled\\cr'
	info.tdebug = Debug and '\\cs(0,255,0)Enabled\\cr' or '\\cs(255,255,0)Disabled\\cr'
	info.tmjl = lvlwatch and '\\cs(0,255,0)Enabled\\cr' or '\\cs(255,255,0)Disabled\\cr'
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
	local hide_button = {'{mjob}','{mjob_lvl}'}
	local mx, my = windower.text.get_extents(window._name)
	local bmx, bmy = windower.text.get_extents(button._name)
	local button_lines = window:text():count('\n') + 1
	local hx = (x - box.pos.x)
	local hy = (y - box.pos.y)
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
	if mtype == 0 then
		if window:hover(x, y) and window:visible() then
			if (hy > location[1].ya and hy < location[1].yb) then
				windower.prim.set_position('window_button', box.pos.x, (box.pos.y + location[1].ya))
				windower.prim.set_size('window_button', mx, (location[1].yb - location[1].ya))
				windower.prim.set_visibility('window_button', true)
			elseif (hy > location[(button_lines - 1)].ya and hy < location[(button_lines - 1)].yb) and menu_set == 3 then
				windower.prim.set_position('window_button', box.pos.x, (box.pos.y + location[(button_lines - 1)].ya))
				windower.prim.set_size('window_button', mx, (location[(button_lines - 1)].yb - location[(button_lines - 1)].ya))
				windower.prim.set_visibility('window_button', true)
			else
				for i, v in ipairs(location) do
					if (hy > location[i].ya and hy < location[i].yb) then
						if type(my_table[i]) == 'table' and not table.contains(hide_button, my_table[i][1]) then
							if not table.contains(hide_button, my_table[i][1]) then
								windower.prim.set_position('window_button', box.pos.x, (box.pos.y + location[i].ya))
								windower.prim.set_size('window_button', mx, (location[i].yb - location[i].ya))
								windower.prim.set_visibility('window_button', true)
							end
						else
							windower.prim.set_visibility('window_button', false)
						end
					end
				end
			end
		elseif button:hover(x, y) and button:visible() then
			windower.prim.set_position('window_button', boxb.pos.x, boxb.pos.y)
			windower.prim.set_size('window_button', bmx, bmy)
			windower.prim.set_visibility('window_button', true)
		else
			windower.prim.set_visibility('window_button', false)
		end
	elseif mtype == 2 then
		if window:hover(x, y) and window:visible() then
			if (hy > location[1].ya and hy < location[1].yb) then
				window:hide()
				window_hidden = true
				button:show()
			elseif (hy > location[(button_lines - 1)].ya and hy < location[(button_lines - 1)].yb) and menu_set == 3 then
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
	elseif a == '{tsji}' then
		SJi = not SJi
	elseif a == '{tmsi}' then
		MSi = not MSi
	elseif a == '{twsi}' then
		WSi = not WSi
	elseif a == '{tammo}' then
		Ammo = not Ammo
	elseif a == '{tswi}' then
		Special_Weapons = not Special_Weapons
	elseif a == '{tcgi}' then
		Conquest_Gear = not Conquest_Gear
	elseif a == '{trei}' then
		Registered_Events = not Registered_Events
	elseif a == '{tdebug}' then
		Debug = not Debug
	elseif a == '{tmjl}' then
		lvlwatch = not lvlwatch
	elseif a == "{listm}" then
		if custom_menu then
			menu_set = (menu_set % 5) + 1
			initialize(window, box, 'window')
		else
			menu_set = (menu_set % 4) + 1
			initialize(window, box, 'window')
		end
	end
	if custom_menu_commands then
		custom_menu_commands(a)
	end
end
windower.raw_register_event('mouse', mouse)