function sub_job_precast(spell)
	if spell.type == 'Waltz' and spell.target.type == 'SELF' then
		if player.hpp >= 75 and has_any_buff_of(Waltz.debuff) and player.sub_job_level > 34 then
			if spell.english ~= 'Healing Waltz' then
				cancel_spell()
				send_command('@input /ja "Healing Waltz" <me>')
				return
			end
		elseif player.tp >= 500 and player.hpp <= 75 and player.sub_job_level > 44 then
			if spell.english ~= 'Curing Waltz III' then
				cancel_spell()
				send_command('@input /ja "Curing Waltz III" <me>')
				return
			end
		elseif player.tp >= 350 and player.hpp <= 75 and player.sub_job_level > 29 then
			if spell.english ~= 'Curing Waltz II' then
				cancel_spell()
				send_command('@input /ja "Curing Waltz II" <me>')
				return
			end
		elseif player.tp >= 200 and player.hpp <= 75 and player.sub_job_level > 14 then
			if spell.english ~= 'Curing Waltz' then
				cancel_spell()
				send_command('@input /ja "Curing Waltz" <me>')
				return
			end
		else
			cancel_spell()
		end
	end
	if spell.type == 'Waltz' and spell.target.type ~= 'SELF' then
		if player.tp >= 500 and spell.target.hpp <= 75 and player.sub_job_level > 44 then
			if spell.english ~= 'Curing Waltz III' then
				cancel_spell()
				send_command('@input /ja "Curing Waltz III" <me>')
				return
			end
		elseif player.tp >= 350 and spell.target.hpp <= 75 and player.sub_job_level > 29 then
			if spell.english ~= 'Curing Waltz II' then
				cancel_spell()
				send_command('@input /ja "Curing Waltz II" <me>')
				return
			end
		elseif player.tp >= 200 and spell.target.hpp <= 75 and player.sub_job_level > 14 then
			if spell.english ~= 'Curing Waltz' then
				cancel_spell()
				send_command('@input /ja "Curing Waltz" <me>')
				return
			end
		else
			cancel_spell()
		end
	end
	if spell.english:startswith('Drain Samba') then
		if player.tp >= 250 and player.sub_job_level >= 35 then
			if spell.english ~= 'Drain Samba II' then
				cancel_spell()
				send_command('@input /ja "Drain Samba II" <me>')
				return
			end
		elseif player.tp >= 100 and player.sub_job_level >= 5 then
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
	if spell.english == 'Spectral Jig' then
		send_command('cancel 71')
	end
	if spell.english == 'Reverse Flourish' then
		if player.tp >= 2750 then
			cancel_spell()
			return
		end
	end
end 

function sub_job_buff_change(name,gain)
	if Hwauto and windower.wc_match(name, "Max * Down|Magic * Down|* Down|bane|Bio|blindness|curse|Dia|disease|Shock|Rasp|Choke|Frost|Burn|Drown|Flash|paralysis|plague|poison|silence|slow|weight") then
		if gain and player.tp >= 200 and player.sub_job_level > 34 then
			send_command('@input /ja "Healing Waltz" <me>')
		end
	end
end