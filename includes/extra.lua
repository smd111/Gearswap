if not Stepmax then Stepmax = 1 end
if not Stopsteps then Stopsteps = false end
Hwauto = false
----Check spell ruels-------------------------------------------------------------------------------------------------------------
function spell_stopper(spell)
    if world.in_mog_house or world.mog_house then return true end
    if midaction() or pet_midaction() then return true end
    if spell.target.name == nil then return true end
    -- if not S{"Ranged Attack","Item"}:contains(spell.action_type) and spell_range_check(spell) then return true end
    if spell.action_type == 'Ability' and windower.ffxi.get_ability_recasts()[spell.recast_id] and (tonumber(windower.ffxi.get_ability_recasts()[spell.recast_id]) > 0 or has_any_buff_of({'Amnesia','Charm','Impairment','Petrification','Sleep','Stun','Terror'})) then
        return true
    elseif spell.action_type == 'Magic' and (tonumber(windower.ffxi.get_spell_recasts()[spell.id]) > 0 or has_any_buff_of({'Charm','Mute','Omerta','Petrification','Silence','Sleep','Stun','Terror'})) then
        return true
    end
    if spell.tp_cost and spell.tp_cost > player.tp then return true
    elseif spell.mp_cost and spell.mp_cost > player.mp and not (buffactive['Manawell'] or buffactive['Manafont']) then return true
    end
    if player.tp < 1000 and spell.type == 'WeaponSkill' then return true end
    if spell.type == "Trust" and party.count > 1 then
        if player.in_combat then return true end
        for pt_num,pt in ipairs(alliance) do
            for pos,party_position in ipairs(pt) do
                if party_position.name == string.gsub(spell.en, "%s+", "") then
                    return true
                end
            end
        end
    end
    if not transportation_spells:contains(spell.en) and cities:contains(world.area) then return true end
    local fm_count = 0
    for i, v in pairs(buffactive) do
        if tostring(i):startswith('finishing move') or tostring(i):startswith('フィニシングムーブ') then
            fm_count = tonumber(string.match(tostring(i), '%d+')) or 1
        end
    end
    if min_fm_for_flourishes[spell.en] then
        if min_fm_for_flourishes[spell.en] > fm_count then
            return true
        end
    end
    if spell.type == 'Step' then
        if spell.tp_cost > player.tp then
            return true
        end
        if Stopsteps then
            if fm_count >= Stepmax then
                return true
            end
        end
    end
end
function spell_range_check(spell)
    -- local range_mult = {[0] = 0,[1] = 1.642276421172564,[2] = 1.642276421172564,[3] = 1.642276421172564,[4] = 1.642276421172564,[5] = 1.642276421172564,
                        -- [6] = 1.642276421172564,[7] = 1.642276421172564,[8] = 1.642276421172564,[9] = 1.642276421172564,[10] = 1.642276421172564,
                        -- [11] = 1.642276421172564,[12] = 1.642276421172564,}
    local range_mult = {[0] = 0,[2] =  1.70,[3] = 1.490909,[4] = 1.44,[5] = 1.377778,[6] = 1.30,[7] = 1.20,[8] = 1.30,[9] = 1.377778,[10] = 1.45,[11] = 1.490909,
                        [12] = 1.70,}
    local spell_max_distance = (spell.target.model_size + spell.range * range_mult[spell.range]) --spell.target.model_size + spell.range * range_mult[spell.range]
    if spell_max_distance < spell.target.distance then
        --add_to_chat(7,"Target out of "..spell.name.."'s max range of "..spell_max_distance)
        return true
    end
end
function gearchang_stopper(spell)
    if spell and spell.action_type == "Ability" and has_any_buff_of({'Amnesia','Charm','Impairment','Petrification','Sleep','Stun','Terror'}) then
        return true
    elseif spell and spell.action_type == "Magic" and has_any_buff_of({'Charm','Mute','Omerta','Petrification','Silence','Sleep','Stun','Terror'}) then
        return true
    end
