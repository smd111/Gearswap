--File Write
file_write = {}
function file_write.write()
    if not windower.dir_exists(lua_base_path..'data/'..player.name) then windower.create_dir(lua_base_path..'data/'..player.name) end
    if not windower.dir_exists(lua_base_path..'data/'..player.name..'/Saves') then windower.create_dir(lua_base_path..'data/'..player.name..'/Saves') end
    local fileb = io.open(lua_base_path..'data/'..player.name..'/Saves/job_'..player.main_job..'var.lua',"w")
    fileb:write('-------Include Saved Vars-------'..
                '\n----Includes----'..
                    '\nMSi = '..tostring(MSi or false)..
                    '\nMJi = '..tostring(MJi or false)..
                    '\nSJi = '..tostring(SJi or false)..
                    '\nAmmo = '..tostring(Ammo or false)..
                    '\nSpecial_Weapons = '..tostring(Special_Weapons or false)..
                    '\nConquest_Gear = '..tostring(Conquest_Gear or false)..
                    '\nFile_Write = '..tostring(File_Write or false)..
                    '\nDebug = '..tostring(Debug or false)..
                '\n----MSi----'..
                    '\nChangestaff = '..tostring(Changestaff or false)..
                    '\nUsestaff = "'..tostring(Usestaff or 'Atk')..'"'..
                '\n----Conquest_Gear----'..
                    '\nconquest.neck.change = '..tostring(conquest.neck.change or false)..
                    '\nconquest.neck.case_id = '..tostring(conquest.neck.case_id or 1)..
                    '\nconquest.ring.change = '..tostring(conquest.ring.change or false)..
                    '\nconquest.ring.case_id = '..tostring(conquest.ring.case_id or 1)..
                '\n----Special_Weapons----'..
                    '\nspecial_weapon_ws_count = '..tostring(special_weapon_ws_count or 0)..
                '\n----Steps Control----'..
                    '\nStepmax = '..tostring(Stepmax or 1)..
                    '\nStopsteps = '..tostring(Stopsteps or false)..
                '\n----Gear Settings----'..
                    '\nweapon_types_save = "'..weapon_types[weapon_types_count]..'"'..
                    '\nrange_types_save = "'..range_types[range_types_count]..'"'..
                    '\narmor_types_save = "'..armor_types[armor_types_count]..'"'..
                    '\nrings_save = "'..rings[rings_count]..'"'..
                    '\nskill_save = "'..reg_event.skill_type[skill_count]..'"'..
                '\n----Other----'..
                    '\nWatch_midaction = '..tostring(Watch_midaction or false)..
                    '\nWatch_pet_midaction = '..tostring(Watch_pet_midaction or false)..
                    '\nauto_use_shards = '..tostring(auto_use_shards or false)..
                    '\nEnable_auto_WS_aoe = '..tostring(Enable_auto_WS_aoe or false)..
                    '\nlvlwatch = '..tostring(lvlwatch or false)..
                    '\nauto_ring = '..tostring(auto_ring or false)..
                    '\nskillwatch = '..tostring(skillwatch or false)..
                    '\nISr = '..tostring(istratre or false)..
                    '\ntowaltz = '..tostring(towaltz or false)..
                    '\ntosamba = '..tostring(tosamba or false)..
                '\n----Other 2----'..
                    '\nmenu.pos.x = '..tostring(menu.pos.x or 1)..
                    '\nmenu.pos.y = '..tostring(menu.pos.y or 1))
    if mf.save then fileb:write('\n\n-------Player Saved Vars-------'..mf.save()) end
    fileb:close()
end