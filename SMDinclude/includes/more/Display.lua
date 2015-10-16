menu.text = {font='Segoe UI Symbol',size=9}
menu.bg = {alpha = 200}
menu.flags = {draggable=true}
min_window = {text={font='Segoe UI Symbol',size=9},bg={alpha=200},flags={draggable=false},pos={x=0,y=300}}
tab_type = {'Job Settings','Weapon Settings','Armor Settings','System Settings','Include Settings'}
load_include(true, 'more/Display_sub.lua')
-- auto_hide_cycle = 0
--display functions---------------------------------------------------------------------------------------------------------------
menu_set = 1
window = texts.new(menu)
button = texts.new(min_window)
function initialize(text, settings, name)
    local line = L{}
    if name == 'window' then
        line:append('${listm}\nGearswap   \\cs(255,255,0)${hid|HIDE}\\cr')
        if menu_set == 1 then
            line:append('--Job Settings--')
            if player.main_job == 'DNC' or player.sub_job == 'DNC' then
                line:append('-Steps-\n   Max Step = ${stepm}\n   Stop Steps   ${ssteps}')
            end
            if lvlwatch then
                line:append('${mjob}\n   lvl = ${mjob_lvl}')
            end
            if skillwatch and Registered_Events then
                line:append('${skill}\n   lvl = ${skill_lvl|Updating}')
            end
            if (player.main_job == 'NIN' or player.sub_job == 'NIN') and Ninw then
                line:append('Nin Wheel\n Start LVL = ${ninstartlvl}\n Start ELE = ${ninstartele}\n Start Type = ${ninstarttype}\n ${ninstart|Stoped}')
            end
            if show_aggro then
            line:append('-Aggro Count-\n   Player = ${pagro|0}\n   Party = ${pragro|0}\n   Alliance = ${aagro|0}')
                if jobs.pet:contains(player.main_job) or jobs.pet:contains(player.sub_job) then
                    line:append('   Pet = ${ptgro|0}')
                end
            end
            line:append('Reset Aggro #${reagro}')
        elseif menu_set == 2 then
            line:append('--Weapon Settings--')
            line:append('Weapon Type = \\cs(255,255,0)${wept}\\cr\nRange Type = \\cs(255,255,0)${rwept}\\cr\nChange WS Head   ${wshead}\nAuto WS AOE ${wsaoe}')
            if jobs.magic:contains(player.main_job) and WSi then
                line:append('-Mage Staves-\n   Auto Change   ${cstaff}\n   Type \\cs(255,255,0)${ustaff}\\cr')
            end
        elseif menu_set == 3 then
            line:append('--Armor Settings--\nMode = \\cs(255,255,0)${amode}\\cr')
            if Conquest_Gear then
                line:append('-Conquest Gear-\n  Change Neck   ${cneckc}\n  Neck Type = \\cs(255,255,0)${cneck}\\cr\n'..
                            '  Change Ring   ${cringc}\n  Ring Type = \\cs(255,255,0)${cring}\\cr')
            end
        elseif menu_set == 4 then
            line:append('--System Settings--\nWatch midaction()  ${watchmid}')
            if jobs.pet:contains(player.main_job) or jobs.pet:contains(player.sub_job) then
                line:append('Watch pet_midaction()   ${watchpetmid}')
            end
            line:append('CP XP ring = ${axpcpring}')
            if auto_ring then
                line:append('Ring = ${xpcpring}')
            end
            line:append('Auto Shard Use   ${ashard}')
            if Registered_Events then
                line:append('-Show-\n  MJob and LVL   ${tmjl}\n  Skill Level   ${tskill}\n  Aggro Count  ${aggroenable}')
            end
            if Debug then
                line:append('Show Debug  ${dbenable}')
                if full_debug then
                    line:append('  in = ${debugtype}')
                end
            end
            if File_Write then
                line:append('${filew|Force File Write}')
            end
            line:append('Show Swaps   ${tswap}\nDebug Mode   ${debugm}\n${gsex1|Gearswap Export}\n${regs|Reload Gearswap}')
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
            line:append('Special Weapons   ${tswi}\nConquest Gear   ${tcgi}\nDebug   ${tdebug}\nMain Job   ${tmji}\nSub Job   ${tsji}\n'..
                        'Registered Events   ${trei}\nFile Write   ${tfwi}')
        elseif menu_set == 6 then --custom menu
            line:append('--Custom Menu--')
            for i,v in pairs(custom_menu_build()) do
                if type(v) == 'string' then
                    line:append(v)
                end
            end
        end
    elseif name == 'button' then
        if Registered_Events then
            if lvlwatch then
                line:append('${mjob}   lvl = ${mjob_lvl}')
            end
            if skillwatch then
                line:append('${skill}   lvl = ${skill_lvl|Updating}')
            end
            if show_aggro then
                line:append('Aggro Count Total = ${totalagro}')
            end
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
        i.cneckc = conquest.neck.change and c_m or n_c 
        i.cneck = conq_gear.neck.case[conquest.neck.case_id] 
        i.cringc = conquest.ring.change and c_m or n_c 
        i.cring = conq_gear.ring.case[conquest.ring.case_id]
    end
    if Registered_Events then
        i.aagro = aggro_count('alliance')
        i.pragro = aggro_count('party')
        i.pagro = aggro_count('player')
        i.ptgro = aggro_count('pet')
        i.totalagro = aggro_count()
    end
    if reg_event and reg_event.skill and Registered_Events then
        i.skill = reg_event.skill_type[skill_count]
        i.skill_lvl = (reg_event.skill[reg_event.skill_type[skill_count]..' Capped'] and "Capped" or reg_event.skill[reg_event.skill_type[skill_count]..' Level'])
    end
    if Debug and fdebug then
        i.debugtype = string.gsub(fdebug.type[fdebug.count], "_", " ")
    end
    if Ninw and ninja_wheel then
        i.ninstartele = ninja_wheel.element_list[ninja_wheel.element_count]
        i.ninstartlvl = ninja_wheel.start_lvl
        i.ninstart = (ninja_wheel.super_tog or ninja_wheel.tog) and '\\cs(0,255,0)Started\\cr' or '\\cs(255,255,0)Stoped\\cr'
        i.ninstarttype = ninja_wheel.start_type and 'Super' or 'Normal'
    end
    i.stepm = Stepmax
    i.ssteps = Stopsteps and c_m or n_c
    i.listm = menu_list[menu_set]
    i.wsaoe = Enable_auto_WS_aoe and c_m or n_c
    i.watchmid = Watch_midaction and c_m or n_c
    i.watchpetmid = Watch_pet_midaction and c_m or n_c
    i.aggroenable = show_aggro and c_m or n_c
    i.tmji = MJi and c_m or n_c
    i.tsji = SJi and c_m or n_c
    i.tmsi = MSi and c_m or n_c
    i.twsi = WSi and c_m or n_c
    i.tammo = Ammo and c_m or n_c
    i.tfwi = File_Write and c_m or n_c
    i.tswi = Special_Weapons and c_m or n_c
    i.tcgi = Conquest_Gear and c_m or n_c
    i.trei = Registered_Events and c_m or n_c
    i.tdebug = Debug and c_m or n_c
    i.tmjl = lvlwatch and c_m or n_c
    i.tskill = skillwatch and c_m or n_c
    i.tswap = _settings.show_swaps and c_m or n_c
    i.debugm = _settings.debug_mode and c_m or n_c
    i.dbenable = full_debug and c_m or n_c
    i.ashard = auto_use_shards and c_m or n_c
    i.tninw = Ninw and c_m or n_c
    i.swhp = s_waltz_h_a and c_m or n_c
    i.axpcpring = auto_ring and c_m or n_c
    i.wshead = ws_head and c_m or n_c
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
    if rings_count > #rings then
        rings_count = 1
    end
    i.xpcpring = string.gsub(rings[rings_count], "_", " ")
    i.mjob = player.main_job_full
    i.mjob_lvl = player.main_job_level
    if menu_set == 6 then
        for i2,v2 in pairs(custom_menu_update()) do
            i[i2] = v2
        end
    end
    window:update(i)
    button:update(i)
    if not window_hidden then
        window:show()
    else
        button:show()
    end
