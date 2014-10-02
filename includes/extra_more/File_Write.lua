--File Write
function file_write()
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
end