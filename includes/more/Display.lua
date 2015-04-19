menu.text = {font='Segoe UI Symbol',size=9}
menu.bg = {alpha = 200}
menu.flags = {draggable=true}
min_window = {text = {font='Segoe UI Symbol',size=9},bg={alpha=200},flags={draggable=false},pos={x=0,y=400}}
auto_hide_cycle = 0
if not skillwatch then skillwatch = false end
if not lvlwatch then lvlwatch = false end
tab_type = {'Job Settings','Weapon Settings','Armor Settings','System Settings','Include Settings'}
--display functions---------------------------------------------------------------------------------------------------------------
menu_set = 1
window = texts.new(menu)
button = texts.new(min_window)
function initialize(text, settings, window_name)
    local properties = L{}
    if window_name == 'window' then
        properties:append('${listm}')
        properties:append('Gearswap   \\cs(255,255,0)${hid|HIDE}\\cr')
        local menu_build_list = {[1]={[2]={[1]=((windower.ffxi.get_player().main_job == 'DNC') or (windower.ffxi.get_player().sub_job == 'DNC')),[2]='-Steps-'},
            [3]={[1]=((windower.ffxi.get_player().main_job == 'DNC') or (windower.ffxi.get_player().sub_job == 'DNC')),[2]='   Max Step = ${stepm}'},
            [4]={[1]=((windower.ffxi.get_player().main_job == 'DNC') or (windower.ffxi.get_player().sub_job == 'DNC')),[2]='   Stop Steps   ${ssteps}'},
            [1]='--Job Settings--',[5]={[1]=(lvlwatch),[2]='${mjob}'},[6]={[1]=(lvlwatch),[2]='   lvl = ${mjob_lvl}'},[7]={[1]=(skillwatch and Registered_Events),[2]='${skill}'},
            [8]={[1]=(skillwatch and Registered_Events),[2]='   lvl = ${skill_lvl|Updating}'},
            [9]={[1]=((windower.ffxi.get_player().main_job == 'NIN' and Ninw) or (windower.ffxi.get_player().sub_job == 'NIN' and Ninw)),[2]='Nin Wheel'},
            [10]={[1]=((windower.ffxi.get_player().main_job == 'NIN' and Ninw) or (windower.ffxi.get_player().sub_job == 'NIN' and Ninw)),[2]=' Start LVL = ${ninstartlvl}'},
            [11]={[1]=((windower.ffxi.get_player().main_job == 'NIN' and Ninw) or (windower.ffxi.get_player().sub_job == 'NIN' and Ninw)),[2]=' Start ELE = ${ninstartele}'},
            [12]={[1]=((windower.ffxi.get_player().main_job == 'NIN' and Ninw) or (windower.ffxi.get_player().sub_job == 'NIN' and Ninw)),[2]=' Start Type = ${ninstarttype}'},
            [13]={[1]=((windower.ffxi.get_player().main_job == 'NIN' and Ninw) or (windower.ffxi.get_player().sub_job == 'NIN' and Ninw)),[2]=' ${ninstart|Stoped}'},
            [14]={[1]=(show_aggro),[2]='-Aggro Count-'},[15]={[1]=(show_aggro),[2]='   Player = ${pagro|0}'},[16]={[1]=(show_aggro),[2]='   Party = ${pragro|0}'},
            [17]={[1]=(show_aggro),[2]='   Alliance = ${aagro|0}'},[18]={[1]=(show_aggro),[2]='   Pet = ${ptgro|0}'},} ,
            [2]={[1]='--Weapon Settings--',[2]='Weapon Type = \\cs(255,255,0)${wept}\\cr',[3]='Range Type = \\cs(255,255,0)${rwept}\\cr',
            [4]={[1]=(jobs.magic:contains(player.main_job) and WSi),[2]='-Mage Staves-'},[5]={[1]=(jobs.magic:contains(player.main_job) and WSi),[2]='   Auto Change   ${cstaff}'},
            [6]={[1]=(jobs.magic:contains(player.main_job) and WSi),[2]='   Type \\cs(255,255,0)${ustaff}\\cr'},},
            [3]={[1]='--Armor Settings--',[2]='Mode = \\cs(255,255,0)${amode}\\cr',[3]={[1]=(Conquest_Gear),[2]='-Conquest Gear-'},
            [4]={[1]=(Conquest_Gear),[2]='  Change Neck   ${cneckc}'},[5]={[1]=(Conquest_Gear),[2]='  Neck Type = \\cs(255,255,0)${cneck}\\cr'},
            [6]={[1]=(Conquest_Gear),[2]='  Change Ring   ${cringc}'},[7]={[1]=(Conquest_Gear),[2]='  Ring Type = \\cs(255,255,0)${cring}\\cr'},},
            [4]={[2]={[1]=(Registered_Events),[2]='Display Main Job'},[3]={[1]=(Registered_Events),[2]='and LVL   ${tmjl}'},[4]={[1]=(Registered_Events),
            [2]='Show Current '},[5]={[1]=(Registered_Events),[2]='Skill Level   ${tskill}'},[6]={[1]=(Registered_Events),[2]='Show Aggro Count  ${aggroenable}'},
            [10]={[1]=(Debug),[2]='Show Debug  ${dbenable}'},[11]={[1]=(Debug),[2]='  in = ${debugtype}'},[12]={[1]=(File_Write),[2]='${filew|Force File Write}'},
            [1]='--System Settings--',[7]='Auto Shard Use   ${ashard}',[8]='Show Swaps   ${tswap}',[9]='Debug Mode   ${debugm}',[13]='${gsex1|Gearswap Export}',
            [14]='${regs|Reload Gearswap}',},
            [5]={[2]={[1]=(windower.ffxi.get_player().main_job == "NIN" or windower.ffxi.get_player().sub_job == "NIN"),[2]='Ninja Wheel   ${tninw}'},
            [3]={[1]=(jobs.ammo:contains(player.main_job)),[2]='Ammo   ${tammo}'},[8]={[1]=(jobs.magic:contains(player.main_job)),[2]='Mage Stave   ${tmsi}'},
            [1]='--Include Settings--',[4]='Conquest Gear   ${tcgi}',[5]='Debug   ${tdebug}',[6]='File Write   ${tfwi}',[7]='Main Job   ${tmji}',[9]='Registered Events   ${trei}',
            [10]='Special Weapons   ${tswi}',[11]='Sub Job   ${tsji}',},}
        if menu_build_list[menu_set] then
            for i, v in ipairs(menu_build_list[menu_set]) do
                if type(menu_build_list[menu_set][i]) == 'table' then
                    if menu_build_list[menu_set][i][1] then
                        properties:append(menu_build_list[menu_set][i][2])
                    end
                else
                    properties:append(menu_build_list[menu_set][i])
                end
            end
        elseif menu_set == 6 then --custom menu
            properties:append('--Custom Menu--')
            for i,v in pairs(custom_menu_build()) do
                if type(v) == 'string' then
                    properties:append(v)
                end
            end
        end
    elseif window_name == 'button' then
        local button_list = {[1]={[1]='${mjob}   lvl = ${mjob_lvl}',[2]=(lvlwatch and Registered_Events),},[2]={[1]='${skill}   lvl = ${skill_lvl|Updating}',[2]=(skillwatch and Registered_Events),},
        [3]={[1]='Aggro Count Total = ${totalagro}',[2]=(show_aggro and Registered_Events),},[4]={[1]='\n > \n ',[2]=(not (skillwatch or lvlwatch or show_aggro))},
        [5]={[1]='\n > \n ',[2]=((skillwatch or lvlwatch or show_aggro) and not Registered_Events)},}
        for i, v in ipairs(button_list) do
            if button_list[i][2] then
                properties:append(button_list[i][1])
            end
        end
    else
        local menu_name_initialize = {
        ['weapon_select_window']={[1]='Select Weapon',[2]='weapon_types',[3]='wep',[4]='weapon'},['range_select_window']={[1]='Select Range',[2]='range_types',
        [3]='rang',[4]='range'},['skill_select_window']={[1]='Select Skill',[2]='registered_events.skill_type',[3]='registered_events.skill',},
        ['debug_select_window']={[1]='Select Debug',[2]='fdebug.type',[3]='debug',},['tab_select_window']={[1]='Select Menu Tab',[2]='tab_type',[3]='tab',},
        ['gear_select_window']={[1]='Select Armor',[2]='armor_types',[3]='ger',[4]='armor'},}
        properties:append(menu_name_initialize[window_name][1])
        for i, v in ipairs(string_to_table(menu_name_initialize[window_name][2])) do
            if menu_name_initialize[window_name][4] then
                if sets[menu_name_initialize[window_name][4]][v] then
                    properties:append('${'..menu_name_initialize[window_name][3]..''..i..'|'..string.gsub(v, "_", " ")..'}')
                end
            else
                properties:append('${'..menu_name_initialize[window_name][3]..''..i..'|'..string.gsub(v, "_", " ")..'}')
            end
        end
        if custom_menu_update and custom_menu_build and custom_menu_commands and window_name == 'tab_select_window' then
            properties:append('${tab6|Custom Menu}')
        end
    end
    text:clear()
    text:append(properties:concat('\n'))
    grab_switches(window_name,properties)