end
--extra functions-----------------------------------------------------------------------------------------------------------------
extra = {}
if player.main_job == "NIN" or player.sub_job == "NIN" then include('includes/more/Ninja_Tool.lua') end
if player.main_job == "COR" or player.sub_job == "COR" then include('includes/more/CorsairShot_Cards.lua') end
function extra.set_drain_samba() -- returs the highest lvl Drain Samba you can use
    local abilitys = res.job_abilities
    if player.main_job == "DNC" then
        if player.tp >= 400 and player.main_job_level >= 65 then return abilitys[186][gearswap.language]
        elseif player.tp >= 250 and player.main_job_level >= 35 then return abilitys[185][gearswap.language]
        elseif player.tp >= 100 and player.main_job_level >= 5 then return abilitys[184][gearswap.language]
        else return false
        end
    elseif player.sub_job == "DNC" then
        if player.tp >= 250 and player.sub_job_level >= 35 then return abilitys[185][gearswap.language]
        elseif player.tp >= 100 and player.sub_job_level >= 5 then return abilitys[184][gearswap.language]
        else return false
        end
    end
end
function extra.select_waltz() -- returns the mose usable Waltz for use on your player
    local potency = 0
    local waltz_pot = {["Dancer's Casaque"]=10,["Dnc. Casaque +1"]=10,["Roundel Earring"]=5,["Etoile Tiara"]=5,["Etoile Tiara +1"]=5,["Etoile Tiara +2"]=7,
            ["Phurba"]=10,["Valseur's Ring"]=3,["Kheper Bonnet"]=5,["Khepri Bonnet"]=8,["Toetapper Mantle"]=5,["Asklepian Ring"]=3,["Maxixi Casaque"]=20,
            ["Maxixi Casaque +1"]=21,["Maxixi Shoes"]=10,["Maxixi Shoes +1"]=10,["Blitto Needle"]=3,["Slither Gloves +1"]=5,["Horos Tiara"]=9,["Horos Tiara +1"]=11,
            ["Rhadamanthus"]=7}
    if sets["Curing Waltz"] then
        for i,v in pairs(waltz_pot) do
            for i2,v2 in pairs(sets["Curing Waltz"]) do
                local gear = res.items:with('name', i)
                if type(v2) == "table" then
                    if v2.name == gear[gearswap.language] then
                        potency = potency + v
                    end
                else
                    if v2 == gear[gearswap.language] then
                        potency = potency + v
                    end
                end
                if potency > 30 then
                    potency = 30
                end
            end
        end
    end
    local add_perc = function(num,per) return (((num/100)*per)+num) end
    local hp_dif = player.max_hp - player.hp
    local abilitys = res.job_abilities
    if player.main_job == "DNC" then
        if add_perc(math.floor(((waltz_stats.vit + waltz_stats.chr)*0.250)+60),potency) >= hp_dif and player.tp >= 200 and player.main_job_level >= 15 then
            return abilitys[190][gearswap.language]
        elseif add_perc(math.floor(((waltz_stats.vit + waltz_stats.chr)*0.500)+130),potency) >= hp_dif and player.tp >= 350 and player.main_job_level >= 30 then
            return abilitys[191][gearswap.language]
        elseif add_perc(math.floor(((waltz_stats.vit + waltz_stats.chr)*0.750)+270),potency) >= hp_dif and player.tp >= 500 and player.main_job_level >= 45 then
            return abilitys[192][gearswap.language]
        elseif add_perc(math.floor(((waltz_stats.vit + waltz_stats.chr)*1.000)+450),potency) >= hp_dif and player.tp >= 650 and player.main_job_level >= 70 then
            return abilitys[193][gearswap.language]
        elseif player.tp >= 800 and player.main_job_level >= 80 then
            return abilitys[311][gearswap.language]
        elseif player.hpp < 60 then
            if player.tp >= 800 and player.main_job_level >= 80 then
                return abilitys[311][gearswap.language]
            elseif player.tp >= 650 and player.main_job_level >= 70 then
                return abilitys[193][gearswap.language]
            elseif player.tp >= 500 and player.main_job_level >= 45 then
                return abilitys[192][gearswap.language]
            elseif player.tp >= 350 and player.main_job_level >= 30 then
                return abilitys[191][gearswap.language]
            elseif player.tp >= 200 and player.main_job_level >= 15 then
                return abilitys[190][gearswap.language]
            end
        end
    elseif player.sub_job == "DNC" then
        if add_perc(math.floor(((waltz_stats.vit + waltz_stats.chr)*0.125)+60),potency) >= hp_dif and player.tp >= 200 and player.sub_job_level >= 15 then
            return abilitys[190][gearswap.language]
        elseif add_perc(math.floor(((waltz_stats.vit + waltz_stats.chr)*0.250)+130),potency) >= hp_dif and player.tp >= 350 and player.sub_job_level >= 30 then
            return abilitys[191][gearswap.language]
        elseif player.tp >= 500 and player.sub_job_level >= 45 then
            return abilitys[192][gearswap.language]
        elseif player.hpp < 75 then
            if player.tp >= 500 and player.sub_job_level >= 45 then
                return abilitys[192][gearswap.language]
            elseif player.tp >= 350 and player.sub_job_level >= 30 then
                return abilitys[191][gearswap.language]
            elseif player.tp >= 200 and player.sub_job_level >= 15 then
                return abilitys[190][gearswap.language]
            end
        end
    end
    return false
