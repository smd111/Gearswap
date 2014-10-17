
	sets.drg = {body="Barone Corazza",legs="Barone Cosciales"}

function sub_job_precast(spell,status,set_gear)
	if spell.english == 'Jump' then
		equip_set(set_gear, sets.drg)
	end
	if spell.english == 'High Jump' then
		equip_set(set_gear, sets.drg)
	end
end