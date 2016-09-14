--this contains all the self created functions to make my display work
function c_w(a,b,x,y)
    return (_G[a] and _G[b] and _G[b]:hover(x, y) and _G[b]:visible()) or (_G[b] and _G[b]:hover(x, y) and _G[b]:visible()) or
            (type(_G[a]) == "table" and _G[a]:hover(x, y) and _G[a]:visible())
end
function get_vars(men,mode,x,y)
    local ctext = {text = {font='Segoe UI Symbol',size=9},bg={alpha=200},flags={draggable=false},pos={x=(menu.pos.x - 120),y=(menu.pos.y)}}                
    local menu_i = {
        [1]={name="weapon_select_window",command='{wept}',title="Select Weapon",var="wep_select",vara="weapon",varc="weapon_types_count",vard="weapon_types",
             text=ctext,menu_slot="wep"},
        [2]={name="range_select_window",command='{rwept}',title="Select Range",var="range_select",vara="range",varc="range_types_count",vard="range_types",
             text=ctext,menu_slot="rang"},
        [3]={name="debug_select_window",command='{debugtype}',title="Select Debug",var="debug_select",varb="Debug",varc="fdebug.count",vard="fdebug.type",text=ctext,
             menu_slot="debug"},
        [4]={name="xpcpring_select_window",command='{xpcpring}',title="Select Xp Cp Ring",var="ring_select",varc="rings_count",vard="rings",text=ctext,
             menu_slot="ring"},
        [5]={name="skill_select_window",command='{skill}',title="Select Skill",var="skill_select",varb="skillwatch",varc="skill_count", vard="reg_event.skill_type",
             text={text={font='Segoe UI Symbol',size=9},bg={alpha=200},flags={draggable=false},pos={x=(menu.pos.x - 120),y=(menu.pos.y - 300)}},
             menu_slot="reg_event.skill"},
        [6]={name="tab_select_window",command='{listm}',title="Select Menu Tab",var="tab_select",varc="menu_set",vard="tab_type",text=ctext,menu_slot="tab"},
        [7]={name="gear_select_window",command='{amode}',title="Select Armor",var="ger_select",vara="armor",varc="armor_types_count",vard="armor_types",text=ctext,
             menu_slot="ger"},
        [8]={nameb="menu",var="menu",varb='window'},
        [9]={nameb="min_window",var="min_window",varb="button"}}
    local a = {}
    for i,v in ipairs(menu_i) do
        if mode == "command" and v.text then
            if v.command and v.command == men then
                a[v.command]={[1]=v.name,[2]=v.var,[3]=v.text}
            elseif v.command then
                a[v.command]={[1]=v.name}
            end
        elseif mode == "check" then
            if v.varb and v.name then
                a[v.var]={[1]=c_w(v.varb,v.name,x,y),[2]=v.name,[3]=v.varc}
            elseif v.varb and not v.name then
                a[v.var]={[1]=c_w(v.varb,nil,x,y),[2]=v.varb}
            elseif v.name then
                a[v.var]={[1]=c_w(nil,v.name,x,y),[2]=v.name,[3]=v.varc}
            end
        elseif mode == "code" and v.name and v.name == men then
            return {[1]=v.title,[2]=v.vard,[3]=v.menu_slot,[4]=v.vara}
        elseif mode == "menu" and v.name and v.name == men then
            if v.name and v.vara then
                a[v.name]={[1]=v.title,[2]=v.vard,[3]=v.menu_slot,[4]=v.vara}
            elseif v.name then
                a[v.name]={[1]=v.title,[2]=v.vard,[3]=v.menu_slot}
            end
        end
    end
    return a
end
function grab_switches(name,tab)--pulls switches from the display
    local tabl = L{}
    for _,v in ipairs(tab) do
        for _,v2 in ipairs(string.split(v,'\n')) do
            tabl:append(v2)
        end
    end
    if not switch then
        switch = {}
    end
    switch[name] = tabl
    for i,v in ipairs(switch[name]) do
        for w in string.gmatch(v, '{.-}') do
            if type(switch[name][i]) ~= 'table' then
                switch[name][i] = T{}
            end
        switch[name][i]:append(w)
        end
    end
end
function update_display()
    windower.prim.create('window_button')
    windower.prim.set_visibility('window_button', false)
    windower.prim.set_color('window_button', 200, 255, 255, 255)
    updatedisplay()
end
function get_window_pos(x,y,check)
    local my, mx, button_lines, hx, hy = 0,0,0,0,0,0
    for i, v in pairs(check) do
        if v[1] then
            mx, my = texts.extents(_G[v[2]])
            button_lines = _G[v[2]]:text():count('\n') + 1
            hx = (x - _G[i].pos.x)
            hy = (y - _G[i].pos.y)
        end
    end
    return my, mx, button_lines, hx, hy
end
function set_prim_loc(loc,name,tab,x,y)--gets location to highlight curenly selected option
    local hide_button = S{'{mjob}','{mjob_lvl}','{skill_lvl|Updating}','{pagro|0}','{pragro|0}','{aagro|0},{ptgro|0}'}
    for i, v in ipairs(loc) do
        if (y > v.ya and y < v.yb) then
            if type(switch[name][i]) == 'table' and not hide_button:contains(switch[name][i][1]) then
                windower.prim.set_position('window_button', _G[tab].pos.x, (_G[tab].pos.y + v.ya))
                windower.prim.set_size('window_button', x, (v.yb - v.ya))
                windower.prim.set_visibility('window_button', true)
            else
                windower.prim.set_position('window_button', 0, 0)
                windower.prim.set_size('window_button', 1, 1)
                windower.prim.set_visibility('window_button', false)
            end
        end
    end
end
function set_count(tab,switch)
    for i,v in ipairs(loadstring('return user_env.'..tab[2])()) do 
        for w in string.gmatch(switch, '|(.-)}') do
            if string.gsub(w, "_", " ") == string.gsub(v, "_", " ") then 
                if tostring(string.gmatch(switch, '{(.-)|')):startswith("ring") and get_item_next_use(rings[rings_count]) then
                    schedule_xpcp_ring()
                end
                return i
            elseif string.gsub(w, "_", " ") == string.gsub(v, "_", " "):capitalize() then
                return i
            elseif "Custom Menu" == w then
                return 6
            end
        end
    end
    
end
function set_loc(loc,hy,name,tab)
    for i, v in ipairs(loc) do
        if (hy > v.ya and hy < v.yb) then
            if type(switch[name][i]) == 'table' then
                if switch[name][i][1] then
                    return set_count(tab,switch[name][i][1])
                end
            end
        end
    end
end
function kill_window(w)--closes/destroys window
    _G[w]:hide()
    _G[w]:destroy()
    _G[w] = nil
end
function remove_functions(name,iname)--cleans current gearswap memory of disabled addon
    if _G[name] then
        for i, v in pairs(_G[name]) do
            if i:endswith('id') then
                windower.unregister_event(v)
            else
                _G[name][i] = nil
            end
        end
    end
end