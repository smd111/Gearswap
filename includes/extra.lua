Hwauto = false
Contradance_potency = 0
allied_tags = false
Rapture = false
Divine_seal = false
Reive_mark = false
Besieged = false
s_waltz_h_a = true
extdata = require("extdata")
----Check spell rules-------------------------------------------------------------------------------------------------------------
  --check_recast('ability',spell.recast_id)  check_recast('spell',spell.recast_id)
function check_recast(typ,id) local recasts = windower.ffxi['get_'..typ..'_recasts']() if id and recasts[id] and recasts[id] == 0 then return true else return false end end
function spell_stopper(spell)
    if world.in_mog_house or world.mog_house then return true end
    if (Watch_pet_midaction and pet_midaction() or false) or (Watch_midaction and midaction() or false) then     return true end
    if spell.target.name == nil then return true end
    -- if not S{"Ranged Attack","Item"}:contains(spell.action_type) and spell_range_check(spell) then return true end
    if spell.action_type == 'Ability' and spell.type ~= 'WeaponSkill' and (has_any_buff_of(unusable_buff.ability) or not check_recast('ability',spell.recast_id)) then return true end
    if spell.action_type == 'Magic' and (has_any_buff_of(unusable_buff.spell) or not check_recast('spell',spell.recast_id)) then return true end
    if spell.tp_cost and spell.tp_cost > player.tp then return true end
    if spell.mp_cost and spell.mp_cost > player.mp and not has_any_buff_of({'Manawell','Manafont'}) then return true end
    if player.tp < 1000 and spell.type == 'WeaponSkill' then return true end
    if spell.type == "Trust" and party.count > 1 then if player.in_combat then return true end for pt_num,pt in ipairs(alliance) do for pos,party_position in ipairs(pt) do if party_position.name == string.gsub(spell.en, "%s+", "") then return true end end end end
    if spell.en == 'Spectral Jig' then send_command('cancel 71') end
    if not transportation_spells:contains(spell.en) and cities:contains(world.area) then return true end
    local fm_count = 0 for i, v in pairs(buffactive) do if tostring(i):startswith('finishing move') or tostring(i):startswith('フィニシングムーブ') then fm_count = tonumber(string.match(i, '%d+')) or 1 end end
    if min_fm_for_flourishes[spell.en] then if min_fm_for_flourishes[spell.en] > fm_count and not buffactive[507] then return true end end
    if spell.type == 'Step' then if Stopsteps then if fm_count >= Stepmax then return true end end end
end
function spell_range_check(spell)
    -- local range_mult = {[0] = 0,[1] = 1.642276421172564,[2] = 1.642276421172564,[3] = 1.642276421172564,[4] = 1.642276421172564,[5] = 1.642276421172564,[6] = 1.642276421172564,[7] = 1.642276421172564,[8] = 1.642276421172564,[9] = 1.642276421172564,[10] = 1.642276421172564,[11] = 1.642276421172564,[12] = 1.642276421172564,}
    local range_mult = {[0]=0,[2]=1.70,[3]=1.490909,[4]=1.44,[5]=1.377778,[6]=1.30,[7]=1.20,[8]=1.30,[9]=1.377778,[10]=1.45,[11]=1.490909,[12]=1.70,}
    local spell_max_distance = (spell.target.model_size + spell.range * range_mult[spell.range]) --spell.target.model_size + spell.range * range_mult[spell.range]
    if spell_max_distance < spell.target.distance then add_to_chat(7,"Target out of "..spell.name.."'s max range of "..spell_max_distance) return true end
end
function gearchang_stopper(spell)
    if spell and spell.action_type == "Ability" and has_any_buff_of(unusable_buff.ability) then return true
    elseif spell and spell.action_type == "Magic" and has_any_buff_of(unusable_buff.spell) then return true
    end
    if (Watch_pet_midaction and pet_midaction() or false) or (Watch_midaction and midaction() or false) then return true end
