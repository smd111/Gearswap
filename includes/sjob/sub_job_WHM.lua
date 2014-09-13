function sub_job_precast(spell)
	if Cure.spells:contains(spell.english) and spell.target.type == 'SELF' then
		if player.hpp <= 75 and player.mp >= 88 and player.sub_job_level >= 41 then
			if spell.english ~= 'Cure IV' then
				cancel_spell()
				send_command('@input /ma "Cure IV" <me>')
				return
			end
		elseif player.hpp <= 75 and player.mp >= 46 and player.sub_job_level >= 21 then
			if spell.english ~= 'Cure III' then
				cancel_spell()
				send_command('@input /ma "Cure III" <me>')
				return
			end
		elseif player.hpp <= 75 and player.mp >= 24 and player.sub_job_level >= 11 then
			if spell.english ~= 'Cure II' then
				cancel_spell()
				send_command('@input /ma "Cure II" <me>')
				return
			end
		elseif player.hpp <= 75 and player.mp >= 8 and player.sub_job_level >= 1 then
			if spell.english ~= 'Cure' then
				cancel_spell()
				send_command('@input /ma "Cure" <me>')
				return
			end
		else
			cancel_spell()
		end
	end
end