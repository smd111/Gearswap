menu.text = {font='Segoe UI Symbol',size=9}
menu.bg = {alpha = 200}
menu.flags = {draggable=true}
min_window = {text = {font='Segoe UI Symbol',size=9},bg={alpha=200},flags={draggable=false},pos={x=0,y=400}}
auto_hide_cycle = 0
skillwatch = false
lvlwatch = false
tab_type = {'Job Settings','Weapon Settings','Armor Settings','System Settings','Include Settings'}
--display functions---------------------------------------------------------------------------------------------------------------
--Display Creator
if not tswap then
    tswap = false
end
if not debugmod then
    debugmod = false
end
menu_set = 1
window = texts.new(menu)
button = texts.new(min_window)
function initialize(text, settings, window_name)
    local properties = L{}
    if window_name == 'window' then
        properties:append('${listm}')
        properties:append('Gearswap   \\cs(255,255,0)${hid|HIDE}\\cr')
        local menu_build_list = {[1]={[1]='--Job Settings--',
            [2]={[1]=((windower.ffxi.get_player().main_job == 'DNC' and MJi) or (windower.ffxi.get_player().sub_job == 'DNC' and SJi)),[2]='-Steps-'},
            [3]={[1]=((windower.ffxi.get_player().main_job == 'DNC' and MJi) or (windower.ffxi.get_player().sub_job == 'DNC' and SJi)),[2]='   Max Step = ${stepm}'},
            [4]={[1]=((windower.ffxi.get_player().main_job == 'DNC' and MJi) or (windower.ffxi.get_player().sub_job == 'DNC' and SJi)),[2]='   Stop Steps   ${ssteps}'},
            [5]={[1]=(lvlwatch),[2]='${mjob}'},[6]={[1]=(lvlwatch),[2]='   lvl = ${mjob_lvl}'},[7]={[1]=(skillwatch and Registered_Events),[2]='${skill}'},
            [8]={[1]=(skillwatch and Registered_Events),[2]='   lvl = ${skill_lvl|Updating}'},},[2]={[1]='--Weapon Settings--',
            [2]='Weapon Type = \\cs(255,255,0)${wept}\\cr',[3]='Range Type = \\cs(255,255,0)${rwept}\\cr',
            [4]={[1]=(table.contains(jobs.magic, player.main_job) and WSi),[2]='-Mage Staves-'},
            [5]={[1]=(table.contains(jobs.magic, player.main_job) and WSi),[2]='   Auto Change   ${cstaff}'},
            [6]={[1]=(table.contains(jobs.magic, player.main_job) and WSi),[2]='   Type \\cs(255,255,0)${ustaff}\\cr'},},
            [3]={[1]='--Armor Settings--',[2]='Mode = \\cs(255,255,0)${amode}\\cr',[3]={[1]=(Conquest_Gear),[2]='-Conquest Gear-'},
            [4]={[1]=(Conquest_Gear),[2]='  Change Neck   ${cneckc}'},[5]={[1]=(Conquest_Gear),[2]='  Neck Type = \\cs(255,255,0)${cneck}\\cr'},
            [6]={[1]=(Conquest_Gear),[2]='  Change Ring   ${cringc}'},[7]={[1]=(Conquest_Gear),[2]='  Ring Type = \\cs(255,255,0)${cring}\\cr'},},
            [4]={[1]='--System Settings--',[2]={[1]=(Registered_Events),[2]='Display Main Job'},[3]={[1]=(Registered_Events),[2]='and LVL   ${tmjl}'},
            [4]={[1]=(Registered_Events),[2]='Show Current '},[5]={[1]=(Registered_Events),[2]='Skill Level   ${tskill}'},[6]='Auto Shard Use   ${ashard}',
            [7]='Show Swaps   ${tswap}',[8]='Debug Mode   ${debugm}',[9]={[1]=(Debug),[2]='Show Debug  ${dbenable}'},[10]={[1]=(Debug),[2]='  in = ${debugtype}'},
            [11]={[1]=(File_Write),[2]='${filew|Force File Write}'},[12]='${gsex1|Gearswap Export}',[13]='${regs|Reload Gearswap}',},[5]={[1]='--Include Settings--',
            [2]='Ammo   ${tammo}',[3]='Conquest Gear   ${tcgi}',[4]='Debug   ${tdebug}',[5]='File Write   ${tfwi}',[6]='Main Job   ${tmji}',
            [7]={[1]=(table.contains(jobs.magic, player.main_job)),[2]='Mage Stave   ${tmsi}'},[8]='Registered Events   ${trei}',[9]='Special Weapons   ${tswi}',
            [10]='Sub Job   ${tsji}',[11]='Weapon Skill   ${twsi}',},}
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
            properties:append('Custom Menu')
            for i,v in pairs(custom_menu()) do
                if type(v) == 'string' then
                    properties:append(v)
                end
            end
        end
    elseif window_name == 'button' then
        local button_list = {[1]={[1]='${mjob}   lvl = ${mjob_lvl}',[2]=(lvlwatch),},
            [2]={[1]='${skill}   lvl = ${skill_lvl|Updating}',[2]=(skillwatch and Registered_Events),},[3]={[1]='\n > \n ',[2]=(not skillwatch and not lvlwatch)},}
        for i, v in ipairs(button_list) do
            if button_list[i][2] then
                properties:append(button_list[i][1])
            end
        end
    else
        local menu_name_initialize = {
        ['weapon_select_window']={[1]='Select Weapon',[2]='weapon_types',[3]='wep',[4]='weapon'},['range_select_window']={[1]='Select Range',[2]='range_types',
        [3]='rang',[4]='range'},['skill_select_window']={[1]='Select Skill',[2]='skill_type',[3]='skill',},['debug_select_window']={[1]='Select Debug',
        [2]='debug_type',[3]='debug',},['tab_select_window']={[1]='Select Menu Tab',[2]='tab_type',[3]='tab',},
        ['gear_select_window']={[1]='Select Armor',[2]='armor_types',[3]='ger'},}
        properties:append(menu_name_initialize[window_name][1])
        for i, v in ipairs(_G[menu_name_initialize[window_name][2]]) do
            if menu_name_initialize[window_name][4] then
                if sets[menu_name_initialize[window_name][4]][v] then
                    properties:append('${'..menu_name_initialize[window_name][3]..''..i..'|'..string.gsub(v, "_", " ")..'}')
                end
            else
                properties:append('${'..menu_name_initialize[window_name][3]..''..i..'|'..string.gsub(v, "_", " ")..'}')
            end
        end
        if custom_menu and window_name == 'tab_select_window' then
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
    if SJi then
        info.stepm = Stepmax
        info.ssteps = Stopsteps and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
    end
    if WSi then
        info.cstaff = Changestaff and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
        info.ustaff = Usestaff
    end
    if Conquest_Gear then
        info.cneckc = Conquest.neck.change and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
        info.cringc = Conquest.ring.change and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
        info.cneck = Conquest.neck.case[Conquest.neck.case_id]
        info.cring = Conquest.ring.case[Conquest.ring.case_id]
    end
    info.mjob = windower.ffxi.get_player().main_job_full
    info.mjob_lvl = windower.ffxi.get_player().main_job_level
    info.amode = armor_types[armor_types_count]
    info.listm = menu_list[menu_set]
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
    if Registered_Events then
        info.skill = skill_type[skill_count]
    end
    if skill and Registered_Events then
        info.skill_lvl = (skill[skill_type[skill_count]..' Capped'] and "Capped" or skill[skill_type[skill_count]..' Level'])
    end
    info.tskill = skillwatch and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
    info.tswap = _settings.show_swaps and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
    info.debugm = _settings.debug_mode and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
    info.wept = string.gsub(weapon_types[weapon_types_count], "_", " ")
    info.rwept = string.gsub(range_types[range_types_count], "_", " ")
    info.dbenable = full_debug and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
    info.ashard = auto_use_shards and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
    if Debug then
        info.debugtype = string.gsub(debug_type[debug_count], "_", " ")
    end
    if menu_set == 6 then
        for i,v in pairs(custom_rules()) do
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
    local hide_button = {'{mjob}','{mjob_lvl}','{skill_lvl|Updating}'}
    for i, v in ipairs(location) do
        if (hy > location[i].ya and hy < location[i].yb) then
            if type(switches_table[win_name][i]) == 'table' and not table.contains(hide_button, switches_table[win_name][i][1]) then
                if not table.contains(hide_button, switches_table[win_name][i][1]) then
                    windower.prim.set_position('window_button', _G[win_tabl].pos.x, (_G[win_tabl].pos.y + location[i].ya))
                    windower.prim.set_size('window_button', mx, (location[i].yb - location[i].ya))
                    windower.prim.set_visibility('window_button', true)
                else
                    windower.prim.set_position('window_button', 0, 0)
                    windower.prim.set_size('window_button', 1, 1)
                end
            else
                windower.prim.set_visibility('window_button', false)
            end
        end
    end
