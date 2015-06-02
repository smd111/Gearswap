menu.text = {font='Segoe UI Symbol',size=9} menu.bg = {alpha = 200} menu.flags = {draggable=true} min_window = {text={font='Segoe UI Symbol',size=9},bg={alpha=200},flags={draggable=false},pos={x=0,y=300}}
tab_type = {'Job Settings','Weapon Settings','Armor Settings','System Settings','Include Settings'} -- auto_hide_cycle = 0
--display functions---------------------------------------------------------------------------------------------------------------
menu_set = 1
window = texts.new(menu) button = texts.new(min_window)
function initialize(text, settings, name)
    local line = L{}
    if name == 'window' then
        line:append('${listm}\nGearswap   \\cs(255,255,0)${hid|HIDE}\\cr')
        if menu_set == 1 then
            line:append('--Job Settings--')
            if player.main_job == 'DNC' or player.sub_job == 'DNC' then line:append('-Steps-\n   Max Step = ${stepm}\n   Stop Steps   ${ssteps}') end
            if lvlwatch then line:append('${mjob}\n   lvl = ${mjob_lvl}') end
            if skillwatch and Registered_Events then line:append('${skill}\n   lvl = ${skill_lvl|Updating}') end
            if (player.main_job == 'NIN' or player.sub_job == 'NIN') and Ninw then line:append('Nin Wheel\n Start LVL = ${ninstartlvl}\n Start ELE = ${ninstartele}\n Start Type = ${ninstarttype}\n ${ninstart|Stoped}') end
            if show_aggro then line:append('-Aggro Count-\n   Player = ${pagro|0}\n   Party = ${pragro|0}\n   Alliance = ${aagro|0}') if jobs.pet:contains(player.main_job) or jobs.pet:contains(player.sub_job) then line:append('   Pet = ${ptgro|0}') end end
        elseif menu_set == 2 then
            line:append('--Weapon Settings--')
            line:append('Weapon Type = \\cs(255,255,0)${wept}\\cr\nRange Type = \\cs(255,255,0)${rwept}\\cr\nAuto WS AOE ${wsaoe}')
            if jobs.magic:contains(player.main_job) and WSi then line:append('-Mage Staves-\n   Auto Change   ${cstaff}\n   Type \\cs(255,255,0)${ustaff}\\cr') end
        elseif menu_set == 3 then
            line:append('--Armor Settings--\nMode = \\cs(255,255,0)${amode}\\cr')
            if Conquest_Gear then line:append('-Conquest Gear-\n  Change Neck   ${cneckc}\n  Neck Type = \\cs(255,255,0)${cneck}\\cr\n  Change Ring   ${cringc}\n  Ring Type = \\cs(255,255,0)${cring}\\cr') end
        elseif menu_set == 4 then
            line:append('--System Settings--\nWatch midaction()   ${watchmid}')
            if jobs.pet:contains(player.main_job) or jobs.pet:contains(player.sub_job) then line:append('Watch pet_midaction()   ${watchpetmid}') end
            if not auto_xp_ring then line:append('Auto Capacity Ring ${capring}') end
            if not auto_cap_ring then line:append('Auto XP Ring ${xpring}') end
            if Registered_Events then line:append('Display Main Job\nand LVL   ${tmjl}\nShow Current \nSkill Level   ${tskill}\nShow Aggro Count  ${aggroenable}') end
            if Debug then line:append('Show Debug  ${dbenable}\n  in = ${debugtype}') end
            line:append('Auto Shard Use   ${ashard}')
            if File_Write then line:append('${filew|Force File Write}') end
            line:append('Show Swaps   ${tswap}\nDebug Mode   ${debugm}\n${gsex1|Gearswap Export}\n${regs|Reload Gearswap}')
        elseif menu_set == 5 then
            line:append('--Include Settings--')
            if player.main_job == "NIN" or player.sub_job == "NIN" then line:append('Ninja Wheel   ${tninw}') end
            if jobs.ammo:contains(player.main_job) then line:append('Ammo   ${tammo}') end
            if jobs.magic:contains(player.main_job) then line:append('Mage Stave   ${tmsi}') end
            line:append('Special Weapons   ${tswi}\nConquest Gear   ${tcgi}\nDebug   ${tdebug}\nMain Job   ${tmji}\nSub Job   ${tsji}\nRegistered Events   ${trei}\nFile Write   ${tfwi}')
        elseif menu_set == 6 then --custom menu
            line:append('--Custom Menu--') for i,v in pairs(custom_menu_build()) do if type(v) == 'string' then line:append(v) end end
        end
    elseif name == 'button' then
        if Registered_Events then if lvlwatch then line:append('${mjob}   lvl = ${mjob_lvl}') end if skillwatch then line:append('${skill}   lvl = ${skill_lvl|Updating}') end if show_aggro then line:append('Aggro Count Total = ${totalagro}') end end
        if #line == 0 then line:append('\n > \n ') end
    else
        local menu_initialize = {['weapon_select_window']={[1]='Select Weapon',[2]='weapon_types',[3]='wep',[4]='weapon'},['range_select_window']={[1]='Select Range',
        [2]='range_types',[3]='rang',[4]='range'},['skill_select_window']={[1]='Select Skill',[2]='reg_event.skill_type',[3]='reg_event.skill',},
        ['debug_select_window']={[1]='Select Debug',[2]='fdebug.type',[3]='debug',},['tab_select_window']={[1]='Select Menu Tab',[2]='tab_type',[3]='tab',},
        ['gear_select_window']={[1]='Select Armor',[2]='armor_types',[3]='ger',[4]='armor'},}
        line:append(menu_initialize[name][1])
        for i, v in ipairs(s_to_t(menu_initialize[name][2])) do if menu_initialize[name][4] then if sets[menu_initialize[name][4]][v] then line:append('${'..menu_initialize[name][3]..''..i..'|'..string.gsub(v, "_", " ")..'}') end else line:append('${'..menu_initialize[name][3]..''..i..'|'..string.gsub(v, "_", " ")..'}') end end
        if custom_menu_update and custom_menu_build and custom_menu_commands and name == 'tab_select_window' then line:append('${tab6|Custom Menu}') end
    end
    text:clear() text:append(line:concat('\n')) grab_switches(name,line)