end
function grab_switches(window_name,window_table)
    if not switches_table then
        switches_table = {}
    end
    switches_table[window_name] = window_table
    for i,v in ipairs(switches_table[window_name]) do
        for w in string.gmatch(v, '{.-}') do
            if type(switches_table[window_name][i]) ~= 'table' then
                switches_table[window_name][i] = T{}
            end
            switches_table[window_name][i]:append(w)
        end
    end
end
function start_display()
    initialize(window, menu, 'window')
    initialize(button, min_window, 'button')
end
--Display Updater
function update_display()
    windower.prim.create('window_button')
    windower.prim.set_color('window_button', 200, 255, 255, 255)
    windower.prim.set_visibility('window_button', false)
    updatedisplay()
end
function updatedisplay()
    local menu_list ={'[J]  W  A  S  I  C','J  [W]  A  S  I  C','J  W  [A]  S  I  C','J  W  A  [S]  I  C','J  W  A  S  [I]  C','J  W  A  S  I  [C]'}
    initialize(window, menu, 'window')
    initialize(button, min_window, 'button')
    local info = {}
    if Conquest_Gear then
        info.cneckc = conquest.neck.change and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
        info.cringc = conquest.ring.change and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
        info.cneck = conquest_gear.neck.case[conquest.neck.case_id]
        info.cring = conquest_gear.ring.case[conquest.ring.case_id]
    end
    if Registered_Events then
        info.aagro = aggro_count('alliance')
        info.pragro = aggro_count('party')
        info.pagro = aggro_count('player')
        info.ptgro = aggro_count('pet')
        info.totalagro = aggro_count()
    end
    if registered_events and registered_events.skill and Registered_Events then
        info.skill = registered_events.skill_type[skill_count]
        info.skill_lvl = (registered_events.skill[registered_events.skill_type[skill_count]..' Capped'] and "Capped" 
        or registered_events.skill[registered_events.skill_type[skill_count]..' Level'])
    end
    if Debug then
        info.debugtype = string.gsub(fdebug.type[fdebug.count], "_", " ")
    end
    if Ninw then
        info.ninstartele = ninja_wheel.element_list[ninja_wheel.element_count]
        info.ninstartlvl = ninja_wheel.start_lvl
        info.ninstart = (ninja_wheel.super_tog or ninja_wheel.tog) and '\\cs(0,255,0)Started\\cr' or '\\cs(255,255,0)Stoped\\cr'
        info.ninstarttype = ninja_wheel.start_type and 'Super' or 'Normal'
    end
    info.stepm = Stepmax
    info.ssteps = Stopsteps and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
    info.listm = menu_list[menu_set]
    info.aggroenable = show_aggro and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
    info.tmji = MJi and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
    info.tsji = SJi and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
    info.tmsi = MSi and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
    info.twsi = WSi and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
    info.tammo = Ammo and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
    info.tfwi = File_Write and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
    info.tswi = Special_Weapons and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
    info.tcgi = Conquest_Gear and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
    info.trei = Registered_Events and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
    info.tdebug = Debug and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
    info.tmjl = lvlwatch and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
    info.tskill = skillwatch and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
    info.tswap = _settings.show_swaps and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
    info.debugm = _settings.debug_mode and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
    info.dbenable = full_debug and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
    info.ashard = auto_use_shards and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
    info.tninw = Ninw and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
    info.wept = string.gsub(weapon_types[weapon_types_count], "_", " ")
    info.rwept = string.gsub(range_types[range_types_count], "_", " ")
    info.amode = string.gsub(armor_types[armor_types_count], "_", " ")
    info.mjob = windower.ffxi.get_player().main_job_full
    info.mjob_lvl = windower.ffxi.get_player().main_job_level
    if menu_set == 6 then
        for i,v in pairs(custom_menu_update()) do
            info[i] = v
        end
    end
    window:update(info)
    button:update(info)
    if not window_hidden then
        window:show()
    else
        button:show()
    end