end
function extra.filtered_action(status,current_event,spell)
    if nin_tool and nin_tool.open and spell.skill == "Ninjutsu" then
        local tool = nin_tool.open(spell)
        if tool then
            send_command('input /item "'..tool..'" <me>')
        end
        status.end_spell=true
        status.end_event=true
    end
end
function extra.precast(status,current_event,spell)
    if card and card.rule then card.rule(spell,status,current_event) end
end
function extra.buff_change(status,current_event,name,gain,buff_table)
    if Hwauto and table.contains(Waltz.debuff,name) then
        if gain and player.tp >= 200 and player.sub_job_level > 34 then
            send_command('input /ja "Healing Waltz" <me>')
        end
    end
    if name == "Reive Mark" and not gain then
        if registered_events and registered_events.clear_aggro_count then
            coroutine.schedule(registered_events.clear_aggro_count, 1.5)
            if updatedisplay then coroutine.schedule(updatedisplay, 1.5) end
        end
    end
end
function extra.self_command(status,current_event,command)
    if type(command) == 'table' then
        if command[1]:lower() == 'set' or command[1]:lower() == 's' then
            if _G[command[2]:lower()..'_types'] then
                for i,v in pairs(_G[command[2]:lower()..'_types']) do
                    if tostring(v):lower() == command[3]:lower() then
                        _G[command[2]:lower()..'_types_count'] = i
                    end
                end
            elseif command[2]:lower() == 'stepmax' then
                Stepmax = tonumber(command[3])
                add_to_chat(7,'Max step = ' ..Stepmax)
            end
        elseif command[1]:lower() == 'cycle' or command[1]:lower() == 'c' then
            if command[2]:lower() == 'stepmax' then
                Stepmax = (Stepmax % 6) + 1
                add_to_chat(7,'Max step = ' ..Stepmax)
            end
        elseif command[1]:lower() == 'toggle' or command[1]:lower() == 't' then
            if command == 'stopsteps' then
                Stopsteps = not Stopsteps
                add_to_chat(7, '----- Steps Will ' .. (Stopsteps and '' or 'Not ') .. 'Stop -----')
            end
        elseif command[1]:lower() == 'clear' then
            if command[2]:lower() == 'agrocount' and registered_events.atacking_mobs then
                if registered_events and registered_events.clear_aggro_count then
                    registered_events.clear_aggro_count()
                end
            end
        end
    else
        if command == "reload_gearswap" then
            if file_write and file_write.write then
                file_write.write()
            end
            send_command("lua reload gearswap")
        elseif command == 'tstopsteps' then
            Stopsteps = not Stopsteps
            add_to_chat(7, '----- Steps Will ' .. (Stopsteps and '' or 'Not ') .. 'Stop -----')
        elseif command == 'stepcount' then
            Stepmax = (Stepmax % 6) + 1
            add_to_chat(7,'Max step = ' ..Stepmax)
        elseif command == 'autohw' then
            Hwauto = not Hwauto
            add_to_chat(7, '----- Auto Healing Waltz Is ' .. (Hwauto and 'Enabled' or 'Disabled'))
        end
    end
