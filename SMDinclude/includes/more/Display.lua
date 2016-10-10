tab_type = {'Job Settings','Weapon Settings','Armor Settings','System Settings','Include Settings'}
load_include(true, 'more/Display_sub.lua')
--display functions---------------------------------------------------------------------------------------------------------------
function initialize(text, settings, name)
    local line = L{}
    if name == 'window' then
        line:append('${listm}\nGearswap   \\cs(255,255,0)${hid|HIDE}\\cr')
        if menu_set == 1 then
            line:append('--Job Settings--')
            if player.main_job == 'DNC' or player.sub_job == 'DNC' then
                line:append('-Steps-\n   Max Step = ${stepm}\n   Stop Steps   ${Stopsteps}')
                line:append('-Waltz (SELF)-\n   Auto Optimal   ${towaltz}')
                if towaltz then
                    line:append('   Show Chat   ${towaltzc}')
                end
                line:append('-Samba-\n   Auto Optimal   ${tosamba}')
            end
            if player.main_job == 'WHM' or player.sub_job == 'WHM' then
                line:append('-Cure-\n   Auto Optimal = ${ocure}')
            end
            if lvlwatch then
                line:append('${mjob}\n   lvl = ${mjob_lvl}')
            end
            if skillwatch then
                line:append('${skill}\n   lvl = ${skill_lvl|Updating}')
            end
            if (player.main_job == 'NIN' or player.sub_job == 'NIN') and Ninw then
                line:append('Nin Wheel\n Start LVL = ${ninstartlvl}\n Start ELE = ${ninstartele}\n Start Type = ${ninja_wheel.start_type}\n ${ninstart|Stoped}')
            end
            if (player.main_job == 'SCH' or player.sub_job == 'SCH') then
                line:append('-Stratagem-\n   Ignore Recast ${istratre}')
            end
            if show_aggro then
                line:append('-Aggro Count-\n   Player = ${pagro|0}\n   Party = ${pragro|0}\n   Alliance = ${aagro|0}')
                if jobs.pet:contains(player.main_job) or jobs.pet:contains(player.sub_job) then
                    line:append('   Pet = ${ptgro|0}')
                end
            end
            line:append('   Reset Aggro #${reagro}')
        elseif menu_set == 2 then
            line:append('--Weapon Settings--')
            line:append('Weapon Type = \\cs(255,255,0)${wept}\\cr\nRange Type = \\cs(255,255,0)${rwept}\\cr\nChange WS Head   ${ws_head}\nAuto WS AOE ${Enable_auto_WS_aoe}')
            if jobs.magic:contains(player.main_job) and WSi then
                line:append('-Mage Staves-\n   Auto Change   ${Changestaff}\n   Type \\cs(255,255,0)${ustaff}\\cr')
            end
            if player.main_job == 'THF' and player.main_job_level >= 70 then
                line:append("Thief's Knife Auto Sub   ${thfsub}")
            end
        elseif menu_set == 3 then
            line:append('--Armor Settings--\nMode = \\cs(255,255,0)${amode}\\cr')
            if Conquest_Gear then
                line:append('-Conquest Gear-\n  Change Neck   ${conquest.neck.change}\n  Neck Type = \\cs(255,255,0)${cneck}\\cr\n'..
                            '  Change Ring   ${conquest.ring.change}\n  Ring Type = \\cs(255,255,0)${cring}\\cr')
            end
        elseif menu_set == 4 then
            line:append('--System Settings--\n------${EC|Controls}------')
            if Show_extra_controles then
                line:append('Watch midaction()   ${Watch_midaction}')
                if jobs.pet:contains(player.main_job) or jobs.pet:contains(player.sub_job) then
                    line:append('Watch pet_midaction()   ${Watch_pet_midaction}')
                end
                line:append('CP XP ring   ${auto_ring}')
                if auto_ring then
                    line:append(' Ring = ${xpcpring}')
                    line:append(' ${resetring}')
                end
                line:append('Auto Shard Use   ${auto_use_shards}\nNo Spells in Town   ${tsstown}')
            end
            line:append('-------${SC|System}------')
            if Show_system_controles then
                line:append('-Show-\n  MJob and LVL   ${lvlwatch}\n  Skill Level   ${skillwatch}\n  Aggro Count   ${show_aggro}')
                if Debug then
                    line:append('Show Debug   ${full_debug}')
                    if full_debug then
                        line:append('  in = ${debugtype}')
                    end
                end
                if File_Write then
                    line:append('${filew|Force File Write}')
                end
                line:append('Display POS ${dispos}')
            end
            line:append('-----${GSC|Gearswap}-----')
            if Show_GS_Controles then
                line:append('Show Swaps   ${tswap}\nDebug Mode   ${debugm}\n${gsex1|Gearswap Export}\n${ruf|Reload User File}\n${regs|Reload Gearswap}')
            end
        elseif menu_set == 5 then
            line:append('--Include Settings--')
            if player.main_job == "NIN" or player.sub_job == "NIN" then
                line:append('Ninja Wheel   ${tninw}')
            end
            if jobs.ammo:contains(player.main_job) then
                line:append('Ammo   ${tammo}')
            end
            if jobs.magic:contains(player.main_job) then
                line:append('Mage Stave   ${tmsi}')
            end
            line:append('Special Weapons   ${tswi}\nConquest Gear   ${tcgi}\nDebug   ${tdebug}\nMain Job   ${tmji}\nSub Job   ${tsji}\nFile Write   ${tfwi}')
        elseif menu_set == 6 then --custom menu
            line:append('--Custom Menu--')
            for i,v in pairs(custom_menu_build()) do
                if type(v) == 'string' then
                    line:append(v)
                end
            end
        end
    elseif name == 'button' then
        if lvlwatch then
            line:append('${mjob}   lvl = ${mjob_lvl}')
        end
        if skillwatch then
            line:append('${skill}   lvl = ${skill_lvl|Updating}')
        end
        if show_aggro then
            line:append('Aggro Count Total = ${totalagro}')
        end
        if #line == 0 then
            line:append('\n > \n ')
        end
    else
        local menu_initialize = get_vars(name,"menu")
        line:append(menu_initialize[name][1])
        for i, v in ipairs(loadstring('return user_env.'..menu_initialize[name][2])()) do
            if menu_initialize[name][4] then
                if sets[menu_initialize[name][4]][v] then
                    line:append('${'..menu_initialize[name][3]..''..i..'|'..string.gsub(v, "_", " ")..'}')
                end
            else
                line:append('${'..menu_initialize[name][3]..''..i..'|'..string.gsub(v, "_", " ")..'}')
            end
        end
        if custom_menu_update and custom_menu_build and custom_menu_commands and name == 'tab_select_window' then
            line:append('${tab6|Custom Menu}')
        end
    end
    text:clear()
    text:append(line:concat('\n'))
    grab_switches(name,line)