end
--extra functions-----------------------------------------------------------------------------------------------------------------
extra = {}
if player.main_job == "NIN" or player.sub_job == "NIN" then include('includes/more/Ninja_Tool.lua') end
if player.main_job == "COR" or player.sub_job == "COR" then include('includes/more/CorsairShot_Cards.lua') end
if player.main_job == "DNC" or player.sub_job == "DNC" then
    function extra.set_drain_samba() -- returns the highest lvl Drain Samba you can use
        local abilitys = res.job_abilities local dnc_type
        if player.main_job == "DNC" then dnc_type = 'main_job' elseif player.sub_job == "DNC" then dnc_type = 'sub_job' end
        if player.tp >= 400 and player[dnc_type..'_level'] >= 65 then return abilitys[186][gearswap.language]
        elseif player.tp >= 250 and player[dnc_type..'_level'] >= 35 then return abilitys[185][gearswap.language]
        elseif player.tp >= 100 and player[dnc_type..'_level'] >= 5 then return abilitys[184][gearswap.language]
        end
    end
    function waltz_potency(s)
        local potency = 100
        local tpreduction = 0
        local received_pot = 100
        local waltz_pot = {["Sonia's Plectrum"]=(allied_tags and 10 or 1),["ソニアプレクトラム"]=(allied_tags and 10 or 1),["Dnc. Casaque +1"]=10,["ＤＲカザク+1"]=10,
        ["Dancer's Casaque"]=10,["ダンサーカザク"]=10,["Roundel Earring"]=5,["ラウンデルピアス"]=5,["Etoile Tiara"]=5,["エトワールティアラ"]=5,["Etoile Tiara +1"]=5,["ＥＴティアラ+1"]=5,
        ["Etoile Tiara +2"]=7,["ＥＴティアラ+2"]=7,["Phurba"]=10,["フルバー"]=10,["Valseur's Ring"]=3,["ヴァルスールリング"]=3,["Kheper Bonnet"]=5,["ケペルボンネット"]=5,
        ["Khepri Bonnet"]=8,["ケプリボンネット"]=8,["Toetapper Mantle"]=5,["トータッパーマント"]=5,["Asklepian Ring"]=3,["アスクレピアリング"]=3,["Maxixi Casaque"]=20,["マシシカザク"]=20,
        ["Maxixi Casaque +1"]=21,["ＭＸカザク+1"]=21,["Maxixi Shoes"]=10,["マシシトーシュー"]=10,["Maxixi Shoes +1"]=10,["ＭＸトーシュー+1"]=10,["Blitto Needle"]=3,["ブリットニードル"]=3,
        ["Slither Gloves +1"]=5,["スリザーグローブ+1"]=5,["Horos Tiara"]=9,["ホロスティアラ"]=9,["Horos Tiara +1"]=11,["ＨＯティアラ+1"]=11,["Rhadamanthus"]=7,["ラダマントゥス"]=7,}
        local waltz_received_pot = {["Maxixi Casaque"]=5,["マシシカザク"]=5,["Maxixi Casaque +1"]=6,["ＭＸカザク+1"]=6,["Asklepian Ring"]=3,["アスクレピアリング"]=3,}
        for _,v2 in pairs(s) do
            if type(v2) == "table" then
                potency = potency + (waltz_pot[v2.name] or 0)
                received_pot = received_pot + (waltz_received_pot[v2.name] or 0)
                for _,v in ipairs(v2.augments) do
                    potency = potency + tonumber(v:startswith('"Waltz" potency') and string.match(v, '%d+') or '0')
                    tpreduction = tpreduction + tonumber(v:startswith('"Waltz" TP cost') and string.match(v, '%d+') or '0')
                end
            else
                potency = potency + (waltz_pot[v2] or 0)
                received_pot = received_pot + (waltz_received_pot[v2] or 0)
            end
        end
        if potency > 130 then
            potency = 130
        end
        return s,potency,received_pot,tpreduction
    end
    function select_waltz(bpotency,received_pot,tpreduction) -- returns the most usable Waltz for use on your player
        local potency = (bpotency  + (player.main_job == "DNC" and (player.job_points.dnc.waltz_potency*2) or 0) + Contradance_potency)
        local hp_dif = (player.max_hp - player.hp)
        local abilitys = res.job_abilities
        local base = (Player['VIT'] + Player['VIT+']) + (Player['CHR'] + Player['CHR+'])
        local dnc_type
        local h_waltz
        local h_hp
        if hp_dif == 0 then
            return nil,0
        end
        local waltz = {main_job={[1]=0.250,[2]=0.500,[3]=0.750,[4]=1.000,[5]=1.25,},
                       sub_job={[1]=0.125,[2]=0.250,[3]=0.375,},
                       default={[1]={c=60,tp=200,lvl=15,id=190},[2]={c=130,tp=350,lvl=30,id=191},[3]={c=270,tp=500,lvl=45,id=192},[4]={c=450,tp=650,lvl=75,id=193},
                                [5]={c=600,tp=800,lvl=80,id=311},},}
        if player.main_job == "DNC" then
            dnc_type = 'main_job'
        elseif player.sub_job == "DNC" then
            dnc_type = 'sub_job'
        end
        for i,v in ipairs(waltz.default) do
            if player[dnc_type..'_level'] >= v.lvl then
                local hHP=math.floor((((base*waltz[dnc_type][i])+v.c)*(potency/100))*(received_pot/100))
                local hTP=(v.tp-tpreduction)
                if hHP >= hp_dif and player.tp >= hTP then
                    return abilitys[v.id][gearswap.language]
                elseif player.tp >= hTP then
                    h_waltz = v.id
                end
            end
        end
        if h_waltz then
            return abilitys[h_waltz][gearswap.language]
        end
    end
