--File Write
function file_write(a)
    if not windower.dir_exists(lua_base_path..'data/'..player.name..'/Saves') then
        windower.create_dir(lua_base_path..'data/'..player.name..'/Saves')
    end
    local file = io.open(lua_base_path..'data/'..player.name..'/Saves/job_'..player.main_job..'var.lua',"w")
    file:write('Stepmax = '..tostring(Stepmax)..    '\nStopsteps = '..tostring(Stopsteps)..'\nConquest.neck.change = '..tostring(Conquest.neck.change)..
        '\nConquest.neck.case_id = '..tostring(Conquest.neck.case_id)..'\nConquest.ring.change = '..tostring(Conquest.ring.change)..
        '\nConquest.ring.case_id = '..tostring(Conquest.ring.case_id)..'\nspecialweaponwscount = '..tostring(specialweaponwscount)..
        '\nweapon_types_count = '..tostring(weapon_types_count)..'\nrange_type_count = '..tostring(range_type_count)..
        '\nif Display then'..'\n  menu.pos.x = '..tostring(menu.pos.x)..
        '\n  menu.pos.y = '..tostring(menu.pos.y)..'\n  MJi = '..tostring(MJi)..'\n  SJi = '..tostring(SJi)..'\n  MSi = '..tostring(MSi)..
        '\n  WSi = '..tostring(WSi)..'\n  Ammo = '..tostring(Ammo)..'\n  Special_Weapons = '..tostring(Special_Weapons)..
        '\n  Conquest_Gear = '..tostring(Conquest_Gear)..'\n  File_Write = '..tostring(File_Write)..'\n  Registered_Events = '..tostring(Registered_Events)..
        '\n  Debug = '..tostring(Debug)..'\n  lvlwatch = '..tostring(lvlwatch)..'\n  tswap = '..tostring(tswap)..'\n  debugmod = '..tostring(debugmod)..'\nend'..'')
    if table.contains(jobs.magic, player.main_job) then
        file:write('\nChangestaff = '..tostring(Changestaff)..'\nUsestaff = "'..tostring(Usestaff)..'"'..'')
    end
    file:close()
    if a then
        add_to_chat(7, '/Saves/job_'..player.main_job..'var.lua has been forcibly rewritten.')
    end
end