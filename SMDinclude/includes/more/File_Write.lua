--File Write
file_write = {}
function file_write.write()
    if not windower.dir_exists(lua_base_path..'data/'..player.name) then windower.create_dir(lua_base_path..'data/'..player.name) end
    if not windower.dir_exists(lua_base_path..'data/'..player.name..'/Saves') then windower.create_dir(lua_base_path..'data/'..player.name..'/Saves') end
    local fileb = io.open(lua_base_path..'data/'..player.name..'/Saves/job_'..player.main_job..'var.lua',"w")
    fileb:write('-------Include Saved Vars-------'..'\n----Includes----'..'\nMSi = '..tostring(MSi or false)..'\nMJi = '..tostring(MJi or false)..
        '\nSJi = '..tostring(SJi or false)..'\nAmmo = '..tostring(Ammo or false)..'\nSpecial_Weapons = '..tostring(Special_Weapons or false)..
        '\nConquest_Gear = '..tostring(Conquest_Gear or false)..'\nFile_Write = '..tostring(File_Write or false)..
        '\nRegistered_Events = '..tostring(Registered_Events or false)..'\nDebug = '..tostring(Debug or false)..'\n----MSi----'..
        '\nChangestaff = '..tostring(Changestaff or false)..'\nUsestaff = "'..tostring(Usestaff or 'Atk')..'"'..'\n----Conquest_Gear----'..
        '\nconquest.neck.change = '..tostring(conquest.neck.change or false)..'\nconquest.neck.case_id = '..tostring(conquest.neck.case_id or 1)..
        '\nconquest.ring.change = '..tostring(conquest.ring.change or false)..'\nconquest.ring.case_id = '..tostring(conquest.ring.case_id or 1)..
        '\n----Special_Weapons----'..'\nspecial_weapon_ws_count = '..tostring(special_weapon_ws_count or 0)..'\n----Steps Control----'..
        '\nStepmax = '..tostring(Stepmax or 1)..'\nStopsteps = '..tostring(Stopsteps or false)..'\n----Other----'..
        '\nWatch_midaction = '..tostring(Watch_midaction or false)..'\nWatch_pet_midaction = '..tostring(Watch_pet_midaction or false)..
        '\nweapon_types_count = '..tostring(weapon_types_count or 1)..'\nrange_types_count = '..tostring(range_types_count or 1)..
        '\narmor_types_count = '..tostring(armor_types_count or 1)..'\nauto_use_shards = '..tostring(auto_use_shards or false)..
        '\nEnable_auto_WS_aoe = '..tostring(Enable_auto_WS_aoe or false)..'\nlvlwatch = '..tostring(lvlwatch or false)..
        '\nauto_ring = '..tostring(auto_ring or false)..'\nrings_count = '..tostring(rings_count or 1)..
        '\nskillwatch = '..tostring(skillwatch or false)..'\nskill_count = '..tostring(skill_count or 1)..'\n----Other 2----'..
        '\nmenu.pos.x = '..tostring(menu.pos.x or 1)..'\nmenu.pos.y = '..tostring(menu.pos.y or 1))
    if mf.save then fileb:write('\n\n-------Player Saved Vars-------'..mf.save()) end
    fileb:close()
end