--File Write
function File_Write_do(a)
    if not windower.dir_exists(lua_base_path..'data/'..player.name) then
        windower.create_dir(lua_base_path..'data/'..player.name)
    end
    if not windower.dir_exists(lua_base_path..'data/'..player.name..'/Saves') then
        windower.create_dir(lua_base_path..'data/'..player.name..'/Saves')
    end
    local file = io.open(lua_base_path..'data/'..player.name..'/Saves/job_'..player.main_job..'var.lua',"w")
    file:write('MJi = '..tostring(MJi)..'\nSJi = '..tostring(SJi)..'\nAmmo = '..tostring(Ammo)..
    '\nSpecial_Weapons = '..tostring(Special_Weapons)..'\nConquest_Gear = '..tostring(Conquest_Gear)..'\nFile_Write = '..tostring(File_Write)..
    '\nRegistered_Events = '..tostring(Registered_Events)..'\nDebug = '..tostring(Debug)..'\nStepmax = '..tostring(Stepmax)..'\nStopsteps = '..tostring(Stopsteps)..
    '\nspecialweaponwscount = '..tostring(specialweaponwscount)..'\nweapon_types_count = '..tostring(weapon_types_count)..
    '\nrange_types_count = '..tostring(range_types_count)..'\narmor_types_count = '..tostring(armor_types_count)..'\nauto_use_shards = '..tostring(auto_use_shards)..
    '\nmenu.pos.x = '..tostring(menu.pos.x)..'\nmenu.pos.y = '..tostring(menu.pos.y)..'\nlvlwatch = '..tostring(lvlwatch)..'\ntswap = '..tostring(tswap)..
    '\ndebugmod = '..tostring(debugmod)..'')
    if table.contains(jobs.magic, player.main_job) then
        file:write('\nMSi = '..tostring(MSi)..'\nChangestaff = '..tostring(Changestaff)..'\nUsestaff = "'..tostring(Usestaff)..'"'..'')
    end
    if Conquest_Gear then
    file:write('\nConquest_neck.change = '..tostring(Conquest_neck.change)..'\nConquest_neck.case_id = '..tostring(Conquest_neck.case_id)..
                '\nConquest_ring.change = '..tostring(Conquest_ring.change)..'\nConquest_ring.case_id = '..tostring(Conquest_ring.case_id)..'')
    end
    file:close()
    if a then
        add_to_chat(7, '/Saves/job_'..player.main_job..'var.lua has been forcibly rewritten.')
    end
end