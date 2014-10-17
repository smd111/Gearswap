if not Stepmax then
	Stepmax = 1
end
if not Stopsteps then
	Stopsteps = false
end
	Hwauto = false
--any functions you do not need should be removed or will cause errors
function main_job_precast(spell,status,set_gear)
	---------------------------------------
	--put your precast rules here
	---------------------------------------
	--equip example: equip_pre_cast = set_combine(equip_pre_cast, sets.Engaged)
	---------------------------------------
	if spell.type == 'Step' then
		if spell.tp_cost > player.tp then
			status.end_spell=true
			status.end_event=true
			return
		end
		if Stopsteps then
			if buffactive['Finishing Move '..Stepmax] then
				status.end_spell=true
				status.end_event=true
				return
			end
		end
	end
	if spell.english == 'Spectral Jig' then
		send_command('cancel 71')
	end
	if spell.english == 'Reverse Flourish' then
		if player.tp >= 2750 then
			status.end_spell=true
			status.end_event=true
			return
		end
	end
end
function main_jobs_command(command)
	---------------------------------------
	--put your self_command rules here
	---------------------------------------
	if command == 'tstopsteps' then
		Stopsteps = not Stopsteps
		-- add_to_chat(7, '----- Steps Will ' .. (Stopsteps and '' or 'Not ') .. 'Stop -----')
	end
	if command == 'stepcount' then
		Stepmax = (Stepmax % 5) + 1
		-- add_to_chat(7,'Max step = ' ..Stepmax)
	end
	if command == 'autohw' then
		Hwauto = not Hwauto
		add_to_chat(7, '----- Auto Healing Waltz Is ' .. (Hwauto and 'Enabled' or 'Disabled'))
	end
end