end
function extra_display(x,y,loc,hy,check)
    for i, v in pairs(check) do
        if v[1] then
            local tab = {}
            for k, v in  string.gmatch(v[3], "([%w_]+)%.([%w_]+)") do
                tab[1] = k tab[2] = v
            end
            if _G[v[3]] then
                _G[v[3]] = set_loc(loc,hy,v[2],get_vars(v[2],"code")) or 1
            else
                _G[tab[1]][tab[2]] = set_loc(loc,hy,v[2],get_vars(v[2],"code")) or 1
            end
            kill_window(v[2])
            switch[v[2]] = nil
            windower.prim.set_visibility('window_button', false)
            if file_write and file_write.write then
                file_write.write()
            end
        end
    end
    updatedisplay()
end
function mouse(mtype, x, y, delta, blocked)
    local check_windows = get_vars('nil',"check",x,y)
    local my, mx, button_lines, hx, hy = get_window_pos(x,y,check_windows)
    if button_lines == 0 then
        windower.prim.set_visibility('window_button', false)
        return
    end
    local location = {}
    location.offset = my / button_lines
    location[1] = {}
    location[1].ya = 1
    location[1].yb = location.offset 
    local count = 2
    while count <= button_lines do
        location[count] = {}
        location[count].ya = location[count - 1].yb
        location[count].yb = location[count - 1].yb + location.offset
        count = count + 1
    end
    if button:hover(x, y) and button:visible() and min_window.flags.draggable then
        print(min_window.pos.x, min_window.pos.y)
    end
    if mtype == 0 then
        if button:hover(x, y) and button:visible() then
            windower.prim.set_position('window_button', min_window.pos.x, min_window.pos.y)
            windower.prim.set_size('window_button', mx, my)
            windower.prim.set_visibility('window_button', true)
        else
            for i, v in pairs(check_windows) do
                if v[1] then
                    set_prim_loc(location,v[2],i,mx,hy)
                end
            end
        end
    elseif mtype == 2 then
        if window:hover(x, y) and window:visible() then
            for i, v in ipairs(location) do
                if (hy > v.ya and hy < v.yb) then
                    if type(switch['window'][i]) == 'table' then
                        if switch['window'][i][1] then
                            menu_commands(switch['window'][i][1])
                            updatedisplay()
                        end
                    end
                end
            end
        elseif button:hover(x, y) and button:visible() then
            windower.prim.set_visibility('window_button', false)
            button:hide()
            window_hidden = false
            window:show()
        else
            extra_display(x,y,location,hy,check_windows)
        end
    end
