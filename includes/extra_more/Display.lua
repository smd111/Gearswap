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
        properties:append('Gearswap   \\cs(255,255,0)HIDE\\cr')
        if menu_set == 1 then -- job menu
            properties:append('--Job Settings--')
            if (windower.ffxi.get_player().main_job == 'DNC' and MJi) or (windower.ffxi.get_player().sub_job == 'DNC' and SJi) then
                properties:append('-Steps-')
                properties:append('   Max Step = ${stepm}')
                properties:append('   Stop Steps   ${ssteps}')
            end
            if lvlwatch then
                properties:append('${mjob}')
                properties:append('   lvl = ${mjob_lvl}')
            end
            if skillwatch and Registered_Events then
                properties:append('${skill}')
                properties:append('   lvl = ${skill_lvl|Updating}')
            end
        elseif menu_set == 2 then -- weapon menu
            properties:append('--Weapon Settings--')
            properties:append('Weapon Type = \\cs(255,255,0)${wept}\\cr')
            properties:append('Range Type = \\cs(255,255,0)${rwept}\\cr')
            if table.contains(jobs.magic, player.main_job) and WSi then
                properties:append('-Mage Staves-')
                properties:append('   Auto Change   ${cstaff}')
                properties:append('   Type \\cs(255,255,0)${ustaff}\\cr')
            end
        elseif menu_set == 3 then -- armor menu
            properties:append('--Armor Settings--')
            properties:append('Mode = \\cs(255,255,0)${amode}\\cr')
            if Conquest_Gear then
                properties:append('-Conquest Gear-')
                properties:append('  Change Neck   ${cneckc}')
                properties:append('  Neck Type = \\cs(255,255,0)${cneck}\\cr')
                properties:append('  Change Ring   ${cringc}')
                properties:append('  Ring Type = \\cs(255,255,0)${cring}\\cr')
            end
        elseif menu_set == 4 then -- system menu
            properties:append('--System Settings--')
            if autolock and Registered_Events then
                properties:append('Auto Lock')
                properties:append('  \\cs(255,255,0)Enabled\\cr')
            end
            if autotarget then
                properties:append('Auto Self Target')
                properties:append('After Battle \\cs(255,255,0)Enabled\\cr')
            end
            if stoponskillcap and Registered_Events then
                properties:append('Auto Stop On')
                properties:append('  \\cs(255,255,0)'..string.gsub(stopskilltyp[stopskill_count], "_", " ")..'\\cr Cap')
                if lvl then
                    properties:append('Current Skill')
                    properties:append('  Level = \\cs(255,255,0)'..lvl[stopskilltyp[stopskill_count]]..'\\cr')
                end
            end
            properties:append('Display Main Job')
            properties:append('and LVL   ${tmjl}')
            if Registered_Events then
                properties:append('Show Current ')
                properties:append('Skill Level   ${tskill}')
            end
            properties:append('Show Swaps   ${tswap}')
            properties:append('Debug Mode   ${debugm}')
            if Debug then
                properties:append('Show Debug  ${dbenable}')
                properties:append('  in = ${debugtype}')
            end
            if File_Write then
                properties:append('Force File Write')
            end
            properties:append('Gearswap Export')
            properties:append('Reload Gearswap')
        elseif menu_set == 5 then -- include menu
            properties:append('--Include Settings--')
            properties:append('Ammo   ${tammo}')
            properties:append('Conquest Gear   ${tcgi}')
            properties:append('Debug   ${tdebug}')
            properties:append('File Write   ${tfwi}')
            properties:append('Main Job   ${tmji}')
            if table.contains(jobs.magic, player.main_job) then
                properties:append('Mage Stave   ${tmsi}')
            end
            properties:append('Registered Events   ${trei}')
            properties:append('Special Weapons   ${tswi}')
            properties:append('Sub Job   ${tsji}')
            properties:append('Weapon Skill   ${twsi}')
        elseif menu_set == 6 then --custom menu
            properties:append('Custom Menu')
            for i,v in pairs(custom_menu()) do
                if type(v) == 'string' then
                    properties:append(v)
                end
            end
        end
    elseif window_name == 'button' then
        if lvlwatch then
            properties:append('${mjob}   lvl = ${mjob_lvl}')
        end
        if skillwatch and Registered_Events then
            properties:append('${skill}   lvl = ${skill_lvl}')
        end
        if not skillwatch and not lvlwatch then
            properties:append('\n > \n ')
        end
    else
        local menu_name_initialize = {
        ['weapon_select_window']={[1]='Select Weapon',[2]='weapon_types',[3]='wep',[4]='weapon'},['range_select_window']={[1]='Select Range',[2]='range_type',
        [3]='rang',[4]='range'},['skill_select_window']={[1]='Select Skill',[2]='skill_type',[3]='skill',},['debug_select_window']={[1]='Select Debug',
        [2]='debug_type',[3]='debug',},['tab_select_window']={[1]='Select Menu Tab',[2]='tab_type',[3]='tab',},}
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
if Debug then
    debug_select_window = texts.new(debug_select)
    initialize(debug_select_window, debug_select, 'debug_select_window')
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
    info.amode = gear_mode[gear_mode_count]
    if menu_set == 6 then
        info = custom_rules()
    end
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
    info.tswap = tswap and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
    info.debugm = debugmod and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
    info.wept = string.gsub(weapon_types[weapon_types_count], "_", " ")
    info.rwept = string.gsub(range_type[range_type_count], "_", " ")
    info.dbenable = full_debug and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
    if Debug then
        info.debugtype = debug_type[debug_count]
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
            mx, my = windower.text.get_extents(_G[check_windows[i][2]]._name)
            button_lines = _G[check_windows[i][2]]:text():count('\n') + 1
            hx = (x - _G[i].pos.x)
            hy = (y - _G[i].pos.y)
        end
    end
    return my, mx, button_lines, hx, hy
