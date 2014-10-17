if not Stepmax then
	Stepmax = 1
end
if not Stopsteps then
	Stopsteps = false
end
	Hwauto = false

function sub_job_precast(spell,status,set_gear)
	if spell.type == 'Waltz' and spell.target.type == 'SELF' then
		if player.hpp >= 75 and has_any_buff_of(Waltz.debuff) and player.sub_job_level > 34 then
			if spell.english ~= 'Healing Waltz' then
				send_command('@input /ja "Healing Waltz" <me>')
				status.end_spell=true
				status.end_event=true
				return
			end
		elseif player.tp >= 500 and player.hpp <= 75 and player.sub_job_level > 44 then
			if spell.english ~= 'Curing Waltz III' then
				send_command('@input /ja "Curing Waltz III" <me>')
				status.end_spell=true
				status.end_event=true
				return
			end
		elseif player.tp >= 350 and player.hpp <= 75 and player.sub_job_level > 29 then
			if spell.english ~= 'Curing Waltz II' then
				send_command('@input /ja "Curing Waltz II" <me>')
				status.end_spell=true
				status.end_event=true
				return
			end
		elseif player.tp >= 200 and player.hpp <= 75 and player.sub_job_level > 14 then
			if spell.english ~= 'Curing Waltz' then
				send_command('@input /ja "Curing Waltz" <me>')
				status.end_spell=true
				status.end_event=true
				return
			end
		else
			status.end_spell=true
		end
	end
	if spell.type == 'Waltz' and spell.target.type ~= 'SELF' then
		if player.tp >= 500 and spell.target.hpp <= 75 and player.sub_job_level > 44 then
			if spell.english ~= 'Curing Waltz III' then
				send_command('@input /ja "Curing Waltz III" '..spell.target.raw)
				status.end_spell=true
				status.end_event=true
				return
			end
		elseif player.tp >= 350 and spell.target.hpp <= 75 and player.sub_job_level > 29 then
			if spell.english ~= 'Curing Waltz II' then
				send_command('@input /ja "Curing Waltz II" '..spell.target.raw)
				status.end_spell=true
				status.end_event=true
				return
			end
		elseif player.tp >= 200 and spell.target.hpp <= 75 and player.sub_job_level > 14 then
			if spell.english ~= 'Curing Waltz' then
				send_command('@input /ja "Curing Waltz" '..spell.target.raw)
				status.end_spell=true
				status.end_event=true
				return
			end
		else
			cancel_spell()
		end
	end
	if spell.type == 'Samba' then
		if player.tp >= 250 and player.sub_job_level >= 35 then
			if spell.english ~= 'Drain Samba II' then
				send_command('@input /ja "Drain Samba II" <me>')
				status.end_spell=true
				status.end_event=true
				return
			end
		elseif player.tp >= 100 and player.sub_job_level >= 5 then
			if spell.english ~= 'Drain Samba' then
				send_command('@input /ja "Drain Samba" <me>')
				status.end_spell=true
				status.end_event=true
				return
			end
		else
			status.end_spell=true
		end
	end
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
function sub_job_buff_change(name,gain,status,set_gear)
	if Hwauto and windower.wc_match(name, "Max * Down|Magic * Down|* Down|bane|Bio|blindness|curse|Dia|disease|Shock|Rasp|Choke|Frost|Burn|Drown|Flash|paralysis|plague|poison|silence|slow|weight") then
		if gain and player.tp >= 200 and player.sub_job_level > 34 then
			send_command('@input /ja "Healing Waltz" <me>')
		end
	end
end
function sub_jobs_command(command)
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