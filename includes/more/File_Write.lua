--File Write
function File_Write_do(a)
    if not windower.dir_exists(lua_base_path..'data/'..player.name) then
        windower.create_dir(lua_base_path..'data/'..player.name)
    end
    if not windower.dir_exists(lua_base_path..'data/'..player.name..'/Saves') then
        windower.create_dir(lua_base_path..'data/'..player.name..'/Saves')
    end
    local file = io.open(lua_base_path..'data/'..player.name..'/Saves/job_'..player.main_job..'var.lua',"w")
    file:write('  MJi = '..tostring(MJi)..'\n  SJi = '..tostring(SJi)..'\n  MSi = '..tostring(MSi)..'\n  WSi = '..tostring(WSi)..'\n  Ammo = '..tostring(Ammo)..
    '\n  Special_Weapons = '..tostring(Special_Weapons)..'\n  Conquest_Gear = '..tostring(Conquest_Gear)..'\n  File_Write = '..tostring(File_Write)..
    '\n  Registered_Events = '..tostring(Registered_Events)..'\n  Debug = '..tostring(Debug)..'\n  Stepmax = '..tostring(Stepmax)..
    '\nStopsteps = '..tostring(Stopsteps)..'\nConquest.neck.change = '..tostring(Conquest.neck.change)..'\nConquest.neck.case_id = '..tostring(Conquest.neck.case_id)..
    '\nConquest.ring.change = '..tostring(Conquest.ring.change)..'\nConquest.ring.case_id = '..tostring(Conquest.ring.case_id)..
    '\nspecialweaponwscount = '..tostring(specialweaponwscount)..'\nweapon_types_count = '..tostring(weapon_types_count)..
    '\nrange_types_count = '..tostring(range_types_count)..'\ngear_mode_count = '..tostring(gear_mode_count)..'\nauto_use_shards = '..tostring(auto_use_shards)..
    '\n  menu.pos.x = '..tostring(menu.pos.x)..'\n  menu.pos.y = '..tostring(menu.pos.y)..'\n  lvlwatch = '..tostring(lvlwatch)..'\n  tswap = '..tostring(tswap)..
    '\n  debugmod = '..tostring(debugmod)..'')
    if table.contains(jobs.magic, player.main_job) then
        file:write('\nChangestaff = '..tostring(Changestaff)..'\nUsestaff = "'..tostring(Usestaff)..'"'..'')
    end
    file:close()
    if a then
        add_to_chat(7, '/Saves/job_'..player.main_job..'var.lua has been forcibly rewritten.')
    end
end