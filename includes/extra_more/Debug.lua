	-- How To Use
	-- 1. put include('Debug include.lua') in function get_sets()
	-- 2. put debug_status_change(new,old) in function status_change(new,old)
	-- 3. put debug_pet_change(pet,gain) in function pet_change(pet,gain)
	-- 4. put debug_filtered_action(spell) in function filtered_action(spell)
	-- 5. put debug_pretarget(spell) in function pretarget(spell)
	-- 6. put debug_buff_change(name,gain) in function buff_change(name,gain)
	-- 7. put debug_midcast(spell) in function midcast(spell)
	-- 8. put debug_pet_midcast(spell) in function pet_midcast(spell)
	-- 9. put debug_aftercast(spell) in function aftercast(spell)
	-- 10. put debug_pet_aftercast(spell) in function pet_aftercast(spell)
	-- 11. use this command to enable/disable verbose debug mode //gs c Debug
	-- 12. use this command to cycle through debug types //gs c Debugtype

	fulldebug = false
	fulldebug.type = {"status_change","pet_change","filtered_action","pretarget","precast","buff_change","midcast","pet_midcast","aftercast","pet_aftercast","All"}
	fulldebug.count = 1

function debug_status_change(new,old)
	if fulldebug then
		if fulldebug.count == 1 or fulldebug.count == 11 then
			add_to_chat(7,"Status= "..tostring(new))
			add_to_chat(7,"Status= "..tostring(old))
		end
	end
end

function debug_pet_change(pet,gain)
	if fulldebug then
		if fulldebug.count == 2 or fulldebug.count == 11 then
			add_to_chat(7,"Pet= "..pet..", Gain= "..tostring(gain))
			add_to_chat(7,"Pet Element= "..tostring(pet.element))
		end
	end
end

function debug_filtered_action(spell)
	if fulldebug then
		if fulldebug.count == 3 or fulldebug.count == 11 then
			add_to_chat(7,"Spell Name= "..tostring(spell.english))
			add_to_chat(7,"Spell Type= "..tostring(spell.type))
			add_to_chat(7,"Spell Element= "..tostring(spell.element))
			add_to_chat(7,"Spell Target Type= "..tostring(spell.target.type))
			add_to_chat(7,"Day Element= "..tostring(world.day_element))
			add_to_chat(7,"Weather Element= "..tostring(world.weather_element))
			add_to_chat(7,"Moon Phase= "..tostring(world.moon))
			add_to_chat(7,"Zone Name= "..tostring(world.zone))
		end
	end
end

function debug_pretarget(spell)
	if fulldebug then
		if fulldebug.count == 4 or fulldebug.count == 11 then
			add_to_chat(7,"Spell Name= "..tostring(spell.english))
			add_to_chat(7,"Spell Type= "..tostring(spell.type))
			add_to_chat(7,"Spell Element= "..tostring(spell.element))
			add_to_chat(7,"Spell Target Type= "..tostring(spell.target.type))
			add_to_chat(7,"Day Element= "..tostring(world.day_element))
			add_to_chat(7,"Weather Element= "..tostring(world.weather_element))
			add_to_chat(7,"Moon Phase= "..tostring(world.moon))
			add_to_chat(7,"Zone Name= "..tostring(world.zone))
		end
	end
end

function debug_precast(spell)
	if fulldebug then
		if fulldebug.count == 5 or fulldebug.count == 11 then
			add_to_chat(7,"Spell Name= "..tostring(spell.english))
			add_to_chat(7,"Spell Type= "..tostring(spell.type))
			add_to_chat(7,"Spell Element= "..tostring(spell.element))
			add_to_chat(7,"Spell Target Type= "..tostring(spell.target.type))
			add_to_chat(7,"Day Element= "..tostring(world.day_element))
			add_to_chat(7,"Weather Element= "..tostring(world.weather_element))
			add_to_chat(7,"Moon Phase= "..tostring(world.moon))
			add_to_chat(7,"Zone Name= "..tostring(world.zone))
		end
	end