end
function get_window_pos(x,y,check_windows)
    local my, mx, button_lines, hx, hy = 0,0,0,0,0,0
    for i, v in pairs(check_windows) do
        if check_windows[i][1] then
            mx, my = texts.extents(_G[check_windows[i][2]])
            button_lines = _G[check_windows[i][2]]:text():count('\n') + 1
            hx = (x - _G[i].pos.x)
            hy = (y - _G[i].pos.y)
        end
    end
    return my, mx, button_lines, hx, hy
end
function set_prim_loc(location,win_name,win_tabl,mx,hy)
    local hide_button = S{'{mjob}','{mjob_lvl}','{skill_lvl|Updating}','{pagro|0}','{pragro|0}','{aagro|0},{ptgro|0}'}
    for i, v in ipairs(location) do
        if (hy > location[i].ya and hy < location[i].yb) then
            if type(switches_table[win_name][i]) == 'table' and not hide_button:contains(switches_table[win_name][i][1]) then
                windower.prim.set_position('window_button', _G[win_tabl].pos.x, (_G[win_tabl].pos.y + location[i].ya))
                windower.prim.set_size('window_button', mx, (location[i].yb - location[i].ya))
                windower.prim.set_visibility('window_button', true)
            else
                windower.prim.set_position('window_button', 0, 0)
                windower.prim.set_size('window_button', 1, 1)
                windower.prim.set_visibility('window_button', false)
            end
        end
    end