end
function menu_commands(com)
    ----Include Rules----
    if com == "{stepm}" then
        Stepmax = (Stepmax % (player.main_job == "DNC" and 6 or 5)) + 1
    elseif com == "{ssteps}" then
        Stopsteps = not Stopsteps
    elseif com == "{cstaff}" then
        Changestaff = not Changestaff
    elseif com == "{ustaff}" then
        Usestaff = (Usestaff=='Atk' and 'Acc' or 'Atk')
    elseif com == "{cneckc}" then
        conquest.neck.change = not conquest.neck.change
    elseif com == "{cringc}" then
        conquest.ring.change = not conquest.ring.change
    elseif com == "{cneck}" then
        conquest.neck.case_id = (conquest.neck.case_id % #conq_gear.neck.case) + 1
    elseif com == "{cring}" then
        conquest.ring.case_id = (conquest.ring.case_id % #conq_gear.ring.case) + 1
    elseif com == "{ninstartele}" then
        ninja_wheel.element_count = (ninja_wheel.element_count % #ninja_wheel.element_list) + 1 ninja_wheel.start_element = ninja_wheel.element_list[ninja_wheel.element_count]
    elseif com == '{ninstartlvl}' then
        ninja_wheel.start_lvl = (ninja_wheel.start_lvl % 3) + 1
    elseif com == '{ninstarttype}' then
        ninja_wheel.start_type = not ninja_wheel.start_type
    elseif com == '{ninstart|Stoped}' then
        if ninja_wheel.start_type then
            send_command("gs c startnin snw")
        else
            send_command("gs c startnin nw")
        end
    elseif com == '{watchmid}' then
        Watch_midaction = not Watch_midaction
    elseif com == "{watchpetmid}" then
        Watch_pet_midaction = not Watch_pet_midaction
    elseif com == '{tmjl}' then
        lvlwatch = not lvlwatch
    elseif com == "{tskill}" then
        skillwatch = not skillwatch
    elseif com == '{dbenable}' then
        full_debug = not full_debug
    elseif com == '{aggroenable}' then
        show_aggro = not show_aggro
    elseif com == '{ashard}' then
        auto_use_shards = not auto_use_shards
    elseif com == "{swhp}" then
        s_waltz_h_a = not s_waltz_h_a
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
    elseif com == "{wsaoe}" then
        Enable_auto_WS_aoe = not Enable_auto_WS_aoe
    elseif com == "{filew|Force File Write}" then
        file_write.write()
    elseif com == "{reagro}" then
        reg_event.clear_aggro_count()
    elseif com == "{axpcpring}" then
        auto_ring = not auto_ring
    elseif com == "{wshead}" then
        ws_head = not ws_head
    ----Gearswap Controls----
    elseif com == "{tswap}" then
        show_swaps((not _settings.show_swaps))
    elseif com == "{debugm}" then
        debug_mode((not _settings.debug_mode))
    elseif com == "{regs|Reload Gearswap}" then
        send_command("lua reload gearswap")--gearswap.refresh_user_env()
    elseif com == "{gsex1|Gearswap Export}" then
        gearswap.export_set({'mainjob','overwrite'})
    else
        ----Window Open/Close Rules----
        if S{"{amode}","{listm}","{skill}","{wept}","{rwept}","{debugtype}","{xpcpring}"}:contains(com) then
            local ctext = {text = {font='Segoe UI Symbol',size=9},bg={alpha=200},flags={draggable=false},pos={x=(menu.pos.x - 120),y=(menu.pos.y)}}
            local menu_open = get_vars(com,"command")
            for i,v in pairs(menu_open) do
                if com == i then
                    if not _G[v[1]] then
                        _G[v[2]] = v[3]
                        _G[v[1]] = texts.new(_G[v[2]])
                        initialize(_G[v[1]],
                        _G[v[2]], v[1])
                        _G[v[1]]:show()
                    else
                        kill_window(v[1])
                    end
                    if com == "{xpcpring}" then
                        schedule_xpcp_ring()
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
                                ["{trei}"]={[1]="Registered_Events",[2]="more/Registered_Events.lua",[3]="reg_event"},
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
                add_to_chat(cc.mc, "Unable to load "..('SMDinclude/includes/'..include_switch[com][2]):color(cc.r1,cc.mc).." as it does not exist.")
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