end
function grab_switches(name,tab)
    local tabl = L{} for _,v in ipairs(tab) do for _,v2 in ipairs(string.split(v,'\n')) do tabl:append(v2) end end
    if not switch then switch = {} end switch[name] = tabl
    for i,v in ipairs(switch[name]) do for w in string.gmatch(v, '{.-}') do if type(switch[name][i]) ~= 'table' then switch[name][i] = T{} end switch[name][i]:append(w) end end
end
--Display Updater
function update_display()
    windower.prim.create('window_button') windower.prim.set_visibility('window_button', false) windower.prim.set_color('window_button', 200, 255, 255, 255) updatedisplay()
end
function updatedisplay()
    local menu_list ={'[J]  W  A  S  I  C','J  [W]  A  S  I  C','J  W  [A]  S  I  C','J  W  A  [S]  I  C','J  W  A  S  [I]  C','J  W  A  S  I  [C]'} initialize(window, menu, 'window') initialize(button, min_window, 'button')
    local i = {}
    if Conquest_Gear then i.cneckc = conquest.neck.change and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr' i.cneck = conq_gear.neck.case[conquest.neck.case_id] i.cringc = conquest.ring.change and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr' i.cring = conq_gear.ring.case[conquest.ring.case_id] end
    if Registered_Events then i.aagro = aggro_count('alliance') i.pragro = aggro_count('party') i.pagro = aggro_count('player') i.ptgro = aggro_count('pet') i.totalagro = aggro_count() end
    if reg_event and 
    reg_event.skill and 
    Registered_Events then 
    i.skill = reg_event.skill_type[skill_count] i.skill_lvl = (reg_event.skill[reg_event.skill_type[skill_count]..' Capped'] and "Capped" or reg_event.skill[reg_event.skill_type[skill_count]..' Level']) end
    if Debug then i.debugtype = string.gsub(fdebug.type
    [fdebug.count], "_", " ") end
    if Ninw then i.ninstartele = ninja_wheel.element_list[ninja_wheel.element_count] i.ninstartlvl = ninja_wheel.start_lvl i.ninstart = (ninja_wheel.super_tog or ninja_wheel.tog) and '\\cs(0,255,0)Started\\cr' or '\\cs(255,255,0)Stoped\\cr' i.ninstarttype = ninja_wheel.start_type and 'Super' or 'Normal' end
    i.stepm = Stepmax
    i.ssteps = Stopsteps and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
    i.listm = menu_list[menu_set]
    i.wsaoe = Enable_auto_WS_aoe and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
    i.watchmid = Watch_midaction and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
    i.watchpetmid = Watch_pet_midaction and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
    i.aggroenable = show_aggro and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
    i.tmji = MJi and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
    i.tsji = SJi and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
    i.tmsi = MSi and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
    i.twsi = WSi and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
    i.tammo = Ammo and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
    i.tfwi = File_Write and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
    i.tswi = Special_Weapons and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
    i.tcgi = Conquest_Gear and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
    i.trei = Registered_Events and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
    i.tdebug = Debug and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
    i.tmjl = lvlwatch and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
    i.tskill = skillwatch and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
    i.tswap = _settings.show_swaps and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
    i.debugm = _settings.debug_mode and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
    i.dbenable = full_debug and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
    i.ashard = auto_use_shards and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
    i.tninw = Ninw and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
    i.swhp = s_waltz_h_a and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
    i.capring = auto_cap_ring and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
    i.xpring = auto_xp_ring and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
    if weapon_types_count > #weapon_types then weapon_types_count = 1 end
    i.wept = string.gsub(weapon_types[weapon_types_count], "_", " ")
    if range_types_count > #range_types then range_types_count = 1 end
    i.rwept = string.gsub(range_types[range_types_count], "_", " ")
    if armor_types_count > #armor_types then armor_types_count = 1 end
    i.amode = string.gsub(armor_types[armor_types_count], "_", " ")
    i.mjob = player.main_job_full
    i.mjob_lvl = player.main_job_level
    if menu_set == 6 then for i2,v2 in pairs(custom_menu_update()) do i[i2] = v2 end end
    window:update(i) button:update(i)
    if not window_hidden then window:show() else button:show() end
