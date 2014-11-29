
	sets.drk_job = {neck='Nyx Gorget',left_ear='Chaotic Earring'}

function sub_job_buff_change(name,gain,status,set_gear)
	if name == "Arcane Circle" then
		if gain then
			set_gear = set_combine(set_gear, sets.drk_job)
			disable("neck","left_ear")
		else
			enable("neck","left_ear")
			set_gear = set_combine(set_gear, sets[player.status])
		end
	end
	return set_gear
end