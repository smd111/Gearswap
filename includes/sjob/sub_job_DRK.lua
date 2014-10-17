
	sets.drk = {neck='Nyx Gorget',left_ear='Chaotic Earring'}

function sub_job_buff_change(name,gain,status,set_gear)
	if name == "Arcane Circle" then
		if gain then
			equip_set(set_gear, sets.drk)
			disable("neck","left_ear")
		else
			enable("neck","left_ear")
			equip_set(set_gear, [player.status])
		end
	end
end