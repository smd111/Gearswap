
	sets.sam = {left_ear='Haten Earring'}

function sub_job_precast(spell)
	if spell.english == 'Meditate' then
		if player.tp >= 2750 then
			cancel_spell()
		end
	end
end