end
function set_count(switch_tabl,switch)
    for i,v in ipairs(string_to_table(switch_tabl[2])) do
        for w in string.gmatch(switch, '|(.-)}') do
            if string.gsub(w, "_", " ") == string.gsub(v, "_", " ") then
                return i
            elseif "Custom Menu" == w then
                return 6
            end
        end
    end
end
function set_loc(location,hy,menu_name,switch_tabl)
    for i, v in ipairs(location) do
        if (hy > location[i].ya and hy < location[i].yb) then
            if type(switches_table[menu_name][i]) == 'table' then
                if switches_table[menu_name][i][1] then
                    return set_count(switch_tabl,switches_table[menu_name][i][1])
                end
            end
        end
    end
end
function extra_display(x,y,location,hy,check_windows)
    local code = {
        ['weapon_select_window']={[1]='Select Weapon',[2]='weapon_types',[3]='wep',[4]='weapon'},['range_select_window']={[1]='Select Range',[2]='range_types',
        [3]='rang',[4]='range'},['skill_select_window']={[1]='Select Skill',[2]='registered_events.skill_type',[3]='registered_events.skill',},['debug_select_window']={[1]='Select Debug',
        [2]='fdebug.type',[3]='debug',},['tab_select_window']={[1]='Select Menu Tab',[2]='tab_type',[3]='tab',},
        ['gear_select_window']={[1]='Select Armor',[2]='armor_types',[3]='ger',[4]='armor'},}
    for i, v in pairs(check_windows) do
        if check_windows[i][1] then
            local tab = {}
            for k, v in  string.gmatch(check_windows[i][3], "([%w_]+)%.([%w_]+)") do tab[1] = k tab[2] = v end
            if _G[check_windows[i][3]] then
                _G[check_windows[i][3]] = set_loc(location,hy,check_windows[i][2],code[check_windows[i][2]]) or 1
            else
                _G[tab[1]][tab[2]] = set_loc(location,hy,check_windows[i][2],code[check_windows[i][2]]) or 1
            end
            kill_window(check_windows[i][2])
            switches_table[check_windows[i][2]] = nil
            windower.prim.set_visibility('window_button', false)
            if file_write and file_write.write then
                file_write.write()
            end
        end
    end
    updatedisplay()