end

function debug_buff_change(name,gain)
	if fulldebug then
		if fulldebug.count == 6 or fulldebug.count == 11 then
			add_to_chat(7,"Buff= "..name..', Gain='..tostring(gain))
		end
	end
end

function debug_midcast(spell)
	if fulldebug then
		if fulldebug.count == 7 or fulldebug.count == 11 then
			add_to_chat(7,"Spell Name= "..tostring(spell.english))
			add_to_chat(7,"Spell Type= "..tostring(spell.type))
			add_to_chat(7,"Spell Element= "..tostring(spell.element))
			add_to_chat(7,"Spell Target Type= "..tostring(spell.target.type))
			add_to_chat(7,"Day Element= "..tostring(world.day_element))
			add_to_chat(7,"Weather Element= "..tostring(world.weather_element))
			add_to_chat(7,"Moon Phase= "..tostring(world.moon))
			add_to_chat(7,"Zone Name= "..tostring(world.zone))
		end
	end
	return
end

function debug_pet_midcast(spell)
	if fulldebug then
		if fulldebug.count == 8 or fulldebug.count == 11 then
			add_to_chat(7,"Spell Name= "..tostring(spell.english))
			add_to_chat(7,"Spell Type= "..tostring(spell.type))
			add_to_chat(7,"Spell Element= "..tostring(spell.element))
			add_to_chat(7,"Spell Target Type= "..tostring(spell.target.type))
			add_to_chat(7,"Day Element= "..tostring(world.day_element))
			add_to_chat(7,"Weather Element= "..tostring(world.weather_element))
			add_to_chat(7,"Moon Phase= "..tostring(world.moon))
			add_to_chat(7,"Zone Name= "..tostring(world.zone))
		end
	end
end

function debug_aftercast(spell)
	if fulldebug then
		if fulldebug.count == 9 or fulldebug.count == 11 then
			add_to_chat(7,"Spell Name= "..tostring(spell.english))
			add_to_chat(7,"Spell Type= "..tostring(spell.type))
			add_to_chat(7,"Spell Element= "..tostring(spell.element))
			add_to_chat(7,"Spell Target Type= "..tostring(spell.target.type))
			add_to_chat(7,"Day Element= "..tostring(world.day_element))
			add_to_chat(7,"Weather Element= "..tostring(world.weather_element))
			add_to_chat(7,"Moon Phase= "..tostring(world.moon))
			add_to_chat(7,"Zone Name= "..tostring(world.zone))
		end
	end
end

function debug_pet_aftercast(spell)
	if fulldebug then
		if fulldebug.count == 10 or fulldebug.count == 11 then
			add_to_chat(7,"Spell Name= "..tostring(spell.english))
			add_to_chat(7,"Spell Type= "..tostring(spell.type))
			add_to_chat(7,"Spell Element= "..tostring(spell.element))
			add_to_chat(7,"Spell Target Type= "..tostring(spell.target.type))
			add_to_chat(7,"Day Element= "..tostring(world.day_element))
			add_to_chat(7,"Weather Element= "..tostring(world.weather_element))
			add_to_chat(7,"Moon Phase= "..tostring(world.moon))
			add_to_chat(7,"Zone Name= "..tostring(world.zone))
		end
	end
end

function debug_self_command(command)
	--add_to_chat(7,"Command= "..tostring(command))
	if command == 'Debug' then
		fulldebug = not fulldebug
		send_command('clear log')
		send_command('gs debug_mode;wait 0.3;gs show_swaps')
		add_to_chat(7,'Debug Mode = ' .. (fulldebug and 'ON' or 'OFF'))
	end
	if command == 'Debugtype' then
		fulldebug.count = (fulldebug.count % #fulldebug.type) + 1
		add_to_chat(7,'Debug Mode Type = ' .. tostring(fulldebug.type[fulldebug.count]))
	end
end