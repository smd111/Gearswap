Hwauto,allied_tags,Rapture,Divine_seal,Reive_mark,Besieged,s_waltz_h_a,Contradance_potency = false,false,false,false,false,false,true,0
function load_include(a,b)
    if a and not Disable_All then
        if gearswap.pathsearch({"SMDinclude/includes/"..b}) then
            include("SMDinclude/includes/"..b)
        else
            error("unable to find include file SMDinclude/includes/"..b)
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
        if tool then
            send_command('input /item "'..tool..'" <me>')
        end
        status.end_spell=true
        status.end_event=true
    end
end
function extra.pretarget(status,event,spell)
    if spell.type == "WeaponSkill" then
        if Enable_auto_WS_aoe and aggro_count() >= (User_aggro_aoe and User_aggro_aoe or 2) and not S{"Archery","Marksmanship","Throwing"}:contains(spell.skill) then
            local new_ws = ws_to_aoews(spell)
            if spell.name ~= new_ws then
                status.end_event=true
                status.end_spell=true
                send_command('input /ws "'..new_ws..'" <t>')
                return
            end
        end
    end
end
function extra.precast(status,event,spell)
    if DNC and spell.type == 'Waltz' then
        if spell.target.type == "SELF" and spell.en:startswith('Curing Waltz') then
            local set,potency,received_pot,tpreduction = DNC.waltz_potency(sets["Waltz"])
            local new_waltz,h_total = DNC.select_waltz(potency,received_pot,tpreduction)
            if new_waltz and spell.name ~= new_waltz then
                send_command('input /ja "'..new_waltz..'" <me>')
                status.end_event=true
                status.end_spell=true
                return
            elseif h_total == 0 then
                add_to_chat(cc.mc, 'Canceling '..(spell.name):color(cc.r1,cc.mc)..' HP Loss At 0')
                status.end_event=true
                status.end_spell=true
                return
            else
                if s_waltz_h_a and not showed then
                    add_to_chat(cc.mc, 'Waltz Set To '..(new_waltz):color(cc.y1,cc.mc)..' for '..(tostring(h_total)):color(cc.g1))
                end
            end
            sets.building[event] = set_combine(sets.building[event], set)
        end
    elseif WHM and S{"Cure","Cure II","Cure III","Cure IV","Cure V","Cure VI"}:contains(spell.en) then
        local set,potency,received_pot,cast_time_reduction = WHM.cure_pot(set_combine(cure_gear[lang[gearswap.language]], sets.cure))
        local new_cure = WHM.select_cure(potency,received_pot,spell.target.type)
        if new_cure and spell.en ~= new_cure then
            send_command('input /ma "'..new_cure..'" '..spell.target.raw)
            status.end_event=true
            status.end_spell=true
        end
        sets.building[event] = set_combine(sets.building[event], set)
    elseif DNC and spell.type == "Samba" and spell.en:startswith('Drain Samba') then
        local new_Samba = (DNC.set_drain_samba() or false)
        if new_Samba and spell.en ~= new_Samba then
            send_command('input /ja "'..new_Samba..'" <me>')
            status.end_event=true
            status.end_spell=true
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
        if reg_event and reg_event.clear_aggro_count then
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
        if aoe_ws:contains(ws) then
            return ws
        end
    end
    return spell.name
end
function aggro_count(typ)--returns aggro count
     if reg_event and reg_event.attacker_count then
        return reg_event.attacker_count(typ)
     else
        return 0
     end
end
function has_any_buff_of(buff_set)--returns true if you have any of the buffs given
    for i,v in pairs(buff_set) do
        if buffactive[v] ~= nil then
            return true
        end
    end
end
function item_to_bag(name)
    for _,bag in ipairs(equip_from_bags) do
        local item = player[bag][name]
        if item then
            return bag
        end
    end
end
function get_item_extdata(name)--decodes extdata for given item name
    local bag = item_to_bag(name)
    if bag then
        local item = player[bag][name]
        if item then
            return gearswap.extdata.decode(item)
        end
    end
end
function xp_cp_ring_equip(ring)--equips selected ring
    if auto_ring then
        enable("left_ring")
        gearswap.equip_sets('equip_command',nil,{left_ring=rings[rings_count],})
        disable("left_ring")
    end
end
function schedule_xpcp_ring()--scheduals equip of selected ring
    local a = get_item_extdata(rings[rings_count])--get_item_extdata(rings[rings_count])
    if not a then return end
    local ring_time = os.time(os.date("!*t", a.next_use_time))-os.time()
    if type(xpcpcoring) == "thread" then
        coroutine.close(xpcpcoring)
    end
    xpcpcoring = coroutine.schedule(xp_cp_ring_equip:prepare(rings[rings_count]),(ring_time > 0 and ring_time or 1))
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
    if xpcprings.xp:contains(rings[rings_count]) and buffactive['Dedication'] == (check_in_party("Kupofried") and 1 or nil) then
        return true
    elseif xpcprings.cp:contains(rings[rings_count]) and not buffactive['Commitment'] then
        return true
    end
    return false
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
function c_equip(delay, set, event)--delay equip
    return gearswap.equip_sets:schedule(delay, event..'_delayed_equip', nil, set)
end
send_command("input /heal")
if auto_ring and check_ring_buff() then
    schedule_xpcp_ring()
end