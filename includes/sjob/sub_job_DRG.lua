
	sets.drg = {body="Barone Corazza",legs="Barone Cosciales"}

function sub_job_precast(spell)
	if spell.english == 'Jump' then
		equip(sets.drg)
	end
	if spell.english == 'High Jump' then
		equip(sets.drg)
	end
end