end
function mouse(mtype, x, y, delta, blocked)
    local check_windows = {['menu']={[1]=(window:hover(x, y) and window:visible()),[2]='window'},
    ['min_window']={[1]=(button:hover(x, y) and button:visible()),[2]='button'},
    ['skill_select']={[1]=(skillwatch and skill_select_window and skill_select_window:hover(x, y) and skill_select_window:visible()),[2]='skill_select_window',[3]='skill_count'},
    ['debug_select']={[1]=(Debug and debug_select_window and debug_select_window:hover(x, y) and debug_select_window:visible()),[2]='debug_select_window',[3]='fdebug.count'},
    ['tab_select']={[1]=(tab_select_window and tab_select_window:hover(x, y) and tab_select_window:visible()),[2]='tab_select_window',[3]='menu_set'},
    ['wep_select']={[1]=(weapon_select_window and weapon_select_window:hover(x, y) and weapon_select_window:visible()),[2]='weapon_select_window',[3]='weapon_types_count'},
    ['range_select']={[1]=(range_select_window and range_select_window:hover(x, y) and range_select_window:visible()),[2]='range_select_window',[3]='range_types_count'},
    ['ger_select']={[1]=(gear_select_window and gear_select_window:hover(x, y) and gear_select_window:visible()),[2]='gear_select_window',[3]='armor_types_count'},}
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
    if mtype == 0 then
        if button:hover(x, y) and button:visible() then
            windower.prim.set_position('window_button', min_window.pos.x, min_window.pos.y)
            windower.prim.set_size('window_button', mx, my)
            windower.prim.set_visibility('window_button', true)
        else
            for i, v in pairs(check_windows) do
                if check_windows[i][1] then
                    set_prim_loc(location,check_windows[i][2],i,mx,hy)
                end
            end
        end
    elseif mtype == 2 then
        if window:hover(x, y) and window:visible() then
            for i, v in ipairs(location) do
                if (hy > location[i].ya and hy < location[i].yb) then
                    if type(switches_table['window'][i]) == 'table' then
                        if switches_table['window'][i][1] then
                            menu_commands(switches_table['window'][i][1])
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
function kill_window(w)
    _G[w]:hide()
    _G[w]:destroy()
    _G[w] = nil