end
function updatedisplay()
    local menu_list ={'[J]  W  A  S  I  C','J  [W]  A  S  I  C','J  W  [A]  S  I  C','J  W  A  [S]  I  C','J  W  A  S  [I]  C','J  W  A  S  I  [C]'}
    local c_m = '\\cs(0,255,0)☑\\cr'
    local n_c = '\\cs(255,255,0)☐\\cr'
    initialize(window, menu, 'window') initialize(button, min_window, 'button')
    local i = {}
    if Conquest_Gear and conquest then
        i["conquest.neck.change"] = conquest.neck.change and c_m or n_c 
        i.cneck = conq_gear.neck.case[conquest.neck.case_id] 
        i["conquest.ring.change"] = conquest.ring.change and c_m or n_c 
        i.cring = conq_gear.ring.case[conquest.ring.case_id]
    end
    i.aagro = aggro_count('alliance')
    i.pragro = aggro_count('party')
    i.pagro = aggro_count('player')
    i.ptgro = aggro_count('pet')
    i.totalagro = aggro_count()
    if skill_count > #reg_event.skill_type then
        skill_count = 1
    end
    local SWskill = reg_event.skill_type[skill_count]
    i.skill = SWskill
    if S{"Alchemy","Bonecraft","Clothcraft","Cooking","Fishing","Goldsmithing","Leathercraft","Smithing","Synergy","Woodworking"}:contains(SWskill) then
        local mult = 10 ^ 2
        i.skill_lvl = math.floor((player.skills[SWskill:gsub(" ", "_"):lower()]/32)*mult + 0.5) / mult
    elseif SWskill then
        i.skill_lvl = player.skills[SWskill:gsub(" ", "_"):lower()]
    end
    if Debug and fdebug then
        i.debugtype = string.gsub(fdebug.type[fdebug.count], "_", " ")
    end
    if Ninw and ninja_wheel then
        i.ninstartele = ninja_wheel.element_list[ninja_wheel.element_count]
        i.ninstartlvl = ninja_wheel.start_lvl
        i.ninstart = (ninja_wheel.super_tog or ninja_wheel.tog) and '\\cs(0,255,0)Started\\cr' or '\\cs(255,255,0)Stoped\\cr'
        i["ninja_wheel.start_type"] = ninja_wheel.start_type and 'Super' or 'Normal'
    end
    i.istratre = istratre and c_m or n_c
    i.stepm = Stepmax
    i.Stopsteps = Stopsteps and c_m or n_c
    i.listm = menu_list[menu_set]
    i.Enable_auto_WS_aoe = Enable_auto_WS_aoe and c_m or n_c
    i.Watch_midaction = Watch_midaction and c_m or n_c
    i.Watch_pet_midaction = Watch_pet_midaction and c_m or n_c
    i.show_aggro = show_aggro and c_m or n_c
    i.tmji = MJi and c_m or n_c
    i.tsji = SJi and c_m or n_c
    i.tmsi = MSi and c_m or n_c
    i.twsi = WSi and c_m or n_c
    i.tammo = Ammo and c_m or n_c
    i.tfwi = File_Write and c_m or n_c
    i.tswi = Special_Weapons and c_m or n_c
    i.tcgi = Conquest_Gear and c_m or n_c
    i.tdebug = Debug and c_m or n_c
    i.lvlwatch = lvlwatch and c_m or n_c
    i.skillwatch = skillwatch and c_m or n_c
    i.tswap = _settings.show_swaps and c_m or n_c
    i.debugm = _settings.debug_mode and c_m or n_c
    i.full_debug = full_debug and c_m or n_c
    i.auto_use_shards = auto_use_shards and c_m or n_c
    i.tninw = Ninw and c_m or n_c
    i.s_waltz_h_a = s_waltz_h_a and c_m or n_c
    i.auto_ring = auto_ring and c_m or n_c
    i.ws_head = ws_head and c_m or n_c
    i.tsstown = tsstown and c_m or n_c
    i.thfsub = thfsub and c_m or n_c
    i.towaltz = towaltz and c_m or n_c
    i.towaltzc = towaltzc and c_m or n_c
    i.tosamba = tosamba and c_m or n_c
    i.dispos = menu.flags.draggable and "Unlocked" or "Locked"
    i.ocure = ocure and c_m or n_c
    if weapon_types_count > #weapon_types then
        weapon_types_count = 1
    end
    i.wept = string.gsub(weapon_types[weapon_types_count], "_", " ")
    if range_types_count > #range_types then
        range_types_count = 1
    end
    i.rwept = string.gsub(range_types[range_types_count], "_", " ")
    if armor_types_count > #armor_types then
        armor_types_count = 1
    end
    i.amode = string.gsub(armor_types[armor_types_count], "_", " ")
    if rings_count <= #rings then
        i.xpcpring = string.gsub(rings[rings_count] or "None", "_", " ")
    else
        i.xpcpring = "None"
    end
    i.resetring = "Reset Timer"
    i.mjob = player.main_job_full
    i.mjob_lvl = player.main_job_level
    if menu_set == 6 then
        for i2,v2 in pairs(custom_menu_update()) do
            i[i2] = v2
        end
    end
    window:update(i)
    button:update(i)
    if extra_menu then
        window:hide()
    elseif not window_hidden then
        window:show()
    else
        button:show()
    end
    if Display_change then
        windower.prim.set_visibility('window_button', false)
        Display_change = false
    end