end
function get_window_pos(x,y,check)
    local my, mx, button_lines, hx, hy = 0,0,0,0,0,0
    for i, v in pairs(check) do if check[i][1] then mx, my = texts.extents(_G[check[i][2]]) button_lines = _G[check[i][2]]:text():count('\n') + 1 hx = (x - _G[i].pos.x) hy = (y - _G[i].pos.y) end end
    return my, mx, button_lines, hx, hy
end
function set_prim_loc(loc,name,tab,x,y)
    local hide_button = S{'{mjob}','{mjob_lvl}','{skill_lvl|Updating}','{pagro|0}','{pragro|0}','{aagro|0},{ptgro|0}'}
    for i, v in ipairs(loc) do
        if (y > loc[i].ya and y < loc[i].yb) then
            if type(switch[name][i]) == 'table' and not hide_button:contains(switch[name][i][1]) then
                windower.prim.set_position('window_button', _G[tab].pos.x, (_G[tab].pos.y + loc[i].ya)) windower.prim.set_size('window_button', x, (loc[i].yb - loc[i].ya)) windower.prim.set_visibility('window_button', true)
            else
                windower.prim.set_position('window_button', 0, 0) windower.prim.set_size('window_button', 1, 1) windower.prim.set_visibility('window_button', false)
            end
        end
    end
end
function set_count(tab,switch)
    for i,v in ipairs(s_to_t(tab[2])) do
        for w in string.gmatch(switch, '|(.-)}') do if string.gsub(w, "_", " ") == string.gsub(v, "_", " ") then return i elseif "Custom Menu" == w then return 6 end end
    end
end
function set_loc(loc,hy,name,tab)
    for i, v in ipairs(loc) do
        if (hy > loc[i].ya and hy < loc[i].yb) then if type(switch[name][i]) == 'table' then if switch[name][i][1] then return set_count(tab,switch[name][i][1]) end end end
    end
