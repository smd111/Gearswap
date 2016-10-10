Hwauto,allied_tags,Rapture,Divine_seal,Reive_mark,Besieged,s_waltz_h_a,Contradance_potency = false,false,false,false,false,false,true,0
function load_include(a,b)
    if a and not Disable_All then
        if gearswap.pathsearch({"SMDinclude/includes/"..b}) then
            include("SMDinclude/includes/"..b)
        else
            error("Unable to find include file SMDinclude/includes/"..b)
        end
    end
end
extra = {}
load_include((player.main_job == "NIN" or player.sub_job == "NIN"), 'more/Ninja_Tool.lua')
load_include((player.main_job == "COR" or player.sub_job == "COR"), 'more/CorsairShot_Cards.lua')
load_include((player.main_job == "DNC" or player.sub_job == "DNC"), 'more/DNC_Potency.lua')
load_include((player.main_job == "WHM" or player.sub_job == "WHM"), 'more/WHM_Potency.lua')
load_include(true, 'more/Commands.lua')
load_include(true, 'more/Spell_control.lua')
function extra.filtered_action(status,event,spell)
    if nin_tool and nin_tool.open and spell.skill == "Ninjutsu" then
        local tool = nin_tool.open(status,event,spell)
        if tool then send_command('input /item "'..tool..'" <me>') end
        status.end_spell=true status.end_event=true
    end
end
function extra.pretarget(status,event,spell)
    if spell.type == "WeaponSkill" then
        if Enable_auto_WS_aoe and aggro_count() >= (User_aggro_aoe and User_aggro_aoe or 2) and not S{"Archery","Marksmanship","Throwing"}:contains(spell.skill) then
            local new_ws = ws_to_aoews(spell)
            if spell.name ~= new_ws then
                status.end_event=true status.end_spell=true
                send_command('input /ws "'..new_ws..'" <t>')
                return
            end
        end
    end
end
function extra.precast(status,event,spell)
    if DNC and towaltz and spell.type == 'Waltz' then
        if spell.target.type == "SELF" and spell.en:startswith('Curing Waltz') then
            local set,potency,received_pot,tpreduction = DNC.waltz_potency(sets["Waltz"])
            local new_waltz,h_total = DNC.select_waltz(potency,received_pot,tpreduction)
            if new_waltz and spell.name ~= new_waltz then
                send_command('input /ja "'..new_waltz..'" <me>')
                status.end_event=true status.end_spell=true return
            elseif h_total == 0 then
                add_to_chat(8, 'Canceling '..spell.name..' HP Loss At 0')
                status.end_event=true status.end_spell=true return
            else
                if s_waltz_h_a and towaltzc then
                    add_to_chat(8, 'Waltz Set To '..new_waltz..' for '..tostring(h_total))
                end
            end
            sets.building[event] = set_combine(sets.building[event], set)
        end
    elseif WHM and ocure and S{"Cure","Cure II","Cure III","Cure IV","Cure V","Cure VI"}:contains(spell.en) then
        local set,potency,received_pot,cast_time_reduction = WHM.cure_pot(set_combine(cure_gear[lang[gearswap.language]], sets.cure))
        local new_cure = WHM.select_cure(potency,received_pot,spell.target.type)
        if new_cure and spell.en ~= new_cure then
            send_command('input /ma "'..new_cure..'" '..spell.target.raw)
            status.end_event=true status.end_spell=true
        end
        sets.building[event] = set_combine(sets.building[event], set)
    elseif DNC and tosamba and spell.type == "Samba" and spell.en:startswith('Drain Samba') then
        local new_Samba = (DNC.set_drain_samba() or false)
        if new_Samba and spell.en ~= new_Samba then
            send_command('input /ja "'..new_Samba..'" <me>')
            status.end_event=true status.end_spell=true
        end
    end
    if card and card.rule then
        card.rule(status,event,spell)
    end
end
function extra.buff_change(status,event,name,gain,buff_table)
    if Hwauto and table.contains(Waltz.debuff,name) then
        if gain and player.tp >= 200 and player.sub_job_level > 34 then
            send_command('input /ja "'..gearswap.res.job_abilities[194][gearswap.language]..'" <me>')
        end
    elseif name == "Reive Mark" and not gain then
        if reg_event.clear_aggro_count then
            reg_event.clear_aggro_count:schedule(1.5)
            if updatedisplay then
                updatedisplay:schedule(1.5)
            end
        end
    elseif S{'Commitment','Dedication'}:contains(name) and auto_ring then
        if gain then
            enable("left_ring") equip(gear_equip(name,'buff_change'))
        else
            schedule_xpcp_ring()
        end
    end
end
function extra.aftercast(status,current_event,spell)
    if auto_ring then
        if rings:contains(player.equipment.left_ring) then
            send_command('wait 3.0;input /item "'..player.equipment.left_ring..'" <me>')
        end
    end
end
----WS/Obi equip------------------------------------------------------------------------------------------------------------------
WS_Gear = {}
function WS_Gear.precast(status,event,spell)--equips correct ws gear
    if spell.type == "WeaponSkill" then
        local spell_element = (type(spell.element)=='number' and gearswap.res.elements[spell.element] or gearswap.res.elements:with('name', spell.element))
        if item_to_bag("Fotia Gorget") then
            sets.building[event] = set_combine(sets.building[event], {neck="Fotia Gorget"})
        elseif item_to_bag(sets.ws_neck[spell_element.en].neck) then
            sets.building[event] = set_combine(sets.building[event], sets.ws_neck[spell_element.en])
        end
        if item_to_bag("Fotia Belt") then
            sets.building[event] = set_combine(sets.building[event], {waist="Fotia Belt"})
        elseif item_to_bag(sets.ws_belt[spell_element.en].waist) then
            sets.building[event] = set_combine(sets.building[event], sets.ws_belt[spell_element.en])
        end
        if ws_head and item_to_bag(sets.WS_types[spell.skill].head) then
            sets.building[event] = set_combine(sets.building[event], sets.WS_types[spell.skill])
        end
    end
