--File Write
function file_write()
	if not windower.dir_exists(lua_base_path..'data/'..player.name..'/Saves') then
		windower.create_dir(lua_base_path..'data/'..player.name..'/Saves')
	end
	local file = io.open(lua_base_path..'data/'..player.name..'/Saves/job_'..player.main_job..'var.lua',"w")
	file:write(
		'Stepmax = '..tostring(Stepmax)..
		'\nStopsteps = '..tostring(Stopsteps)..
		'\nConquest.neck.change = '..tostring(Conquest.neck.change)..
		'\nConquest.neck.case_id = '..tostring(Conquest.neck.case_id)..
		'\nConquest.ring.change = '..tostring(Conquest.ring.change)..
		'\nConquest.ring.case_id = '..tostring(Conquest.ring.case_id)..
		'\nspecialweaponwscount = '..tostring(specialweaponwscount)..
		'\nif Display then'..
		'\nbox.pos.x = '..tostring(box.pos.x)..
		'\nbox.pos.y = '..tostring(box.pos.y)..
		'\nMJi = '..tostring(MJi)..
		'\nSJi = '..tostring(SJi)..
		'\nMSi = '..tostring(MSi)..
		'\nWSi = '..tostring(WSi)..
		'\nAmmo = '..tostring(Ammo)..
		'\nSpecial_Weapons = '..tostring(Special_Weapons)..
		'\nConquest_Gear = '..tostring(Conquest_Gear)..
		'\nRegistered_Events = '..tostring(Registered_Events)..
		'\nDebug = '..tostring(Debug)..
		'\nlvlwatch = '..tostring(lvlwatch)..
		'\nend'..
		'')
	if player.main_job == 'WHM' or player.main_job == 'BLM' or player.main_job == 'RDM' or player.main_job == 'BRD' or player.main_job == 'SMN'
																					or player.main_job == 'SCH' or player.main_job == 'GEO' then
		file:write(
			'\nChangestaff = '..tostring(Changestaff)..
			'\nUsestaff = "'..tostring(Usestaff)..'"'..
			'')
	end
	file:close()
end