--Spell control
----Check spell rules-------------------------------------------------------------------------------------------------------------
  --check_recast('ability',spell.recast_id)  check_recast('spell',spell.recast_id)
function check_recast(typ,id) --if spell can be cast(not in recast) return true
    local recasts = windower.ffxi['get_'..typ..'_recasts']()
    if id and recasts[id] and recasts[id] == 0 then
        return true
    else
        return false
    end
end
function spell_stopper(spell) --return true if spell is unable to be cast at this time
    --Stops spell if your in mog house
    if world.in_mog_house or world.mog_house then
        return true
    elseif spell.type == "Item" then
        return false
    elseif istratre and spell.recast_id == 231 then
        return false
    --Stops spell if pet_midaction/midaction are enabled
    elseif (Watch_pet_midaction and pet_midaction() or false) or (Watch_midaction and midaction() or false) then
        return true
    --Stops spell if you do not have a target
    elseif spell.target.name == nil and not spell.target.raw:contains("st") then
        return true
    --Stops spell if a blocking buff is active
    elseif spell.action_type == 'Ability' and spell.type ~= 'WeaponSkill' and (has_any_buff_of(unusable_buff.ability) 
      or not check_recast('ability',spell.recast_id)) then
        return true
    elseif spell.action_type == 'Magic' and (has_any_buff_of(unusable_buff.spell) or not check_recast('spell',spell.recast_id)) then
        return true
    --Stops spell if you do not have enuf mp/tp to use
    elseif spell.tp_cost and spell.tp_cost > player.tp then
        return true
    elseif spell.mp_cost and spell.mp_cost > player.mp and not has_any_buff_of({'Manawell','Manafont'}) then
        return true
    elseif player.tp < 1000 and spell.type == 'WeaponSkill' then
        return true
    --Stops all spells but teleport spells in cities
    elseif tsstown and not transportation_spells:contains(spell.en) and cities:contains(world.area) then
        return true
    --Stops Trust spells from being cast if you already have the same trust active
    elseif spell.type == "Trust" and party.count > 1 then
        if player.in_combat then
            return true
        end
        if check_in_party(string.mgsub(spell.en, "II|%[S%]|%(UC%)|%s+", "")) then
            return true
        end
    end
    --Calculate how many finishin moves your char has up to 6
    local fm_count = 0
    for i, v in pairs(buffactive) do
        if tostring(i):startswith('finishing move') or tostring(i):startswith('フィニシングムーブ') then
            fm_count = tonumber(string.match(i, '%d+')) or 1
        end
    end
    --Stops flourishes if you do not have enuf finishin moves
    if min_fm_for_flourishes[spell.en] then
        if min_fm_for_flourishes[spell.en] > fm_count and not buffactive[507] then
            return true
        end
    end
    --Stops steps if you have = or more finishin moves then you want (based on settings)
    if spell.type == 'Step' then
        if Stopsteps then
            if fm_count >= Stepmax then
                return true
            end
        end
    end
    --Reomves Sneak when casting Spectral Jig
    if spell.en == 'Spectral Jig' then
        send_command('cancel 71')
    end
end
function spell_range_check(spell) --if target distance is greater then spells max distance return true (still not enabled)
    --[[local range_mult = {[0] = 0,[1] = 1.642276421172564,[2] = 1.642276421172564,[3] = 1.642276421172564,[4] = 1.642276421172564,[5] = 1.642276421172564,
    [6] = 1.642276421172564,[7] = 1.642276421172564,[8] = 1.642276421172564,[9] = 1.642276421172564,[10] = 1.642276421172564,[11] = 1.642276421172564,
    [12] = 1.642276421172564,}]]
    local range_mult = {[0]=0,[2]=1.70,[3]=1.490909,[4]=1.44,[5]=1.377778,[6]=1.30,[7]=1.20,[8]=1.30,[9]=1.377778,[10]=1.45,[11]=1.490909,[12]=1.70,}
    local spell_max_distance = (spell.target.model_size + spell.range * range_mult[spell.range]) --spell.target.model_size + spell.range * range_mult[spell.range]
    if spell_max_distance < spell.target.distance then
        --print("Target out of "..spell.name.."'s max range of "..spell_max_distance)
        return true
    end
end
function gearchang_stopper(spell)--returs true if a spell will be blocked by a buff
    if spell and spell.action_type == "Ability" and has_any_buff_of(unusable_buff.ability) then
        return true
    elseif spell and spell.action_type == "Magic" and has_any_buff_of(unusable_buff.spell) then
        return true
    end
    if ((S{"pet_midcast","pet_aftercast"}:contains(_global.current_event) and false or Watch_pet_midaction) and pet_midaction() or false) 
      or ((S{"midcast","aftercast"}:contains(_global.current_event) and false or Watch_midaction) and midaction() or false) then
        return true
    end
end