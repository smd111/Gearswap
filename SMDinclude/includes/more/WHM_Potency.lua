--White Mage Cure Potency Claculator
WHM = {}
function WHM.cure_pot(s)--returns sets potency +%, received potency +%, cast time -%
    local potency = 100
    local received_pot = 100
    local rapture_potency = 50
    local cast_time_reduction = 100
    local rapture_potency_plus = {["Svnt. Bonnet +2"]=10,["ＳＶボネット+2"]=10,["Svnt. Bonnet +1"]=5,["ＳＶボネット+1"]=5,["Arbatel Bonnet"]=15,["アバテルボネット"]=15,
                                  ["Arbatel Bonnet +1"]=15,["ＡＢボネット+1"]=15,}
    for _,v in pairs(s) do
        local lookup = get_item_extdata(v2.name)
        if lookup.augments then
            for _,str in pairs(lookup.augments) do
                potency = potency + (tonumber(str:match('"Cure" potency (.%d+)%%')) or 0)
                potency = potency + (tonumber(str:match('Potency of "Cure" effect received (.%d+)%%')) or 0)
                cast_time_reduction = cast_time_reduction + (tonumber(str:match('"Cure" spellcasting time (.%d+)%%')) or 0)
            end
        end
        if rapture_potency_plus[v2.name] then
            rapture_potency = rapture_potency + rapture_potency_plus[name]
        end
    end
    if potency > 150 then
        potency = 150
    end
    return s,(Rapture and rapture_potency or 0)+potency,received_pot,cast_time_reduction
end
function WHM.select_cure(pot,rec_pot,target)
    local potency = pot + (Divine_seal and 100 or 0)
    local rec_potency = rec_pot
    local w_potency = 100
    if world.day == 'Lightsday' or world.day == "光" then
        w_potency = w_potency + 10
    elseif world.day == 'Darksday' or world.day == "闇" then
        w_potency = w_potency - 10
    end
    if world.weather_element == 'Light' or world.weather_element == '光' then
        w_potency = w_potency + (world.weather_id == 16 and 10 or 25)
    elseif world.weather_element == 'Dark' or world.weather_element == '闇' then
        w_potency = w_potency + (world.weather_id == 18 and 10 or 25)
    end
    local get_base_hp = function(name)
        local power = math.floor(player.mnd/2) + math.floor(player.vit/4) + player.skills.healing_magic
        local cure_map = {['Cure'] = {[0]={rate=1,hp=10},[20]={rate=1.33,hp=15},[40]={rate=8.5,hp=30},[125]={rate=15,hp=40},[200]={rate=20,hp=45},
                                      [600]={rate=1,hp=65,cap=65}},
                          ['Cure II'] = {[40]={rate=1,hp=60},[70]={rate=5.5,hp=90},[125]={rate=7.5,hp=100},[200]={rate=10,hp=110},[400]={rate=20,hp=130},
                                         [700]={rate=1,hp=145,cap=145}},
                          ['Cure III'] = {[70]={rate=2.2,hp=130},[125]={rate=1.15,hp=155},[200]={rate=2.5,hp=220},[300]={rate=5,hp=260},[700]={rate=1,hp=340,cap=340}},
                          ['Cure IV'] = {[70]={rate=1,hp=270},[200]={rate=2,hp=400},[300]={rate=1.43,hp=450},[400]={rate=2.5,hp=520},[700]={rate=1,hp=640,cap=640}},
                          ['Cure V'] = {[80]={rate=0.7,hp=450},[150]={rate=1.25,hp=550},[190]={rate=1.84,hp=582},[260]={rate=2,hp=620},[300]={rate=2.5,hp=640},
                                        [500]={rate=3.33,hp=720},[700]={rate=1,hp=780,cap=780}},
                          ['Cure VI'] = {[90]={rate=1.5,hp=600},[210]={rate=0.9,hp=680},[300]={rate=1.43,hp=780},[400]={rate=2.5,hp=850},[500]={rate=1.67,hp=890},
                                         [700]={rate=1,hp=1010,cap=1010}},}
        local p_floor
        local cure_tbl
        for i,v in pairs(cure_map[name]) do
            if i <= power then
                p_floor = i
                cure_tbl = v
            end
        end
        local cure
        local base = floor((power-p_floor)/cure_tbl.rate)+cure_tbl.hp
        if cure_tbl.cap and cure_tbl.cap <= base then
            cure = cure_tbl.cap
        else
            cure = base
        end
        return cure
    end
    local hp_dif = (player.max_hp - player.hp)
    local s_cure
    local hp = 0
    local spellt = {}
    local cure_spells = {1,2,3,4,5,6}
    for _,v in pairs(cure_spells) do
        local spell = gearswap.res.spells[v]
        local hHP = get_base_hp(spell.en)
        local mjob = player.main_job_id
        local sjob = player.sub_job_id
        if spell.levels[mjob] then
            if spell.mp_cost <= player.mp and spell.levels[mjob] <= player.main_job_level then
                spellt[spell[gearswap.language]] = hHP
            elseif spell.mp_cost <= player.mp and spell.levels[sjob] <= player.main_job_level then
                spellt[spell[gearswap.language]] = hHP
            end
        elseif spell.levels[sjob] then
            if healed_hp_final >= hp_dif and spell.mp_cost <= player.mp and spell.levels[sjob] >= player.sub_job_level then
                spellt[spell[gearswap.language]] = hHP
            elseif spell.mp_cost <= player.mp and spell.levels[sjob] >= player.sub_job_level then
                spellt[spell[gearswap.language]] = hHP
            end
        end
    end
    for i,v in pairs(spellt) do
        local hHP = (v*(potency/100))*(w_potency/100)
        if target == 'SELF' then
            hHP = (hHP*(rec_potency/100))
        end
        if hHP >= hp_dif then
            return i
        elseif hHP > hp then
            hp = hHP
            s_cure = i
        end
    end
    return s_cure
end
--my code used to get the correct healing of Cure spells not cureaga
    -- if S{"Cure","Cure II","Cure III","Cure IV","Cure V","Cure VI"}:contains(spell.en) then
        -- local set,potency,received_pot,cast_time_reduction = WHM.cure_pot(set_combine(cure_gear[lang[gearswap.language]], sets.cure))
        -- local new_cure = WHM.select_cure(potency,received_pot,spell.target.type)
        -- if new_cure and spell.en ~= new_cure then
            -- send_command('input /ma "'..new_cure..'" '..spell.target.raw)
            -- status.end_event=true
            -- status.end_spell=true
        -- end
        -- sets.building[event] = set_combine(sets.building[event], set)