--White Mage Cure Potency Claculator
WHM = {}
function WHM.cure_pot(s)--returns sets potency +%, received potency +%, cast time -%
    local potency = 100
    local received_pot = 100
    local rapture_potency = 50
    local cast_time_reduction = 100
    local received_cure_potency = {["Adamas"]=15,["アダマス"]=15,["Buremte Gloves"]=13,["ブレムテグローブ"]=13,["Medicor Sword"]=10,["メディコルカソード"]=10,
                                   ["Sanus Ensis"]=10,["サヌスエンシス"]=10,["Shabti Armet +1"]=8,["ＳＨアーメット+1"]=8,["Shabti Armet"]=7,["シャブテアーメット"]=7,
                                   ["Oneiros Earring"]=5,["オネイロスピアス"]=5,["Chuq'aba Belt"]=5,["チュカバベルト"]=5,["Kunaji Ring"]=5,["クナジリング"]=5,
                                   ["Phalaina Locket"]=4,["ファライナロケット"]=4,["Asklepian Ring"]=3,["アスクレピアリング"]=3,["Shedir Manteel"]=3,["シェダルマンティル"]=3,
                                   ["Corybant Pearl"]=(world.zone_id == 183 and 10 or 0),["コリバントパール"]=(world.zone_id == 183 and 10 or 0),}
    local cure_cast_time_reduction = {["Cure Clogs"]=15,["ケアルクロッグ"]=15,["Nabu's Shalwar"]=15,["ナブーシャルワ"]=15,["Heka's Kalasiris"]=15,["ヘカカラシリス"]=15,
                                      ["Apaisante +1"]=13,["アペザント+1"]=13,["Piety Cap +1"]=13,["ＰＩキャップ+1"]=13,["Nefer Kalasiris +1"]=12,["ネフェカラシリス+1"]=12,
                                      ["Piety Cap"]=12,["パエティキャップ"]=12,["Aceso's Choker +1"]=13,["アケソチョーカー+1"]=13,["Aceso's Choker"]=10,["アケソチョーカー"]=10,
                                      ["Apaisante"]=10,["アペザント"]=10,["Clr. Cap +2"]=10,["ＣＲキャップ+2"]=10,["Litany Clogs"]=10,["リタニークロッグ"]=10,
                                      ["Nefer Kalasiris"]=10,["ネフェカラシリス"]=10,["Pahtli Cape"]=8,["パートリケープ"]=8,["Nathushne +1"]=7,["ナトフシュネ+1"]=7,
                                      ["Nathushne"]=6,["ナトフシュネ"]=6,["Medala Cape"]=5,["メダーラケープ"]=5,["Sors Shield"]=5,["ソーズシールド"]=5,
                                      ["Theo. Cap +1"]=5,["ＴＥキャップ+1"]=5,["Theophany Cap"]=4,["セオフニキャップ"]=4,["Praeco Slacks"]=3,["プラエコパンツ"]=3,
                                      ["Dominie's Grip"]=2,["ドミニエズグリップ"]=2,["Capricornian Rope"]=(allied_tags and 15 or 1),["カプリコンロープ"]=(allied_tags and 15 or 1),}
    local cure_potency = {["Arciela's Grace +1"]=(Reive_mark and 25 or 0),["グレースカラー+1"]=(Reive_mark and 25 or 0),["Tamaxchi"]=22,["タマシチ"]=22,
                          ["Nathushne +1"]=15,["ナトフシュネ+1"]=15,["Heka's Kalasiris"]=15,["ヘカカラシリス"]=15,["Tefnut Wand"]=15,["テフヌトステッキ"]=15,
                          ["Nathushne"]=14,["ナトフシュネ"]=14,["Bokwus Gloves"]=13,["ボクワスグローブ"]=13,["Sanus Ensis"]=13,["サヌスエンシス"]=13,
                          ["Aristocrat's Coat"]=12,["アリストチュニック"]=12,["Nefer Kalasiris +1"]=12,["ネフェカラシリス+1"]=12,["Iaso Mitra"]=11,["イアソミトラ"]=11,
                          ["Marduk's Tiara +1"]=11,["ＭＫティアラ+1"]=11,["Galenus"]=10,["ガレーヌス"]=10,["Gende. Caubeen"]=10,["ゲンデサカウビーン"]=10,
                          ["Gende. Caubeen +1"]=10,["ＧＥカウビーン+1"]=10,["Piety Duckbills +1"]=10,["ＰＩダックビル+1"]=10,["Theophany Cap"]=10,["セオフニキャップ"]=10,
                          ["Theo. Cap +1"]=10,["ＴＥキャップ+1"]=10,["Orison Cap +2"]=10,["ＯＲキャップ+2"]=10,["Healing Staff"]=10,["癒しの杖"]=10,
                          ["Dryad Staff"]=10,["霊木の杖"]=10,["Light Staff"]=10,["ライトスタッフ"]=10,["Apollo's Staff"]=10,["アポロスタッフ"]=10,
                          ["Atrophy Tights +1"]=10,["ＡＴタイツ+1"]=10,["Iridal Staff"]=10,["イリダルスタッフ"]=10,["Chatoyant Staff"]=10,["チャトヤンスタッフ"]=10,
                          ["Templar Mace"]=10,["テンプラーメイス"]=10,["Nefer Kalasiris"]=10,["ネフェカラシリス"]=10,["Noble's Tunic"]=10,["ノーブルチュニック"]=10,
                          ["Medicine Ring"]=((hpp <75 and tp < 100) and 10 or 0),["メディシンリング"]=((hpp <75 and tp < 100) and 10 or 0),
                          ["Atrophy Tights"]=9,["アトロピタイツ"]=9,["Gendewitha Bliaut"]=8,["ゲンデサブリオー"]=8,["Gende. Bilaut +1"]=8,["ＧＥブリオー+1"]=8,
                          ["Paean Mitra"]=8,["パエアンミトラ"]=8,["Piety Duckbills"]=8,["パエティダックビル"]=8,["Weather. Cuffs"]=8,["ウェーザーカフス"]=8,
                          ["Weath. Cuffs +1"]=9,["ウェーザーカフス+1"]=9,["Orison Cap +1"]=7,["ＯＲキャップ+1"]=7,["Nares Trews"]=7,["ナレストルーズ"]=7,
                          ["Theo. Briault +1"]=7,["ＴＥブリオー+1"]=7,["Ceres' Spica"]=6,["ケレーススピカ"]=6,["Chelona Blazer +1"]=6,["ケロナブレザ+1"]=6,
                          ["Ghostfyre Cape"]=6,["ゴストファイケープ"]=6,["Theo. Briault"]=6,["セオフニブリオー"]=6,["Chelona Blazer"]=5,["ケロナブレザ"]=5,
                          ["Hieros Mittens"]=5,["ヒエロスミトン"]=5,["Asklepios"]=5,["アスクレピオス"]=5,["Hospitaler Earring"]=5,["ホスピタラーピアス"]=5,
                          ["Roundel Earring"]=5,["ラウンデルピアス"]=5,["Tethyan Trews +3"]=5,["テチアントルーズ+3"]=5,["Dagda's Shield"]=5,["ダグダシールド"]=5,
                          ["Volunteer's Khud"]=(Besieged and 5 or 0),["ボランティアクード"]=(Besieged and 5 or 0),["Augur's Gloves"]=4,["アウグルグローブ"]=4,
                          ["Praeco Slacks"]=4,["プラエコパンツ"]=4,["Oretania's Cape"]=4,["オレタニアケープ"]=4,["Tempered Cape"]=4,["テンパードケープ"]=4,
                          ["Iaso Boots"]=4,["イアソブーツ"]=4,["Litany Clogs"]=4,["リタニークロッグ"]=4,["Phalaina Locket"]=4,["ファライナロケット"]=4,
                          ["Magavan Slops"]=4,["マガバンスロップス"]=4,["Orison Cape"]=3,["オリゾンケープ"]=3,["Fylgja Torque +1"]=3,["フィルギャトルク+1"]=3,
                          ["Sors Shield"]=3,["ソーズシールド"]=3,["Tethyan Trews +2"]=3,["テチアントルーズ+2"]=3,["Melampus Staff"]=3,["メラムプススタッフ"]=3,
                          ["Restorer Cloak"]=3,["レストアクローク"]=3,["Fierabras's Mantle"]=2,["フィエラブラマント"]=2,["Medala Cape"]=2,["メダーラケープ"]=2,
                          ["Fylgja Torque"]=2,["フィルギャトルク"]=2,["Fylgja Torque +1"]=2,["フィルギャトルク+1"]=2,["Orison Earring"]=2,["オリゾンピアス"]=2,
                          ["Paean Boots"]=1,["パエアンブーツ"]=1,["Dia Wand"]=1,["ディアワンド"]=1,
                          ["Lambda Sash"]=(S{73,74,75,76}:contains(world.zone_id) and 3 or 0),["ラムダサッシュ"]=(S{73,74,75,76}:contains(world.zone_id) and 3 or 0),}
    local rapture_potency_plus = {["Svnt. Bonnet +2"]=10,["ＳＶボネット+2"]=10,["Svnt. Bonnet +1"]=5,["ＳＶボネット+1"]=5,["Arbatel Bonnet"]=15,["アバテルボネット"]=15,
                                  ["Arbatel Bonnet +1"]=15,["ＡＢボネット+1"]=15,}
    for _,v in pairs(s) do
        if type(v) == 'table' then
            potency = potency + (cure_potency[v2.name] or 0)
            received_pot = received_pot + (received_cure_potency[v2.name] or 0)
            cast_time_reduction = cast_time_reduction - (cure_cast_time_reduction[v2.name] or 0)
            rapture_potency = rapture_potency + (rapture_potency_plus[v] or 0)
            for _,v in ipairs(v2.augments) do
                potency = potency + tonumber(v:startswith('"Cure" potency') and string.match(v, '%d+') or '0')
                received_pot = received_pot + tonumber(v:startswith('Potency of "Cure" effect received') and string.match(v, '%d+') or '0')
                cast_time_reduction = cast_time_reduction - tonumber(v:startswith('"Cure" spellcasting time -') and string.match(v, '%d+') or '0')
            end
        else
            potency = potency + (cure_potency[v2.name] or 0)
            received_pot = received_pot + (received_cure_potency[v2.name] or 0)
            cast_time_reduction = cast_time_reduction - (cure_cast_time_reduction[v2.name] or 0)
            rapture_potency = rapture_potency + (rapture_potency_plus[v] or 0)
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
        local power = math.floor((Player['MND']+Player['MND+'])/2)+math.floor((Player['VIT']+Player['VIT+'])/4)+reg_event.skill['Healing Magic Level']
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