end
WS_Gear.midcast = WS_Gear.precast
e_obi = {}
function e_obi.midcast(status,event,spell)--equips correct obi
    if not Typ.abilitys:contains(spell.prefix) and spell.action_type ~= "Item" then
        local spell_element = (type(spell.element)=='number' and gearswap.res.elements[spell.element] or gearswap.res.elements:with('name', spell.element))
        if spell_element.name == world.weather_element or spell_element.name == world.day_element then
            if item_to_bag("Hachirin-no-Obi") then
                sets.building[event] = set_combine(sets.building[event], {waist="Hachirin-no-Obi"})
            elseif item_to_bag(sets.spell_obi[spell_element.en].waist) then
                sets.building[event] = set_combine(sets.building[event], sets.spell_obi[spell_element.en])
            end
        end
    end
end
--Extra Functions---------------------------------------------------------------------------------------------------------------
function ws_to_aoews(spell)--returs the highest level AOE weaponskill you can use at this time
    for _,v in pairs(table.reverse(windower.ffxi.get_abilities().weapon_skills)) do
        local ws = gearswap.res.weapon_skills[v][gearswap.language]
        if aoe_ws:contains(ws) then return ws end
    end return spell.name
end
function aggro_count(typ)--returns aggro count
     if reg_event.attacker_count then return reg_event.attacker_count(typ)
     else return 0 end
end
function has_any_buff_of(buff_set)--returns true if you have any of the buffs given
    for i,v in pairs(buff_set) do
        if buffactive[v] ~= nil then return true end
    end
end
function item_to_bag(name)
    for _,bag in ipairs(equip_from_bags) do
        local item = player[bag][name]
        if item then return bag end
    end
end
function schedule_xpcp_ring(stop)--scheduals equip of selected ring
    local ring = rings[rings_count]
    local lock = true
    local ring_time,ex = 1,nil
    if ring == "Not Set" or stop then
        gear_equip(nil,"XP-CP-Ring Stop")
        ring = (sets.building["XP-CP-Ring Stop"].left_ring or empty)
        lock = false
        sets.building["XP-CP-Ring Stop"] = nil
    else
        ex = player[item_to_bag(ring)][ring].extdata
        if ex and ex.charges_remaining >= 1 then ring_time = os.time(os.date("!*t", ex.next_use_time))-os.time() else return end
    end
    if type(xpcpcoring) == "thread" then coroutine.close(xpcpcoring) end
    xpcpcoring = coroutine.schedule(gearswap.equip_sets:prepare('Cp Xp Ring',nil,{left_ring=ring,},true,lock),(ring_time > 0 and ring_time or 1))
end
function check_in_party(name)--returs true if given name is in allience
     for pt_num,pt in ipairs(alliance) do
         for pos,party_position in ipairs(pt) do
             if party_position.name == name then
                return true
             end
         end
     end
end
function check_ring_buff()-- returs true if you do not have the buff from xp cp ring
    local xpcprings = {cp=S{"Vocation Ring","Trizek Ring","Capacity Ring"},
                       xp=S{"Undecennial Ring","Decennial Ring","Allied Ring","Novennial Ring","Kupofried's Ring","Anniversary Ring","Emperor Band",
                            "Empress Band","Chariot Band","Duodec. Ring","Expertise Ring"}}
    if xpcprings.xp:contains(rings[rings_count]) and buffactive['Dedication'] == (check_in_party("Kupofried") and 1 or nil) then return true
    elseif xpcprings.cp:contains(rings[rings_count]) and not buffactive['Commitment'] then return true
    end return false
end
function partybuffcheck(name, buff) --return true if party member has any of buff list else it returns false
    local in_party = check_in_party(name)
     for pt_num,pt in ipairs(alliance) do
         for pos,party_position in ipairs(pt) do
             if party_position.name == name and party_position.buffactive[buff] then
                return true
             end
         end
     end
end
function dwsj()
    if player.sub_job == "NIN" and player.sub_job_level >= 10 then return true
    elseif player.sub_job == "DNC" and player.sub_job_level >= 20 then return true
    end return false
end
function load_rings()
    for _,ring in ipairs({"None","Vocation Ring","Trizek Ring","Capacity Ring","Undecennial Ring","Decennial Ring","Allied Ring","Novennial Ring","Kupofried's Ring",
                          "Anniversary Ring","Emperor Band","Empress Band","Chariot Band","Duodec. Ring","Expertise Ring"}) do
        local item = item_to_bag(ring)
        if item and not rings:contains(ring) then rings:append(ring)
        elseif not item and rings:contains(ring) then rings:delete(ring)
        end
    end
end
function getfield(f)
    local v = _G
    for w in string.gfind(f, "[%w_]+") do
        v = v[w]
    end
    return v
end
function setfield(f, v)
    local t = _G
    for w, d in string.gfind(f, "([%w_]+)(.?)") do
        if d == "." then
            t[w] = t[w] or {}
            t = t[w]
        else
            t[w] = v
        end
    end
end
function custom_equip(set,unlock,lock)
    local slots = {}
    for slot,_ in pairs(set) do
    table.insert(slots,slot)
    end
    if unlock then enable(slots) end
    equip(set)
    if lock then disable(slots) end
end
_G['Cp Xp Ring'] = custom_equip
load_rings()