end
function set_prim_loc(location,win_name,win_tabl,mx,hy)
    local hide_button = {'{mjob}','{mjob_lvl}','{skill_lvl}'}
    for i, v in ipairs(location) do
        if (hy > location[i].ya and hy < location[i].yb) then
            if type(switches_table[win_name][i]) == 'table' and not table.contains(hide_button, switches_table[win_name][i][1]) then
                if not table.contains(hide_button, switches_table[win_name][i][1]) then
                    windower.prim.set_position('window_button', _G[win_tabl].pos.x, (_G[win_tabl].pos.y + location[i].ya))
                    windower.prim.set_size('window_button', mx, (location[i].yb - location[i].ya))
                else
                    windower.prim.set_position('window_button', 0, 0)
                    windower.prim.set_size('window_button', 1, 1)
                end
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
        ['weapon_select_window']={[1]='Select Weapon',[2]='weapon_types',[3]='wep',[4]='weapon'},['range_select_window']={[1]='Select Range',[2]='range_type',
        [3]='rang',[4]='range'},['skill_select_window']={[1]='Select Skill',[2]='skill_type',[3]='skill',},['debug_select_window']={[1]='Select Debug',
        [2]='debug_type',[3]='debug',},['tab_select_window']={[1]='elect Menu Tab',[2]='tab_type',[3]='tab',},}
    for i, v in pairs(check_windows) do
        if check_windows[i][1] then
            _G[check_windows[i][3]] = set_loc(location,hy,check_windows[i][2],code[check_windows[i][2]]) or 1
            _G[check_windows[i][2]]:hide()
            _G[check_windows[i][2]]:destroy()
            _G[check_windows[i][2]] = nil
            switches_table[check_windows[i][2]] = nil
            if file_write then
                file_write()
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
    ['range_select']={[1]=(range_select_window and range_select_window:hover(x, y) and range_select_window:visible()),[2]='range_select_window',[3]='range_type_count'},}
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
        if window:hover(x, y) and window:visible() then
            if (hy > location[2].ya and hy < location[2].yb) then
                windower.prim.set_position('window_button', menu.pos.x, (menu.pos.y + location[2].ya))
                windower.prim.set_size('window_button', mx, (location[2].yb - location[2].ya))
            elseif (hy > location[(button_lines - 2)].ya and hy < location[(button_lines - 2)].yb) and menu_set == 4 and File_Write then
                windower.prim.set_position('window_button', menu.pos.x, (menu.pos.y + location[(button_lines - 2)].ya))
                windower.prim.set_size('window_button', mx, (location[(button_lines - 2)].yb - location[(button_lines - 2)].ya))
            elseif (hy > location[(button_lines - 1)].ya and hy < location[(button_lines - 1)].yb) and menu_set == 4 then
                windower.prim.set_position('window_button', menu.pos.x, (menu.pos.y + location[(button_lines - 1)].ya))
                windower.prim.set_size('window_button', mx, (location[(button_lines - 1)].yb - location[(button_lines - 1)].ya))
            elseif (hy > location[(button_lines)].ya and hy < location[(button_lines)].yb) and menu_set == 4 then
                windower.prim.set_position('window_button', menu.pos.x, (menu.pos.y + location[(button_lines)].ya))
                windower.prim.set_size('window_button', mx, (location[(button_lines)].yb - location[(button_lines)].ya))
            else
                set_prim_loc(location,'window','menu',mx,hy)
            end
            windower.prim.set_visibility('window_button', true)
        elseif button:hover(x, y) and button:visible() then
            windower.prim.set_position('window_button', min_window.pos.x, min_window.pos.y)
            windower.prim.set_size('window_button', mx, my)
            windower.prim.set_visibility('window_button', true)
        elseif skillwatch and skill_select_window and skill_select_window:hover(x, y) and skill_select_window:visible() then
            set_prim_loc(location,'skill_select_window','skill_select',mx,hy)
            windower.prim.set_visibility('window_button', true)
        elseif Debug and debug_select_window and debug_select_window:hover(x, y) and debug_select_window:visible() then
            set_prim_loc(location,'debug_select_window','debug_select',mx,hy)
            windower.prim.set_visibility('window_button', true)
        elseif tab_select_window and tab_select_window:hover(x, y) and tab_select_window:visible() then
            set_prim_loc(location,'tab_select_window','tab_select',mx,hy)
            windower.prim.set_visibility('window_button', true)
        elseif weapon_select_window and weapon_select_window:hover(x, y) and weapon_select_window:visible() then
            set_prim_loc(location,'weapon_select_window','wep_select',mx,hy)
            windower.prim.set_visibility('window_button', true)
        elseif range_select_window and range_select_window:hover(x, y) and range_select_window:visible() then
            set_prim_loc(location,'range_select_window','range_select',mx,hy)
            windower.prim.set_visibility('window_button', true)
        else
            windower.prim.set_visibility('window_button', false)
        end
    elseif mtype == 2 then
        if window:hover(x, y) and window:visible() then
            if (hy > location[2].ya and hy < location[2].yb) then
                window:hide()
                window_hidden = true
                button:show()
            elseif (hy > location[(button_lines - 2)].ya and hy < location[(button_lines - 2)].yb) and menu_set == 4  and File_Write then
                file_write()
            elseif (hy > location[(button_lines - 1)].ya and hy < location[(button_lines - 1)].yb) and menu_set == 4 then
                send_command('gs export')
            elseif (hy > location[(button_lines)].ya and hy < location[(button_lines)].yb) and menu_set == 4 then
                send_command('gs r')
            else
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
            end
        elseif button:hover(x, y) and button:visible() then
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
        gear_mode_count = (gear_mode_count % #gear_mode) + 1
    elseif a == '{tmji}' then
        MJi = not MJi
        if MJi and not Disable_All and gearswap.pathsearch({'includes/mjob/main_job_'..player.main_job..'.lua'}) then
            include('includes/mjob/main_job_'..player.main_job..'.lua')
        else
            remove_functions('MJi')
        end
    elseif a == '{tsji}' then
        SJi = not SJi
        if SJi and not Disable_All and gearswap.pathsearch({'includes/sjob/sub_job_'..player.sub_job..'.lua'}) then
            include('includes/sjob/sub_job_'..player.sub_job..'.lua')
        else
            remove_functions('SJi')
        end
    elseif a == '{tmsi}' then
        MSi = not MSi
        if MSi and not Disable_All and table.contains(jobs.magic, player.main_job) and 
                                                        gearswap.pathsearch({'includes/extra_more/MSi.lua'}) then
            include('includes/extra_more/MSi.lua')
        else
            remove_functions('MSi')
        end
    elseif a == '{dbenable}' then
        full_debug = not full_debug
    elseif a == '{tfwi}' then
        File_Write = not File_Write
        if file_write then
            file_write()
        end
        if File_Write and not Disable_All and gearswap.pathsearch({'includes/extra_more/File_Write.lua'}) then
            include('includes/extra_more/File_Write.lua')
        else
            remove_functions('File_Write')
        end
    elseif a == '{twsi}' then
        WSi = not WSi
        if WSi and not Disable_All and gearswap.pathsearch({'includes/extra_more/WSi.lua'}) then
            include('includes/extra_more/WSi.lua')
        else
            remove_functions('WSi')
        end
    elseif a == '{tammo}' then
        Ammo = not Ammo
        if Ammo and not Disable_All and table.contains(jobs.ammo, player.main_job) and 
                                                            gearswap.pathsearch({'includes/extra_more/Ammo.lua'}) then
            include('includes/extra_more/Ammo.lua')
        else
            remove_functions('Ammo')
        end
    elseif a == '{tswi}' then
        Special_Weapons = not Special_Weapons
        if Special_Weapons and not Disable_All and gearswap.pathsearch({'includes/extra_more/Special_Weapons.lua'}) then
            include('includes/extra_more/Special_Weapons.lua')
        else
            remove_functions('Special_Weapons')
        end
    elseif a == '{tcgi}' then
        Conquest_Gear = not Conquest_Gear
        if Conquest_Gear and not Disable_All and gearswap.pathsearch({'includes/extra_more/Conquest_Gear.lua'}) then
            include('includes/extra_more/Conquest_Gear.lua')
        else
            remove_functions('Conquest_Gear')
        end
    elseif a == '{trei}' then
        Registered_Events = not Registered_Events
        if Registered_Events and not Disable_All and gearswap.pathsearch({'includes/extra_more/Registered_Events.lua'}) then
            include('includes/extra_more/Registered_Events.lua')
        else
            remove_functions('Registered_Events')
        end
    elseif a == '{tdebug}' then
        Debug = not Debug
        if Debug and not Disable_All and gearswap.pathsearch({'includes/extra_more/Debug.lua'}) then
            include('includes/extra_more/Debug.lua')
        else
            debug_select_window:destroy()
            switches_table['debug_select_window'] = nil
            debug_select = nil
            remove_functions('Debug')
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
    elseif a == "{debug_type}" then
        debug_select = {text = {font='Segoe UI Symbol',size=9},bg={alpha=200},flags={draggable=false},pos={x=(menu.pos.x - 120),y=(menu.pos.y)}}
        debug_select_window = texts.new(debug_select)
        initialize(debug_select_window, debug_select, 'debug_select_window')
        debug_select_window:show()
    elseif a == "{tskill}" then
        skillwatch = not skillwatch
    elseif a == "{tswap}" then
        tswap = not tswap
        if tswap then
            show_swaps(true)
        else
            show_swaps(false)
        end
    elseif a == "{debugm}" then
        debugmod = not debugmod
        if debugmod then
            debug_mode(true)
        else
            debug_mode(false)
        end
    end
    if custom_menu_commands then
        custom_menu_commands(a)
    end
    if file_write then
        file_write()
    end
end
mouse_id = windower.raw_register_event('mouse', mouse)
function remove_functions(a)
    local removeable_functions = {
    ['WSi'] = {"sets.weaponskill","equip_elemental_ws_Gear"},['Special_Weapons'] = {"special_weapon"},
    ['Registered_Events'] = {'skill_type','event_action','level_up','incoming_chunk','target_change,',events = {'action_id','level_up_id','level_down_id','incoming_chunk_id','target_change_id'}},
    ['MJi'] = {'cards','card_rule','card_getmore','card_check','nin_tools','nin_tool_rule','nin_tool_check','nin_tool_open','main_job_file_unload','main_job_status_change','main_job_pretarget','main_job_precast','main_job_buff_change','main_job_midcast','main_job_aftercast','main_jobs_self_command','main_job_pet_change','main_job_pet_midcast','main_job_pet_aftercast','main_job_filtered_action','main_job_file_unload'},
    ['SJi'] = {'cards','card_rule','card_getmore','card_check','nin_tools','nin_tool_rule','nin_tool_check','nin_tool_open','sub_job_file_unload','sub_job_status_change','sub_job_pretarget','sub_job_precast','sub_job_buff_change','sub_job_midcast','sub_job_aftercast','main_jobs_self_command','sub_job_pet_change','sub_job_pet_midcast','sub_job_pet_aftercast','sub_job_filtered_action','sub_job_file_unload'},
    ['MSi'] = {'equip_elemental_magic_staves','equip_elemental_magic_Gear_self_command','sets.staff'},['Ammo'] = {'combined_ammo','ammo_check','ammo_reequip','ammo_rule'},['Conquest_Gear'] = {'conquest_Gear','conquest_Gear_self_command'},
    ['Debug'] = {'debug_status_change','debug_pet_change','debug_filtered_action','debug_pretarget','debug_precast','debug_buff_change','debug_midcast','debug_pet_midcast','debug_aftercast','debug_pet_aftercast','debug_self_command'},
    ['Display'] = {'initialize','grab_switches','update_display','updatedisplay','auto_hide_window','mouse','menu_commands','remove_functions',events = {'mouse_id'}},
    ['File_Write'] = {'file_write'},}
    if removeable_functions[a].events then
        for i, v in ipairs(removeable_functions[a].events) do
            if _G[v] then
                windower.unregister_event(_G[v])
            end
        end
    end
    if removeable_functions[a] then
        for i, v in ipairs(removeable_functions[a]) do
            if _G[v] then
                _G[v] = nil
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