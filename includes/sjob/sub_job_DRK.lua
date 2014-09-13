
	sets.drk = {neck='Nyx Gorget',left_ear='Chaotic Earring'}

function sub_job_buff_change(name,gain)
	if name == "Arcane Circle" then
		if gain then
			equip(sets.drk)
			disable("neck","left_ear")
		else
			enable("neck","left_ear")
			equip(sets[player.status])
		end
	end
end