end
function extra_display(x,y,loc,hy,check)
    local code = {['weapon_select_window']={[1]='Select Weapon',[2]='weapon_types',[3]='wep',[4]='weapon'},['range_select_window']={[1]='Select Range',[2]='range_types',[3]='rang',[4]='range'},['skill_select_window']={[1]='Select Skill',[2]='reg_event.skill_type',[3]='reg_event.skill',},['debug_select_window']={[1]='Select Debug',[2]='fdebug.type',[3]='debug',},['tab_select_window']={[1]='Select Menu Tab',[2]='tab_type',[3]='tab',},['gear_select_window']={[1]='Select Armor',[2]='armor_types',[3]='ger',[4]='armor'},}
    for i, v in pairs(check) do
        if check[i][1] then
            local tab = {}
            for k, v in  string.gmatch(check[i][3], "([%w_]+)%.([%w_]+)") do tab[1] = k tab[2] = v end
            if _G[check[i][3]] then _G[check[i][3]] = set_loc(loc,hy,check[i][2],code[check[i][2]]) or 1
            else _G[tab[1]][tab[2]] = set_loc(loc,hy,check[i][2],code[check[i][2]]) or 1 end
            kill_window(check[i][2]) switch[check[i][2]] = nil windower.prim.set_visibility('window_button', false)
            if file_write and file_write.write then file_write.write() end
        end
    end
    updatedisplay()
end
function mouse(mtype, x, y, delta, blocked)
    local check_windows = {['menu']={[1]=(window:hover(x, y) and window:visible()),[2]='window'},['min_window']={[1]=(button:hover(x, y) and button:visible()),[2]='button'},['skill_select']={[1]=(skillwatch and skill_select_window and skill_select_window:hover(x, y) and skill_select_window:visible()),[2]='skill_select_window',[3]='skill_count'},['debug_select']={[1]=(Debug and debug_select_window and debug_select_window:hover(x, y) and debug_select_window:visible()),[2]='debug_select_window',[3]='fdebug.count'},['tab_select']={[1]=(tab_select_window and tab_select_window:hover(x, y) and tab_select_window:visible()),[2]='tab_select_window',[3]='menu_set'},['wep_select']={[1]=(weapon_select_window and weapon_select_window:hover(x, y) and weapon_select_window:visible()),[2]='weapon_select_window',[3]='weapon_types_count'},['range_select']={[1]=(range_select_window and range_select_window:hover(x, y) and range_select_window:visible()),[2]='range_select_window',[3]='range_types_count'},['ger_select']={[1]=(gear_select_window and gear_select_window:hover(x, y) and gear_select_window:visible()),[2]='gear_select_window',[3]='armor_types_count'},}
    local my, mx, button_lines, hx, hy = get_window_pos(x,y,check_windows)
    if button_lines == 0 then windower.prim.set_visibility('window_button', false) return end
    local location = {} location.offset = my / button_lines location[1] = {} location[1].ya = 1 location[1].yb = location.offset 
    local count = 2
    while count <= button_lines do location[count] = {} location[count].ya = location[count - 1].yb  location[count].yb = location[count - 1].yb + location.offset count = count + 1 end
    if button:hover(x, y) and button:visible() and min_window.flags.draggable then print(min_window.pos.x, min_window.pos.y) end
    if mtype == 0 then
        if button:hover(x, y) and button:visible() then
            windower.prim.set_position('window_button', min_window.pos.x, min_window.pos.y) windower.prim.set_size('window_button', mx, my) windower.prim.set_visibility('window_button', true)
        else
            for i, v in pairs(check_windows) do if check_windows[i][1] then set_prim_loc(location,check_windows[i][2],i,mx,hy) end end
        end
    elseif mtype == 2 then
        if window:hover(x, y) and window:visible() then
            for i, v in ipairs(location) do
                if (hy > location[i].ya and hy < location[i].yb) then
                    if type(switch['window'][i]) == 'table' then if switch['window'][i][1] then menu_commands(switch['window'][i][1]) updatedisplay() end end
                end
            end
        elseif button:hover(x, y) and button:visible() then
            windower.prim.set_visibility('window_button', false) button:hide() window_hidden = false window:show() else extra_display(x,y,location,hy,check_windows)
        end
    end