end
function menu_commands(display_command)
    ----Include Rules----
    if display_command == "{stepm}" then
        Stepmax = (Stepmax % 6) + 1
    elseif display_command == "{ssteps}" then
        Stopsteps = not Stopsteps
    elseif display_command == "{cstaff}" then
        Changestaff = not Changestaff
    elseif display_command == "{ustaff}" then
        Usestaff = (Usestaff=='Atk' and 'Acc' or 'Atk')
    elseif display_command == "{cneckc}" then
        conquest.neck.change = not conquest.neck.change
    elseif display_command == "{cringc}" then
        conquest.ring.change = not conquest.ring.change
    elseif display_command == "{cneck}" then
        conquest.neck.case_id = (conquest.neck.case_id % #conquest_gear.neck.case) + 1
    elseif display_command == "{cring}" then
        conquest.ring.case_id = (conquest.ring.case_id % #conquest_gear.ring.case) + 1
    elseif display_command == "{ninstartele}" then
        ninja_wheel.element_count = (ninja_wheel.element_count % #ninja_wheel.element_list) + 1
        ninja_wheel.start_element = ninja_wheel.element_list[ninja_wheel.element_count]
    elseif display_command == '{ninstartlvl}' then
        ninja_wheel.start_lvl = (ninja_wheel.start_lvl % 3) + 1
    elseif display_command == '{ninstarttype}' then
        ninja_wheel.start_type = not ninja_wheel.start_type
    elseif display_command == '{ninstart|Stoped}' then
        if ninja_wheel.start_type then
            send_command("gs c startnin snw")
        else
            send_command("gs c startnin nw")
        end
    elseif display_command == '{tmjl}' then
        lvlwatch = not lvlwatch
    elseif display_command == "{tskill}" then
        skillwatch = not skillwatch
    elseif display_command == '{dbenable}' then
        full_debug = not full_debug
    elseif display_command == '{aggroenable}' then
        show_aggro = not show_aggro
    elseif display_command == '{ashard}' then
        auto_use_shards = not auto_use_shards
    elseif display_command == "{hid|HIDE}" then
        window:hide()
        window_hidden = true
        button:show()
        windower.prim.set_visibility('window_button', false)
        local win_kill={"gear_select_window","tab_select_window","skill_select_window","weapon_select_window","range_select_window","debug_select_window"}
        for i,v in ipairs(win_kill) do
            if _G[v] then
                kill_window(v)
            end
        end
    ----Gearswap Controls----
    elseif display_command == "{tswap}" then
        if _settings.show_swaps then
            show_swaps(false)
        else
            show_swaps(true)
        end
    elseif display_command == "{debugm}" then
        if _settings.debug_mode then
            debug_mode(false)
        else
            debug_mode(true)
        end
    elseif display_command == "{regs|Reload Gearswap}" then
        send_command('lua reload gearswap')
    elseif display_command == "{gsex1|Gearswap Export}" then
        send_command('gs export')
    elseif display_command == "{filew|Force File Write}" then
        file_write.write()
    else
        ----Window Open/Close Rules----
        if S{"{amode}","{listm}","{skill}","{wept}","{rwept}","{debugtype}"}:contains(display_command) then
            local menu_open ={
            ["{amode}"]={[1]="gear_select_window",[2]="ger_select",[3]={text = {font='Segoe UI Symbol',size=9},bg={alpha=200},flags={draggable=false},pos={x=(menu.pos.x - 120),y=(menu.pos.y)}},},
            ["{listm}"]={[1]="tab_select_window",[2]="tab_select",[3]={text = {font='Segoe UI Symbol',size=9},bg={alpha=200},flags={draggable=false},pos={x=(menu.pos.x - 120),y=(menu.pos.y)}}},
            ["{skill}"]={[1]="skill_select_window",[2]="skill_select",[3]={text = {font='Segoe UI Symbol',size=9},bg={alpha=200},flags={draggable=false},pos={x=(menu.pos.x - 120),y=(menu.pos.y - 300)}}},
            ["{wept}"]={[1]="weapon_select_window",[2]="wep_select",[3]={text = {font='Segoe UI Symbol',size=9},bg={alpha=200},flags={draggable=false},pos={x=(menu.pos.x - 120),y=(menu.pos.y)}}},
            ["{rwept}"]={[1]="range_select_window",[2]="range_select",[3]={text = {font='Segoe UI Symbol',size=9},bg={alpha=200},flags={draggable=false},pos={x=(menu.pos.x - 120),y=(menu.pos.y)}}},
            ["{debugtype}"]={[1]="debug_select_window",[2]="debug_select",[3]={text = {font='Segoe UI Symbol',size=9},bg={alpha=200},flags={draggable=false},pos={x=(menu.pos.x - 120),y=(menu.pos.y)}}},}
            for i,v in pairs(menu_open) do
                if display_command == i then
                    if not _G[menu_open[i][1]] then
                        _G[menu_open[i][2]] = menu_open[i][3]
                        _G[menu_open[i][1]] = texts.new(_G[menu_open[i][2]])
                        initialize(_G[menu_open[i][1]], _G[menu_open[i][2]], menu_open[i][1])
                        _G[menu_open[i][1]]:show()
                    else
                        kill_window(menu_open[i][1])
                    end
                elseif _G[menu_open[i][1]] then
                    kill_window(menu_open[i][1])
                end
            end
        end
        ----Include Enable/Disable Rules----
        local include_switch = {
        ["{tmji}"]={[1]="MJi",[2]='includes/mjob/main_job_'..player.main_job..'.lua',[3]="mji"},
        ["{tsji}"]={[1]="SJi",[2]='includes/sjob/sub_job_'..player.sub_job..'.lua',[3]="sji"},
        ["{tfwi}"]={[1]="File_Write",[2]='includes/more/File_Write.lua',[3]="file_write"},
        ["{tswi}"]={[1]="Special_Weapons",[2]="includes/more/Special_Weapons.lua",[3]="special_weapon"},
        ["{tcgi}"]={[1]="Conquest_Gear",[2]="includes/more/Conquest_Gear.lua",[3]="conquest_gear"},
        ["{trei}"]={[1]="Registered_Events",[2]="includes/more/Registered_Events.lua",[3]="registered_events"},
        ["{tdebug}"]={[1]="Debug",[2]="includes/more/Debug.lua",[3]="fdebug"},
        ["{tmsi}"]={[1]="MSi",[2]='includes/more/MSi.lua',[3]="includes/more/MSi.lua",[4]="msi"},
        ["{tammo}"]={[1]="Ammo",[2]='includes/more/Ammo.lua',[3]="ammo"},
        ["{tninw}"]={[1]="Ninw",[2]='includes/more/Ninja_Wheel.lua',[3]="ninja_wheel"},}
        if include_switch[display_command] then
            _G[include_switch[display_command][1]] = not _G[include_switch[display_command][1]]
            if _G[include_switch[display_command][1]] and not Disable_All and gearswap.pathsearch({include_switch[display_command][2]}) then
                include(include_switch[display_command][2])
            elseif not _G[include_switch[display_command][1]] then
                remove_functions(include_switch[display_command][3])
            end
            -- if file_write and file_write.write then
                -- file_write.write()
            -- end
        end
    end
    if custom_menu_commands then
        custom_menu_commands(display_command)
    end
    if file_write and file_write.write then
        file_write.write()
    end
end
mouse_id = windower.raw_register_event('mouse', mouse)
function remove_functions(remove_function_name)
    if _G[remove_function_name] then
        for i, v in pairs(_G[remove_function_name]) do
            if i:endswith('id') then
                windower.unregister_event(v)
            else
                _G[remove_function_name][i] = nil
            end
        end
    end
end
--[[function auto_hide_window()
    if auto_hide_cycle == 3 then
        if windower.ffxi.get_info().menu_open and not windower.ffxi.get_player().in_combat and not window_hidden then
            window:hide()
            button:hide()
        elseif not windower.ffxi.get_info().menu_open and not windower.ffxi.get_player().in_combat then
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