end
function extra.filtered_action(status,event,spell)
    if nin_tool and nin_tool.open and spell.skill == "Ninjutsu" then local tool = nin_tool.open(spell) if tool then send_command('input /item "'..tool..'" <me>') end status.end_spell=true status.end_event=true end
end
if player.main_job == "WHM" or player.sub_job == "WHM" then
    function cure_pot(s)--returns sets potency +%, received potency +%, cast time -%
        local potency = 100
        local received_pot = 100
        local rapture_potency = 50
        local cast_time_reduction = 100
        local received_cure_potency = {["Adamas"]=15,["アダマス"]=15,["Buremte Gloves"]=13,["ブレムテグローブ"]=13,["Medicor Sword"]=10,["メディコルカソード"]=10,["Sanus Ensis"]=10,
        ["サヌスエンシス"]=10,["Shabti Armet +1"]=8,["ＳＨアーメット+1"]=8,["Shabti Armet"]=7,["シャブテアーメット"]=7,["Oneiros Earring"]=5,["オネイロスピアス"]=5,["Chuq'aba Belt"]=5,
        ["チュカバベルト"]=5,["Kunaji Ring"]=5,["クナジリング"]=5,["Phalaina Locket"]=4,["ファライナロケット"]=4,["Asklepian Ring"]=3,["アスクレピアリング"]=3,["Shedir Manteel"]=3,
        ["シェダルマンティル"]=3,["Corybant Pearl"]=(world.zone_id == 183 and 10 or 0),["コリバントパール"]=(world.zone_id == 183 and 10 or 0),}
        local cure_cast_time_reduction = {["Cure Clogs"]=15,["ケアルクロッグ"]=15,["Nabu's Shalwar"]=15,["ナブーシャルワ"]=15,["Heka's Kalasiris"]=15,["ヘカカラシリス"]=15,
        ["Apaisante +1"]=13,["アペザント+1"]=13,["Piety Cap +1"]=13,["ＰＩキャップ+1"]=13,["Nefer Kalasiris +1"]=12,["ネフェカラシリス+1"]=12,["Piety Cap"]=12,["パエティキャップ"]=12,
        ["Aceso's Choker +1"]=13,["アケソチョーカー+1"]=13,["Aceso's Choker"]=10,["アケソチョーカー"]=10,["Apaisante"]=10,["アペザント"]=10,["Clr. Cap +2"]=10,["ＣＲキャップ+2"]=10,
        ["Litany Clogs"]=10,["リタニークロッグ"]=10,["Nefer Kalasiris"]=10,["ネフェカラシリス"]=10,["Pahtli Cape"]=8,["パートリケープ"]=8,["Nathushne +1"]=7,["ナトフシュネ+1"]=7,
        ["Nathushne"]=6,["ナトフシュネ"]=6,["Medala Cape"]=5,["メダーラケープ"]=5,["Sors Shield"]=5,["ソーズシールド"]=5,["Theo. Cap +1"]=5,["ＴＥキャップ+1"]=5,["Theophany Cap"]=4,
        ["セオフニキャップ"]=4,["Praeco Slacks"]=3,["プラエコパンツ"]=3,["Dominie's Grip"]=2,["ドミニエズグリップ"]=2,["Capricornian Rope"]=(allied_tags and 15 or 1),
        ["カプリコンロープ"]=(allied_tags and 15 or 1),}
        local cure_potency = {["Arciela's Grace +1"]=(Reive_mark and 25 or 0),["グレースカラー+1"]=(Reive_mark and 25 or 0),["Tamaxchi"]=22,
        ["タマシチ"]=22,["Nathushne +1"]=15,["ナトフシュネ+1"]=15,["Heka's Kalasiris"]=15,["ヘカカラシリス"]=15,["Tefnut Wand"]=15,["テフヌトステッキ"]=15,["Nathushne"]=14,["ナトフシュネ"]=14,
        ["Bokwus Gloves"]=13,["ボクワスグローブ"]=13,["Sanus Ensis"]=13,["サヌスエンシス"]=13,["Aristocrat's Coat"]=12,["アリストチュニック"]=12,["Nefer Kalasiris +1"]=12,
        ["ネフェカラシリス+1"]=12,["Iaso Mitra"]=11,["イアソミトラ"]=11,["Marduk's Tiara +1"]=11,["ＭＫティアラ+1"]=11,["Galenus"]=10,["ガレーヌス"]=10,["Gende. Caubeen"]=10,
        ["ゲンデサカウビーン"]=10,["Gende. Caubeen +1"]=10,["ＧＥカウビーン+1"]=10,["Piety Duckbills +1"]=10,["ＰＩダックビル+1"]=10,["Theophany Cap"]=10,["セオフニキャップ"]=10,
        ["Theo. Cap +1"]=10,["ＴＥキャップ+1"]=10,["Orison Cap +2"]=10,["ＯＲキャップ+2"]=10,["Healing Staff"]=10,["癒しの杖"]=10,["Dryad Staff"]=10,["霊木の杖"]=10,
        ["Light Staff"]=10,["ライトスタッフ"]=10,["Apollo's Staff"]=10,["アポロスタッフ"]=10,["Atrophy Tights +1"]=10,["ＡＴタイツ+1"]=10,["Iridal Staff"]=10,["イリダルスタッフ"]=10,
        ["Chatoyant Staff"]=10,["チャトヤンスタッフ"]=10,["Templar Mace"]=10,["テンプラーメイス"]=10,["Nefer Kalasiris"]=10,["ネフェカラシリス"]=10,["Noble's Tunic"]=10,["ノーブルチュニック"]=10,
        ["Medicine Ring"]=((hpp <75 and tp < 100) and 10 or 0),["メディシンリング"]=((hpp <75 and tp < 100) and 10 or 0),["Atrophy Tights"]=9,["アトロピタイツ"]=9,
        ["Gendewitha Bliaut"]=8,["ゲンデサブリオー"]=8,["Gende. Bilaut +1"]=8,["ＧＥブリオー+1"]=8,["Paean Mitra"]=8,["パエアンミトラ"]=8,["Piety Duckbills"]=8,["パエティダックビル"]=8,
        ["Weather. Cuffs"]=8,["ウェーザーカフス"]=8,["Weath. Cuffs +1"]=9,["ウェーザーカフス+1"]=9,["Orison Cap +1"]=7,["ＯＲキャップ+1"]=7,["Nares Trews"]=7,["ナレストルーズ"]=7,
        ["Theo. Briault +1"]=7,["ＴＥブリオー+1"]=7,["Ceres' Spica"]=6,["ケレーススピカ"]=6,["Chelona Blazer +1"]=6,["ケロナブレザ+1"]=6,["Ghostfyre Cape"]=6,["ゴストファイケープ"]=6,
        ["Theo. Briault"]=6,["セオフニブリオー"]=6,["Chelona Blazer"]=5,["ケロナブレザ"]=5,["Hieros Mittens"]=5,["ヒエロスミトン"]=5,["Asklepios"]=5,["アスクレピオス"]=5,
        ["Hospitaler Earring"]=5,["ホスピタラーピアス"]=5,["Roundel Earring"]=5,["ラウンデルピアス"]=5,["Tethyan Trews +3"]=5,["テチアントルーズ+3"]=5,["Dagda's Shield"]=5,
        ["ダグダシールド"]=5,["Volunteer's Khud"]=(Besieged and 5 or 0),["ボランティアクード"]=(Besieged and 5 or 0),["Augur's Gloves"]=4,["アウグルグローブ"]=4,
        ["Praeco Slacks"]=4,["プラエコパンツ"]=4,["Oretania's Cape"]=4,["オレタニアケープ"]=4,["Tempered Cape"]=4,["テンパードケープ"]=4,["Iaso Boots"]=4,["イアソブーツ"]=4,
        ["Litany Clogs"]=4,["リタニークロッグ"]=4,["Phalaina Locket"]=4,["ファライナロケット"]=4,["Magavan Slops"]=4,["マガバンスロップス"]=4,["Orison Cape"]=3,["オリゾンケープ"]=3,
        ["Fylgja Torque +1"]=3,["フィルギャトルク+1"]=3,["Sors Shield"]=3,["ソーズシールド"]=3,["Tethyan Trews +2"]=3,["テチアントルーズ+2"]=3,["Melampus Staff"]=3,["メラムプススタッフ"]=3,
        ["Restorer Cloak"]=3,["レストアクローク"]=3,["Fierabras's Mantle"]=2,["フィエラブラマント"]=2,["Medala Cape"]=2,["メダーラケープ"]=2,["Fylgja Torque"]=2,["Fylgja Torque +1"]=2,
        ["Orison Earring"]=2,["オリゾンピアス"]=2,["Paean Boots"]=1,["パエアンブーツ"]=1,["Dia Wand"]=1,["ディアワンド"]=1,
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
    function select_cure(pot,rec_pot,target)
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
                cure_map = {
                    ['Cure'] = {[0]={rate=1,hp=10},[20]={rate=1.33,hp=15},[40]={rate=8.5,hp=30},[125]={rate=15,hp=40},[200]={rate=20,hp=45},[600]={rate=1,hp=65,cap=65}},
                    ['Cure II'] = {[40]={rate=1,hp=60},[70]={rate=5.5,hp=90},[125]={rate=7.5,hp=100},[200]={rate=10,hp=110},[400]={rate=20,hp=130},[700]={rate=1,hp=145,cap=145}},
                    ['Cure III'] = {[70]={rate=2.2,hp=130},[125]={rate=1.15,hp=155},[200]={rate=2.5,hp=220},[300]={rate=5,hp=260},[700]={rate=1,hp=340,cap=340}},
                    ['Cure IV'] = {[70]={rate=1,hp=270},[200]={rate=2,hp=400},[300]={rate=1.43,hp=450},[400]={rate=2.5,hp=520},[700]={rate=1,hp=640,cap=640}},
                    ['Cure V'] = {[80]={rate=0.7,hp=450},[150]={rate=1.25,hp=550},[190]={rate=1.84,hp=582},[260]={rate=2,hp=620},[300]={rate=2.5,hp=640},[500]={rate=3.33,hp=720},[700]={rate=1,hp=780,cap=780}},
                    ['Cure VI'] = {[90]={rate=1.5,hp=600},[210]={rate=0.9,hp=680},[300]={rate=1.43,hp=780},[400]={rate=2.5,hp=850},[500]={rate=1.67,hp=890},[700]={rate=1,hp=1010,cap=1010}},
                    }
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
            local spell = res.spells[v]
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
end
function ws_to_aoews(spell)
    for _,v in pairs(table.reverse(windower.ffxi.get_abilities().weapon_skills)) do
        local ws = res.weapon_skills[v][gearswap.language]
        if aoe_ws:contains(ws) then
            return ws
        end
    end
    return spell.name
end
function extra.pretarget(status,event,spell)
    if spell.type == "WeaponSkill" then
        if Enable_auto_WS_aoe and aggro_count() >= 2 and not S{"Archery","Marksmanship","Throwing"}:contains(spell.skill) then
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
    if spell.type == 'Waltz' then
        if spell.target.type == "SELF" and spell.en:startswith('Curing Waltz') then
            local set,potency,received_pot,tpreduction = waltz_potency(sets["Waltz"])
            local new_waltz,h_total = select_waltz(potency,received_pot,tpreduction) 
            if new_waltz and spell.name ~= new_waltz then send_command('input /ja "'..new_waltz..'" <me>') status.end_event=true status.end_spell=true return
            elseif h_total == 0 then add_to_chat(7,'Canceling '..spell.name..' HP Loss At 0') status.end_event=true status.end_spell=true return
            else if s_waltz_h_a and not showed then add_to_chat(7,'Waltz Set To '..new_waltz) end
            end
            sets.building[event] = set_combine(sets.building[event], set)
        end
    elseif S{"Cure","Cure II","Cure III","Cure IV","Cure V","Cure VI"}:contains(spell.en) then
        local set,potency,received_pot,cast_time_reduction = waltz_potency(set_combine(cure_gear[lang[gearswap.language]], sets.cure))
        local new_cure = select_cure(potency,received_pot,spell.target.type)
        if new_cure and spell.en ~= new_cure then
            send_command('input /ma "'..new_cure..'" '..spell.target.raw)
            status.end_event=true status.end_spell=true
        end
        sets.building[event] = set_combine(sets.building[event], set)
    elseif spell.type == "Samba" and spell.en:startswith('Drain Samba') then local new_Samba = (extra.set_drain_samba() or false) if new_Samba and spell.en ~= new_Samba then send_command('input /ja "'..new_Samba..'" <me>') status.end_event=true status.end_spell=true end
    end
    if card and card.rule then card.rule(status,event,spell) end
end
function extra.buff_change(status,event,name,gain,buff_table)
    if Hwauto and table.contains(Waltz.debuff,name) then if gain and player.tp >= 200 and player.sub_job_level > 34 then send_command('input /ja "'..res.job_abilities[194][gearswap.language]..'" <me>') end
    elseif name == "Reive Mark" and not gain then if reg_event and reg_event.clear_aggro_count then coroutine.schedule(reg_event.clear_aggro_count, 1.5) if updatedisplay then coroutine.schedule(updatedisplay, 1.5) end end
    end
    if S{'Commitment','Dedication'}:contains(name) then
        if gain then enable("left_ring") equip(gear_equip(name,'buff_change'))
        else
            if auto_cap_ring then ring_time = get_item_next_use("Trizek Ring") elseif auto_xp_ring then ring_time = get_item_next_use("Echad Ring") end
        end
    end
end
function extra.self_command(status,event,com)
    if type(com) == 'table' then
        if com[1]:lower() == 'set' or com[1]:lower() == 's' then
            if _G[com[2]:lower()..'_types'] then for i,v in pairs(_G[com[2]:lower()..'_types']) do if tostring(v):lower() == com[3]:lower() then _G[com[2]:lower()..'_types_count'] = i end end
            elseif com[2]:lower() == 'stepmax' then Stepmax = tonumber(com[3]) add_to_chat(7,'Max step = '..Stepmax)
            end
        elseif com[1]:lower() == 'cycle' or com[1]:lower() == 'c' then
            if com[2]:lower() == 'stepmax' then Stepmax = (Stepmax % (player.main_job == "DNC" and 6 or 5)) + 1 add_to_chat(7,'Max step = '..Stepmax) end
        elseif com[1]:lower() == 'toggle' or com[1]:lower() == 't' then
            if com == 'stopsteps' then Stopsteps = not Stopsteps add_to_chat(7, '----- Steps Will '..(Stopsteps and '' or 'Not ')..'Stop -----') end
        elseif com[1]:lower() == 'clear' then
            if com[2]:lower() == 'agrocount' and reg_event.atacking_mobs then if reg_event and reg_event.clear_aggro_count then reg_event.clear_aggro_count() end end
        end
    else
        if com == "reload_gearswap" then if file_write and file_write.write then file_write.write() end send_command("lua reload gearswap")
        elseif com == 'tstopsteps' then Stopsteps = not Stopsteps add_to_chat(7, '----- Steps Will '..(Stopsteps and '' or 'Not ')..'Stop -----')
        elseif com == 'stepcount' then Stepmax = (Stepmax % (player.main_job == "DNC" and 6 or 5)) + 1 add_to_chat(7,'Max step = '..Stepmax)
        elseif com == 'autohw' then Hwauto = not Hwauto add_to_chat(7, '----- Auto Healing Waltz Is '..(Hwauto and 'Enabled' or 'Disabled'))
        end
    end
end
function extra.aftercast(status,current_event,spell)
    if (auto_cap_ring or auto_xp_ring) then
        local rings = S{'Trizek Ring','Echad Ring'}
        if ring_time ~= 0 and ring_time <= os.time() and not rings:contains(player.equipment.left_ring) and not buffactive["encumbrance"] then
            if auto_cap_ring then equip({left_ring="Trizek Ring"}) disable("left_ring") elseif auto_xp_ring then equip({left_ring="Echad Ring"}) disable("left_ring") end
        elseif rings:contains(player.equipment.left_ring) then send_command('wait 3.0;input /item "'..player.equipment.left_ring..'" <me>') ring_time = 0 end
    end
end
----WS/Obi equip------------------------------------------------------------------------------------------------------------------
WS_Gear = {}
function WS_Gear.precast(status,event,spell)
    if spell.type == "WeaponSkill" then
        local spell_element = (type(spell.element)=='number' and res.elements[spell.element] or res.elements:with('name', spell.element))
        if player.inventory["Fotia Gorget"] or player.wardrobe["Fotia Gorget"] then sets.building[event] = set_combine(sets.building[event], {neck="Fotia Gorget"})
        elseif player.inventory[sets.sets.ws_neck[spell_element.en].neck] or player.wardrobe[sets.ws_neck[spell_element.en].neck] then sets.building[event] = set_combine(sets.building[event], sets.ws_neck[spell_element.en])
        end
        if player.inventory["Fotia Belt"] or player.wardrobe["Fotia Belt"] then sets.building[event] = set_combine(sets.building[event], {neck="Fotia Belt"})
        elseif player.inventory[sets.ws_belt[spell_element.en].waist] or player.wardrobe[sets.ws_belt[spell_element.en].waist] then sets.building[event] = set_combine(sets.building[event], sets.ws_belt[spell_element.en])
        end
        -- if player.inventory[sets.WS_types[spell.skill].head] or player.wardrobe[sets.WS_types[spell.skill].head] then sets.building[event] set_combine(sets.building[event], sets.WS_types[spell.skill]) end
    end
end
WS_Gear.midcast = WS_Gear.precast
e_obi = {}
function e_obi.midcast(status,event,spell)
    if not Typ.abilitys:contains(spell.prefix) and spell.action_type ~= "Item" then
        local spell_element = (type(spell.element)=='number' and res.elements[spell.element] or res.elements:with('name', spell.element))
        if spell_element.name == world.weather_element or spell_element.name == world.day_element then
            if player.inventory["Hachirin-no-Obi"] or player.wardrobe["Hachirin-no-Obi"] then sets.building[event] = set_combine(sets.building[event], {waist="Hachirin-no-Obi"})
            elseif player.inventory[sets.spell_obi[spell_element.en].waist] or player.wardrobe[sets.spell_obi[spell_element.en].waist] then sets.building[event] = set_combine(sets.building[event], sets.spell_obi[spell_element.en])
            end
        end
    end
end
function aggro_count(name) if reg_event and reg_event.attacker_count then return reg_event.attacker_count(name) else return 0 end end
--string to table function--------------------------------------------------------------------------------------------------------
function s_to_t(s)
    local str = s local f = (str:match('%(%)') or str:match("%('(.+)'%)") or nil) 
    if f then str = (f == '()' and string.gsub(str, '%(%)', "") or string.gsub(str, "%('"..f.."'%)", "")) end
    local t = {0} local tbl = string.find(str,'%.') while tbl do t[#t+1]=tbl tbl = string.find(str,'%.',tbl+1) end t[#t+1]=#str+1
    local g = _G for i = 1,#t-1 do g = g[string.sub(str,t[i]+1,t[i+1]-1)] end if f then if f == '()' then return g() else return g(f) end else return g end
end
--has buff function---------------------------------------------------------------------------------------------------------------
function has_any_buff_of(buff_set) for i,v in pairs(buff_set) do if buffactive[v] ~= nil then return true end end end
function get_item_next_use(name)--returns time remaining till items next use
    for _,i in ipairs({"inventory","wardrobe"}) do
        for _,v in ipairs(windower.ffxi.get_items()[i]) do
            if v.id > 0 and res.items[v.id].name == name then
                local data = extdata.decode(v)
                return (data.next_use_time+os.difftime(os.time(os.date("!*t", os.time())),os.time(os.date("*t", os.time()))))
            end
        end
    end
end