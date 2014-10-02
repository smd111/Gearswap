if not Stepmax then
	Stepmax = 1
end
if not Stopsteps then
	Stopsteps = false
end
function main_job_precast(spell)
	if spell.type == 'Samba' and spell.english:startswith('Drain Samba') then
		if player.tp >= 250 and player.main_job_level >= 65 then
			if spell.english ~= 'Drain Samba II' then
				cancel_spell()
				send_command('@input /ja "Drain Samba III" <me>')
				return
			end
		elseif player.tp >= 250 and player.main_job_level >= 35 then
			if spell.english ~= 'Drain Samba II' then
				cancel_spell()
				send_command('@input /ja "Drain Samba II" <me>')
				return
			end
		elseif player.tp >= 100 and player.main_job_level >= 5 then
			if spell.english ~= 'Drain Samba' then
				cancel_spell()
				send_command('@input /ja "Drain Samba" <me>')
				return
			end
		else
			cancel_spell()
		end
	end
	if spell.type == 'Step' then
		if spell.tp_cost > player.tp then
			cancel_spell()
			return
		end
		if Stopsteps then
			if buffactive['Finishing Move '..Stepmax] then
				cancel_spell()
				return
			end
		end
	end
	if spell.english == 'Reverse Flourish' then
		if player.tp >= 2750 then
			cancel_spell()
			return
		end
	end
end
function main_jobs_command(command)
	if command == 'tstopsteps' then
		Stopsteps = not Stopsteps
		-- add_to_chat(7, '----- Steps Will ' .. (Stopsteps and '' or 'Not ') .. 'Stop -----')
	end
	if command == 'stepcount' then
		Stepmax = (Stepmax % 5) + 1
		-- add_to_chat(7,'Max step = ' ..Stepmax)
	end
end