end
----WS/Obi equip------------------------------------------------------------------------------------------------------------------
WS_Gear = {}
function WS_Gear.precast(status,current_event,spell)
    if spell.type == "WeaponSkill" then
        local spell_element = (type(spell.element)=='number' and res.elements[spell.element] or res.elements:with('name', spell.element))
        if player.inventory["Fotia Gorget"] or player.wardrobe["Fotia Gorget"] then
            sets.building[current_event] = set_combine(sets.building[current_event], {neck="Fotia Gorget"})
        elseif player.inventory[sets.sets.ws_neck[spell_element.en].neck] or player.wardrobe[sets.ws_neck[spell_element.en].neck] then
            sets.building[current_event] = set_combine(sets.building[current_event], sets.ws_neck[spell_element.en])
        end
        if player.inventory["Fotia Belt"] or player.wardrobe["Fotia Belt"] then
            sets.building[current_event] = set_combine(sets.building[current_event], {neck="Fotia Belt"})
        elseif player.inventory[sets.ws_belt[spell_element.en].waist] or player.wardrobe[sets.ws_belt[spell_element.en].waist] then
            sets.building[current_event] = set_combine(sets.building[current_event], sets.ws_belt[spell_element.en])
        end
        -- if player.inventory[sets.WS_types[spell.skill].head] or player.wardrobe[sets.WS_types[spell.skill].head] then
            -- sets.building[current_event] set_combine(sets.building[current_event], sets.WS_types[spell.skill])
        -- end
    end
end
WS_Gear.midcast = WS_Gear.precast
elemental_obi = {}
function elemental_obi.midcast(status,current_event,spell)
    if not Typ.abilitys:contains(spell.prefix) and spell.action_type ~= "Item" then
        local spell_element = (type(spell.element)=='number' and res.elements[spell.element] or res.elements:with('name', spell.element))
        if spell_element.name == world.weather_element or spell_element.name == world.day_element then
            if player.inventory["Hachirin-no-Obi"] or player.wardrobe["Hachirin-no-Obi"] then
                sets.building[current_event] = set_combine(sets.building[current_event], {waist="Hachirin-no-Obi"})
            elseif player.inventory[sets.spell_obi[spell_element.en].waist] or player.wardrobe[sets.spell_obi[spell_element.en].waist] then
                sets.building[current_event] = set_combine(sets.building[current_event], sets.spell_obi[spell_element.en])
            end
        end
    end
end
function aggro_count(name)
    if registered_events and registered_events.attacker_count then
        return registered_events.attacker_count(name)
    else
        return 0
    end
end
--string to table function--------------------------------------------------------------------------------------------------------
function string_to_table(s)
    local str = s
    local f = (str:match('%(%)') or str:match("%('(.+)'%)") or nil)
    if f then
        str = (f == '()' and string.gsub(str, '%(%)', "") or string.gsub(str, "%('"..f.."'%)", ""))
    end
    local t = {0}
    local tbl = string.find(str,'%.')
    while tbl do
        t[#t+1]=tbl
        tbl = string.find(str,'%.',tbl+1)
    end
    t[#t+1]=#str+1
    local g = _G
    for i = 1,#t-1 do
        g = g[string.sub(str,t[i]+1,t[i+1]-1)]
    end
    if f then
        if f == '()' then
            return g()
        else
            return g(f)
        end
    else
        return g
    end
end
--has buff function---------------------------------------------------------------------------------------------------------------
function has_any_buff_of(buff_set) for i,v in pairs(buff_set) do if buffactive[v] ~= nil then return true end end end