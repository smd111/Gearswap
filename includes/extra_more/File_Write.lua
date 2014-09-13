--File Write
function file_write(a)
	local file = io.open(lua_base_path..'data/'..player.name..'/Saves/job_'..player.main_job..'var.lua',"w")
	file:write(
		'Stepmax = '..tostring(Stepmax)..
		'\nStopsteps = '..tostring(Stopsteps)..
		'\nConquest.neck.change = '..tostring(Conquest.neck.change)..
		'\nConquest.neck.case_id = '..tostring(Conquest.neck.case_id)..
		'\nConquest.ring.change = '..tostring(Conquest.ring.change)..
		'\nConquest.ring.case_id = '..tostring(Conquest.ring.case_id)..
		'\nspecialweaponwscount = '..tostring(specialweaponwscount)..
		'\nbox.pos.x = '..tostring(box.pos.x)..
		'\nbox.pos.y = '..tostring(box.pos.y)..
		'')
	if windower.wc_match(player.main_job, "WHM|BLM|RDM|BRD|SMN|SCH|GEO") then
		file:write(
			'\nChangestaff = '..tostring(Changestaff)..
			'\nUsestaff = "'..tostring(Usestaff)..'"'..
			'')
	end
	file:close()
	local fileb = io.open(lua_base_path..'data/'..player.name..'/Saves/last_job.lua',"w")
	fileb:write(
		'last_main_job = "'..tostring(player.main_job)..'"'..
		'')
	fileb:close()
	if a then
		local filea = io.open(lua_base_path..'data/'..player.name..'/Saves/registered_events.lua',"w")
		if id_action then
			filea:write(
				'\nid_action = '..tostring(id_action)..
				'')
		end
		if id_incoming_chunk then
			filea:write(
				'\nid_incoming_chunk = '..tostring(id_incoming_chunk)..
				'')
		end
		if id_outgoing_chunk then
			filea:write(
				'\nid_outgoing_chunk = '..tostring(id_outgoing_chunk)..
				'')
		end
		if id_target_change then
			filea:write(
				'\nid_target_change = '..tostring(id_target_change)..
				'')
		end
		filea:close()
	end
end