end
function kill_window(w) _G[w]:hide() _G[w]:destroy() _G[w] = nil end
function menu_commands(com)
    ----Include Rules----
    if com == "{stepm}" then Stepmax = (Stepmax % (player.main_job == "DNC" and 6 or 5)) + 1
    elseif com == "{ssteps}" then Stopsteps = not Stopsteps
    elseif com == "{cstaff}" then Changestaff = not Changestaff
    elseif com == "{ustaff}" then Usestaff = (Usestaff=='Atk' and 'Acc' or 'Atk')
    elseif com == "{cneckc}" then conquest.neck.change = not conquest.neck.change
    elseif com == "{cringc}" then conquest.ring.change = not conquest.ring.change
    elseif com == "{cneck}" then conquest.neck.case_id = (conquest.neck.case_id % #conq_gear.neck.case) + 1
    elseif com == "{cring}" then conquest.ring.case_id = (conquest.ring.case_id % #conq_gear.ring.case) + 1
    elseif com == "{ninstartele}" then ninja_wheel.element_count = (ninja_wheel.element_count % #ninja_wheel.element_list) + 1 ninja_wheel.start_element = ninja_wheel.element_list[ninja_wheel.element_count]
    elseif com == '{ninstartlvl}' then ninja_wheel.start_lvl = (ninja_wheel.start_lvl % 3) + 1
    elseif com == '{ninstarttype}' then ninja_wheel.start_type = not ninja_wheel.start_type
    elseif com == '{ninstart|Stoped}' then if ninja_wheel.start_type then send_command("gs c startnin snw") else send_command("gs c startnin nw") end
    elseif com == '{watchmid}' then Watch_midaction = not Watch_midaction
    elseif com == "{watchpetmid}" then Watch_pet_midaction = not Watch_pet_midaction
    elseif com == '{tmjl}' then lvlwatch = not lvlwatch
    elseif com == "{tskill}" then skillwatch = not skillwatch
    elseif com == '{dbenable}' then full_debug = not full_debug
    elseif com == '{aggroenable}' then show_aggro = not show_aggro
    elseif com == '{ashard}' then auto_use_shards = not auto_use_shards
    elseif com == "{swhp}" then s_waltz_h_a = not s_waltz_h_a
    elseif com == "{hid|HIDE}" then window:hide() window_hidden = true button:show() windower.prim.set_visibility('window_button', false) local kill={"gear_select_window","tab_select_window","skill_select_window","weapon_select_window","range_select_window","debug_select_window"} for i,v in ipairs(kill) do if _G[v] then kill_window(v) end end
    ----Gearswap Controls----
    elseif com == "{tswap}" then show_swaps((not _settings.show_swaps))
    elseif com == "{debugm}" then debug_mode((not _settings.debug_mode))
    elseif com == "{regs|Reload Gearswap}" then send_command("lua reload gearswap")--gearswap.refresh_user_env()
    elseif com == "{gsex1|Gearswap Export}" then gearswap.export_set({'mainjob','overwrite'})
    elseif com == "{wsaoe}" then Enable_auto_WS_aoe = not Enable_auto_WS_aoe
    elseif com == "{filew|Force File Write}" then file_write.write()
    elseif com == "{capring}" then auto_cap_ring = not auto_cap_ring auto_xp_ring = false ring_time = get_item_next_use("Trizek Ring")
    elseif com == "{xpring}" then auto_xp_ring = not auto_xp_ring auto_cap_ring = false ring_time = get_item_next_use("Echad Ring")
    else
        ----Window Open/Close Rules----
        if S{"{amode}","{listm}","{skill}","{wept}","{rwept}","{debugtype}"}:contains(com) then
            local menu_open ={
            ["{amode}"]={[1]="gear_select_window",[2]="ger_select",[3]={text = {font='Segoe UI Symbol',size=9},bg={alpha=200},flags={draggable=false},pos={x=(menu.pos.x - 120),y=(menu.pos.y)}},},
            ["{listm}"]={[1]="tab_select_window",[2]="tab_select",[3]={text = {font='Segoe UI Symbol',size=9},bg={alpha=200},flags={draggable=false},pos={x=(menu.pos.x - 120),y=(menu.pos.y)}}},
            ["{skill}"]={[1]="skill_select_window",[2]="skill_select",[3]={text = {font='Segoe UI Symbol',size=9},bg={alpha=200},flags={draggable=false},pos={x=(menu.pos.x - 120),y=(menu.pos.y - 300)}}},
            ["{wept}"]={[1]="weapon_select_window",[2]="wep_select",[3]={text = {font='Segoe UI Symbol',size=9},bg={alpha=200},flags={draggable=false},pos={x=(menu.pos.x - 120),y=(menu.pos.y)}}},
            ["{rwept}"]={[1]="range_select_window",[2]="range_select",[3]={text = {font='Segoe UI Symbol',size=9},bg={alpha=200},flags={draggable=false},pos={x=(menu.pos.x - 120),y=(menu.pos.y)}}},
            ["{debugtype}"]={[1]="debug_select_window",[2]="debug_select",[3]={text = {font='Segoe UI Symbol',size=9},bg={alpha=200},flags={draggable=false},pos={x=(menu.pos.x - 120),y=(menu.pos.y)}}},}
            for i,v in pairs(menu_open) do
                if com == i then
                    if not _G[menu_open[i][1]] then _G[menu_open[i][2]] = menu_open[i][3] _G[menu_open[i][1]] = texts.new(_G[menu_open[i][2]])
                        initialize(_G[menu_open[i][1]], _G[menu_open[i][2]], menu_open[i][1]) _G[menu_open[i][1]]:show()
                    else kill_window(menu_open[i][1])
                    end
                elseif _G[menu_open[i][1]] then kill_window(menu_open[i][1]) end
            end
        end
        ----Include Enable/Disable Rules----
        local include_switch = {["{tmji}"]={[1]="MJi",[2]='mjob/main_job_'..player.main_job..'.lua',[3]="mji"},["{tsji}"]={[1]="SJi",[2]='sjob/sub_job_'..player.sub_job..'.lua',[3]="sji"},
        ["{tfwi}"]={[1]="File_Write",[2]='more/File_Write.lua',[3]="file_write"},["{tswi}"]={[1]="Special_Weapons",[2]="more/Special_Weapons.lua",[3]="s_weapon"},
        ["{tcgi}"]={[1]="Conquest_Gear",[2]="more/Conquest_Gear.lua",[3]="conq_gear"},["{trei}"]={[1]="Registered_Events",[2]="more/Registered_Events.lua",[3]="reg_event"},
        ["{tdebug}"]={[1]="Debug",[2]="more/Debug.lua",[3]="fdebug"},["{tmsi}"]={[1]="MSi",[2]='more/MSi.lua',[3]="msi"},
        ["{tammo}"]={[1]="Ammo",[2]='more/Ammo.lua',[3]="ammo"},["{tninw}"]={[1]="Ninw",[2]='more/Ninja_Wheel.lua',[3]="ninja_wheel"},}
        if include_switch[com] then _G[include_switch[com][1]] = not _G[include_switch[com][1]] if _G[include_switch[com][1]] and not Disable_All and gearswap.pathsearch({'SMDinclude/includes/'..include_switch[com][2]}) then include('SMDinclude/includes/'..include_switch[com][2]) elseif not _G[include_switch[com][1]] then remove_functions(include_switch[com][3],include_switch[com][1]) end end
    end
    if custom_menu_commands then custom_menu_commands(com) end if file_write and file_write.write then file_write.write() end
end
mouse_id = windower.raw_register_event('mouse', mouse)
function remove_functions(name,iname)
    if _G[name] then for i, v in pairs(_G[name]) do if i:endswith('id') then windower.unregister_event(v) else _G[name][i] = nil end end end
end
--[[function auto_hide_window()
    if auto_hide_cycle == 3 then
        if windower.ffxi.get_info().menu_open and not player.in_combat and not window_hidden then
            window:hide()
            button:hide()
        elseif not windower.ffxi.get_info().menu_open and not player.in_combat then
            if not window_hidden then
                window:show()
            else
                button:show()
            end
        end
        auto_hide_cycle = 0
    else
        auto_hide_cycle = auto_hide_cycle +1
    end
end
windower.raw_register_event('prerender', auto_hide_window)]]