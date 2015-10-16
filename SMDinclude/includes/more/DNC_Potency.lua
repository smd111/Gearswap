--Dancer Waltz Potency Claculator
DNC = {}
function DNC.set_drain_samba() -- returns the highest lvl Drain Samba you can use
    local abilitys = res.job_abilities local dnc_type
    if player.main_job == "DNC" then
        dnc_type = 'main_job'
    elseif player.sub_job == "DNC" then
        dnc_type = 'sub_job'
    end
    if player.tp >= 400 and player[dnc_type..'_level'] >= 65 then
        return abilitys[186][gearswap.language]
    elseif player.tp >= 250 and player[dnc_type..'_level'] >= 35 then
        return abilitys[185][gearswap.language]
    elseif player.tp >= 100 and player[dnc_type..'_level'] >= 5 then
        return abilitys[184][gearswap.language]
    end
end
function DNC.waltz_potency(s)
    local potency = 100
    local tpreduction = 0
    local received_pot = 100
    local waltz_pot = {["Sonia's Plectrum"]=(allied_tags and 10 or 1),["ソニアプレクトラム"]=(allied_tags and 10 or 1),["Dnc. Casaque +1"]=10,["ＤＲカザク+1"]=10,
                       ["Dancer's Casaque"]=10,["ダンサーカザク"]=10,["Roundel Earring"]=5,["ラウンデルピアス"]=5,["Etoile Tiara"]=5,["エトワールティアラ"]=5,
                       ["Etoile Tiara +1"]=5,["ＥＴティアラ+1"]=5,["Etoile Tiara +2"]=7,["ＥＴティアラ+2"]=7,["Phurba"]=10,["フルバー"]=10,["Valseur's Ring"]=3,["ヴァルスールリング"]=3,
                       ["Kheper Bonnet"]=5,["ケペルボンネット"]=5,["Khepri Bonnet"]=8,["ケプリボンネット"]=8,["Toetapper Mantle"]=5,["トータッパーマント"]=5,
                       ["Asklepian Ring"]=3,["アスクレピアリング"]=3,["Maxixi Casaque"]=20,["マシシカザク"]=20,["Maxixi Casaque +1"]=21,["ＭＸカザク+1"]=21,
                       ["Maxixi Shoes"]=10,["マシシトーシュー"]=10,["Maxixi Shoes +1"]=10,["ＭＸトーシュー+1"]=10,["Blitto Needle"]=3,["ブリットニードル"]=3,
                       ["Slither Gloves +1"]=5,["スリザーグローブ+1"]=5,["Horos Tiara"]=9,["ホロスティアラ"]=9,["Horos Tiara +1"]=11,["ＨＯティアラ+1"]=11,
                       ["Rhadamanthus"]=7,["ラダマントゥス"]=7,}
    local waltz_received_pot = {["Maxixi Casaque"]=5,["マシシカザク"]=5,["Maxixi Casaque +1"]=6,["ＭＸカザク+1"]=6,["Asklepian Ring"]=3,["アスクレピアリング"]=3,}
    for _,v2 in pairs(s) do
        if type(v2) == "table" then
            potency = potency + (waltz_pot[v2.name] or 0) received_pot = received_pot + (waltz_received_pot[v2.name] or 0)
            for _,v in ipairs(v2.augments) do
                potency = potency + tonumber(v:startswith('"Waltz" potency') and string.match(v, '%d+') or '0')
                tpreduction = tpreduction + tonumber(v:startswith('"Waltz" TP cost') and string.match(v, '%d+') or '0')
            end
        else
            potency = potency + (waltz_pot[v2] or 0) received_pot = received_pot + (waltz_received_pot[v2] or 0)
        end
    end
    if potency > 130 then
        potency = 130
    end
    return s,potency,received_pot,tpreduction
end
function DNC.select_waltz(bpotency,received_pot,tpreduction) -- returns the most usable Waltz for use on your player
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
                return abilitys[v.id][gearswap.language],hp_dif
            elseif player.tp >= hTP then
                h_waltz = v.id
                h_hp = hHP
            end
        end
    end
    if h_waltz then
        return abilitys[h_waltz][gearswap.language],h_hp
    end
end
--my code used to get the correct healing of waltz (self only)
    -- if spell.type == 'Waltz' then
        -- if spell.target.type == "SELF" and spell.en:startswith('Curing Waltz') then
            -- local set,potency,received_pot,tpreduction = DNC.waltz_potency(sets["Waltz"])
            -- local new_waltz,h_total = DNC.select_waltz(potency,received_pot,tpreduction) 
            -- if new_waltz and spell.name ~= new_waltz then
                -- send_command('input /ja "'..new_waltz..'" <me>')
                -- status.end_event=true
                -- status.end_spell=true
                -- return
            -- elseif h_total == 0 then
                -- add_to_chat(cc.mc, 'Canceling '..spell.name..' HP Loss At 0')
                -- status.end_event=true
                -- status.end_spell=true
                -- return
            -- else
                -- if s_waltz_h_a and not showed then
                    -- add_to_chat(cc.mc, 'Waltz Set To '..new_waltz)
                -- end
            -- end
            -- sets.building[event] = set_combine(sets.building[event], set)
        -- end
--my code used to get the the best samba
    -- if spell.type == "Samba" and spell.en:startswith('Drain Samba') then
        -- local new_Samba = (DNC.set_drain_samba() or false)
        -- if new_Samba and spell.en ~= new_Samba then
            -- send_command('input /ja "'..new_Samba..'" <me>')
            -- status.end_event=true
            -- status.end_spell=true
        -- end