end
function menu_commands(com)
    ----Include Rules----
    comadj = com:stripchars("{}")
    if com == "{stepm}" then
        Stepmax = (Stepmax % (player.main_job == "DNC" and 6 or 5)) + 1
    elseif com == "{ustaff}" then
        Usestaff = (Usestaff=='Atk' and 'Acc' or 'Atk')
    elseif com == "{dispos}" then
        menu.flags.draggable = not menu.flags.draggable
    elseif com == "{cneck}" then
        conquest.neck.case_id = (conquest.neck.case_id % #conq_gear.neck.case) + 1
    elseif com == "{cring}" then
        conquest.ring.case_id = (conquest.ring.case_id % #conq_gear.ring.case) + 1
    elseif com == "{ninstartele}" then
        ninja_wheel.element_count = (ninja_wheel.element_count % #ninja_wheel.element_list) + 1
        ninja_wheel.start_element = ninja_wheel.element_list[ninja_wheel.element_count]
    elseif com == '{ninstartlvl}' then
        ninja_wheel.start_lvl = (ninja_wheel.start_lvl % 3) + 1
    elseif com == '{ninstart|Stoped}' then
        if ninja_wheel.start_type then
            send_command("gs c startnin snw")
        else
            send_command("gs c startnin nw")
        end
    elseif com == "{hid|HIDE}" then
        window:hide()
        window_hidden = true
        button:show()
        windower.prim.set_visibility('window_button', false)
        local kill={"gear_select_window","tab_select_window","skill_select_window","weapon_select_window","range_select_window","debug_select_window",
                    "xpcpring_select_window"}
        for i,v in ipairs(kill) do
            if _G[v] then
                kill_window(v)
            end
        end
    elseif com == "{EC|Controls}" then
        Show_extra_controles = not Show_extra_controles
    elseif com == "{SC|System}" then
        Show_system_controles = not Show_system_controles
    elseif com == "{GSC|Gearswap}" then
        Show_GS_Controles = not Show_GS_Controles
    elseif com == "{filew|Force File Write}" then
        file_write.write()
    elseif com == "{reagro}" then
        reg_event.clear_aggro_count()
    ----Gearswap Controls----
    elseif com == "{tswap}" then
        show_swaps((not _settings.show_swaps))
    elseif com == "{debugm}" then
        debug_mode((not _settings.debug_mode))
    elseif com == "{ruf|Reload User File}" then
        kill_window("window")
        kill_window("button")
        windower.prim.delete('window_button')
        windower.unregister_event(mouse_id)
        remove_functions("reg_event")
        remove_functions("mf")
        local long_job = gearswap.res.jobs[player.main_job_id].english
        local short_job = gearswap.res.jobs[player.main_job_id].english_short
        local tab = {player.name..'_'..short_job..'.lua',player.name..'-'..short_job..'.lua',
            player.name..'_'..long_job..'.lua',player.name..'-'..long_job..'.lua',
            player.name..'.lua',short_job..'.lua',long_job..'.lua','default.lua'}
        local _,_,filename = gearswap.pathsearch(tab)
        include(filename)
        return
    elseif com == "{regs|Reload Gearswap}" then
        send_command("gs reload")
    elseif com == "{gsex1|Gearswap Export}" then
        gearswap.export_set({'mainjob','overwrite'})
    elseif getfield(comadj) ~= nil and type(getfield(comadj)) == "boolean" then
        setfield(comadj, not getfield(comadj))
        if comadj == "auto_ring" then
            schedule_xpcp_ring(not getfield(comadj))
        end
    elseif com == "{resetring}" then
        schedule_xpcp_ring()
    else
        ----Window Open/Close Rules----
        if S{"{amode}","{listm}","{skill}","{wept}","{rwept}","{debugtype}","{xpcpring}","{resetring}"}:contains(com) then
            local ctext = {text = {font='Segoe UI Symbol',size=9},bg={alpha=200},flags={draggable=false},pos={x=(menu.pos.x - 120),y=(menu.pos.y)}}
            local menu_open = get_vars(com,"command")
            for i,v in pairs(menu_open) do
                if com == i then
                    if not _G[v[1]] then
                        _G[v[2]] = v[3]
                        _G[v[1]] = texts.new(_G[v[2]])
                        initialize(_G[v[1]],_G[v[2]], v[1])
                        _G[v[1]]:show()
                        extra_menu = true
                        Display_change = true
                    else
                        kill_window(v[1])
                    end
                elseif _G[v[1]] then
                    kill_window(v[1])
                end
            end
        end
        ----Include Enable/Disable Rules----
        local include_switch = {["{tmji}"]={[1]="MJi",[2]='mjob/main_job_'..player.main_job..'.lua',[3]="mji"},
                                ["{tsji}"]={[1]="SJi",[2]='sjob/sub_job_'..player.sub_job..'.lua',[3]="sji"},
                                ["{tfwi}"]={[1]="File_Write",[2]='more/File_Write.lua',[3]="file_write"},
                                ["{tswi}"]={[1]="Special_Weapons",[2]="more/Special_Weapons.lua",[3]="s_weapon"},
                                ["{tcgi}"]={[1]="Conquest_Gear",[2]="more/Conquest_Gear.lua",[3]="conq_gear"},
                                ["{tdebug}"]={[1]="Debug",[2]="more/Debug.lua",[3]="fdebug"},
                                ["{tmsi}"]={[1]="MSi",[2]='more/MSi.lua',[3]="msi"},
                                ["{tammo}"]={[1]="Ammo",[2]='more/Ammo.lua',[3]="ammo"},
                                ["{tninw}"]={[1]="Ninw",[2]='more/Ninja_Wheel.lua',[3]="ninja_wheel"},}
        if include_switch[com] then
            _G[include_switch[com][1]] = not _G[include_switch[com][1]]
            if _G[include_switch[com][1]] and not Disable_All and gearswap.pathsearch({"SMDinclude/includes/"..include_switch[com][2]}) then
                load_include(true,include_switch[com][2])
            elseif _G[include_switch[com][1]] and not gearswap.pathsearch({"SMDinclude/includes/"..include_switch[com][2]}) then
                _G[include_switch[com][1]] = false
                add_to_chat(8, "Unable to load SMDinclude/includes/"..include_switch[com][2].." as it does not exist.")
            elseif not _G[include_switch[com][1]] then
                remove_functions(include_switch[com][3],include_switch[com][1])
            end
        end
    end
    if custom_menu_commands then
        custom_menu_commands(com)
    end
    if file_write and file_write.write then
        file_write.write()
    end
end
mouse_id = windower.raw_register_event('mouse', mouse)