end
function set_count(switch_tabl,switch)
    for i, v in ipairs(_G[switch_tabl[2]]) do
        for w in string.gmatch(switch, '|(.-)}') do
            if w == string.gsub(v, "_", " ") then
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
        [3]='rang',[4]='range'},['skill_select_window']={[1]='Select Skill',[2]='skill_type',[3]='skill',},['debug_select_window']={[1]='Select Debug',
        [2]='debug_type',[3]='debug',},['tab_select_window']={[1]='Select Menu Tab',[2]='tab_type',[3]='tab',},
        ['gear_select_window']={[1]='Select Armor',[2]='armor_types',[3]='ger',[4]='armor'},}
    for i, v in pairs(check_windows) do
        if check_windows[i][1] then
            _G[check_windows[i][3]] = set_loc(location,hy,check_windows[i][2],code[check_windows[i][2]]) or 1
            _G[check_windows[i][2]]:hide()
            _G[check_windows[i][2]]:destroy()
            _G[check_windows[i][2]] = nil
            switches_table[check_windows[i][2]] = nil
            windower.prim.set_visibility('window_button', false)
            if File_Write_do then
                File_Write_do()
            end
        end
    end
    updatedisplay()
end
function mouse(mtype, x, y, delta, blocked)
    local check_windows = {['menu']={[1]=(window:hover(x, y) and window:visible()),[2]='window'},['min_window']={[1]=(button:hover(x, y) and button:visible()),[2]='button'},
    ['skill_select']={[1]=(skillwatch and skill_select_window and skill_select_window:hover(x, y) and skill_select_window:visible()),[2]='skill_select_window',[3]='skill_count'},
    ['debug_select']={[1]=(Debug and debug_select_window and debug_select_window:hover(x, y) and debug_select_window:visible()),[2]='debug_select_window',[3]='debug_count'},
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
function menu_commands(a)
    if a == "{stepm}" then
        Stepmax = (Stepmax % 5) + 1
    elseif a == "{ssteps}" then
        Stopsteps = not Stopsteps
    elseif a == "{wept}" then
        wep_select = {text = {font='Segoe UI Symbol',size=9},bg={alpha=200},flags={draggable=false},pos={x=(menu.pos.x - 120),y=(menu.pos.y)}}
        weapon_select_window = texts.new(wep_select)
        initialize(weapon_select_window, wep_select, 'weapon_select_window')
        weapon_select_window:show()
    elseif a == "{rwept}" then
        range_select = {text = {font='Segoe UI Symbol',size=9},bg={alpha=200},flags={draggable=false},pos={x=(menu.pos.x - 120),y=(menu.pos.y)}}
        range_select_window = texts.new(range_select)
        initialize(range_select_window, range_select, 'range_select_window')
        range_select_window:show()
    elseif a == "{cstaff}" then
        Changestaff = not Changestaff
    elseif a == "{ustaff}" then
        Usestaff = (Usestaff=='Atk' and 'Acc' or 'Atk')
    elseif a == "{cneckc}" then
        Conquest.neck.change = not Conquest.neck.change
    elseif a == "{cringc}" then
        Conquest.ring.change = not Conquest.ring.change
    elseif a == "{cneck}" then
        Conquest.neck.case_id = (Conquest.neck.case_id % #Conquest.neck.case) + 1
    elseif a == "{cring}" then
        Conquest.ring.case_id = (Conquest.ring.case_id % #Conquest.ring.case) + 1
    elseif a == "{amode}" then
        ger_select = {text = {font='Segoe UI Symbol',size=9},bg={alpha=200},flags={draggable=false},pos={x=(menu.pos.x - 120),y=(menu.pos.y)}}
        gear_select_window = texts.new(ger_select)
        initialize(gear_select_window, ger_select, 'gear_select_window')
        gear_select_window:show()
    elseif a == '{tmji}' then
        MJi = not MJi
        if MJi and not Disable_All and gearswap.pathsearch({'includes/mjob/main_job_'..player.main_job..'.lua'}) then
            include('includes/mjob/main_job_'..player.main_job..'.lua')
        else
            remove_functions('MJi_')
        end
    elseif a == '{tsji}' then
        SJi = not SJi
        if SJi and not Disable_All and gearswap.pathsearch({'includes/sjob/sub_job_'..player.sub_job..'.lua'}) then
            include('includes/sjob/sub_job_'..player.sub_job..'.lua')
        else
            remove_functions('SJi_')
        end
    elseif a == '{tmsi}' then
        MSi = not MSi
        if MSi and not Disable_All and table.contains(jobs.magic, player.main_job) and 
                                                        gearswap.pathsearch({'includes/extra_more/MSi.lua'}) then
            include('includes/extra_more/MSi.lua')
        else
            remove_functions('MSi_')
        end
    elseif a == '{dbenable}' then
        full_debug = not full_debug
    elseif a == '{tfwi}' then
        File_Write = not File_Write
        if File_Write_do then
            File_Write_do()
        end
        if File_Write and not Disable_All and gearswap.pathsearch({'includes/extra_more/File_Write.lua'}) then
            include('includes/extra_more/File_Write.lua')
        else
            remove_functions('File_Write_')
        end
    elseif a == '{twsi}' then
        WSi = not WSi
        if WSi and not Disable_All and gearswap.pathsearch({'includes/extra_more/WSi.lua'}) then
            include('includes/extra_more/WSi.lua')
        else
            remove_functions('WSi_')
        end
    elseif a == '{tammo}' then
        Ammo = not Ammo
        if Ammo and not Disable_All and table.contains(jobs.ammo, player.main_job) and 
                                                            gearswap.pathsearch({'includes/extra_more/Ammo.lua'}) then
            include('includes/extra_more/Ammo.lua')
        else
            remove_functions('Ammo_')
        end
    elseif a == '{tswi}' then
        Special_Weapons = not Special_Weapons
        if Special_Weapons and not Disable_All and gearswap.pathsearch({'includes/extra_more/Special_Weapons.lua'}) then
            include('includes/extra_more/Special_Weapons.lua')
        else
            remove_functions('Special_Weapons_')
        end
    elseif a == '{tcgi}' then
        Conquest_Gear = not Conquest_Gear
        if Conquest_Gear and not Disable_All and gearswap.pathsearch({'includes/extra_more/Conquest_Gear.lua'}) then
            include('includes/extra_more/Conquest_Gear.lua')
        else
            remove_functions('Conquest_Gear_')
        end
    elseif a == '{trei}' then
        Registered_Events = not Registered_Events
        if Registered_Events and not Disable_All and gearswap.pathsearch({'includes/extra_more/Registered_Events.lua'}) then
            include('includes/extra_more/Registered_Events.lua')
        else
            remove_functions('Registered_Events_')
        end
    elseif a == '{tdebug}' then
        Debug = not Debug
        if Debug and not Disable_All and gearswap.pathsearch({'includes/extra_more/Debug.lua'}) then
            include('includes/extra_more/Debug.lua')
        else
            remove_functions('Debug_')
        end
    elseif a == '{tmjl}' then
        lvlwatch = not lvlwatch
    elseif a == "{listm}" then
        tab_select = {text = {font='Segoe UI Symbol',size=9},bg={alpha=200},flags={draggable=false},pos={x=(menu.pos.x - 120),y=(menu.pos.y)}}
        tab_select_window = texts.new(tab_select)
        initialize(tab_select_window, tab_select, 'tab_select_window')
        tab_select_window:show()
    elseif a == "{skill}" then
        skill_select = {text = {font='Segoe UI Symbol',size=9},bg={alpha=200},flags={draggable=false},pos={x=(menu.pos.x - 120),y=(menu.pos.y - 300)}}
        skill_select_window = texts.new(skill_select)
        initialize(skill_select_window, skill_select, 'skill_select_window')
        skill_select_window:show()
    elseif a == "{debugtype}" then
        debug_select = {text = {font='Segoe UI Symbol',size=9},bg={alpha=200},flags={draggable=false},pos={x=(menu.pos.x - 120),y=(menu.pos.y)}}
        debug_select_window = texts.new(debug_select)
        initialize(debug_select_window, debug_select, 'debug_select_window')
        debug_select_window:show()
    elseif a == "{tskill}" then
        skillwatch = not skillwatch
    elseif a == "{tswap}" then
        if _settings.show_swaps then
            show_swaps(false)
        else
            show_swaps(true)
        end
    elseif a == "{debugm}" then
        if _settings.debug_mode then
            debug_mode(false)
        else
            debug_mode(true)
        end
    elseif a == "{regs|Reload Gearswap}" then
        send_command('lua reload gearswap')
    elseif a == "{gsex1|Gearswap Export}" then
        send_command('gs export')
    elseif a == "{filew|Force File Write}" then
        File_Write_do()
    elseif a == "{hid|HIDE}" then
        window:hide()
        window_hidden = true
        button:show()
        windower.prim.set_visibility('window_button', false)
    elseif a == '{ashard}' then
        auto_use_shards = not auto_use_shards
    end
    if custom_menu_commands then
        custom_menu_commands(a)
    end
    if File_Write_do then
        File_Write_do()
    end
end
mouse_id = windower.raw_register_event('mouse', mouse)
function remove_functions(remove_function_name)
    for i, v in pairs(_G) do
        if i:startswith(remove_function_name) and i:endswith('id') then
            windower.unregister_event(_G[i])
            _G[i] = nil
        elseif i:startswith(remove_function_name) then
            _G[i] = nil
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