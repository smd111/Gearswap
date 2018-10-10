menu,auto_use_shards,File_Write,istratre,tsstown,thfsub,ocure = {pos = {x = 100,y = 100},flags={draggable=false}},false,true,true,true,false,false
weapon_types_count,range_types_count,armor_types_count,xpcpcoring,rings_count,skill_count = 1,1,1,1,1,1 conquest = {ring={},neck={}}
sets.armor,sets.pet_aftercast,sets.weapon,partynames,sets.pretarget,sets.precast,sets.midcast,sets.aftercast = {},{},{},{},{},{},{},{}
sets.range,sets.building,sets.pet_midcast = {['ThrowLVL.99+'] = {range="Halakaala",ammo=empty}},{},{}
log_in_time = os.clock()
towaltz,tosamba,towaltzc,show_aggro,ws_head,Stopsteps = false,false,false,false,false,false
equip_from_bags = {"inventory","wardrobe","wardrobe2","wardrobe3","wardrobe4"}
        --Weapon types--Range types--Armor types
weapon_types,range_types,armor_types,rings = T{"Not Set"},T{"Not Set"},T{"Not Set"},T{"Not Set"}
        --WALTZ TABLE (use Waltz.debuff or Waltz.spells)
        --This table is will give the waltz spells and all the debuffs that healing waltz can remove
Waltz = {debuff=S{'Max HP Down','Max MP Down','Magic Evasion Down','Max TP Down','Magic Atk. Down','Magic Acc. Down','Magic Def. Down','Defense Down','Evasion Down',
    'Attack Down','Accuracy Down','CHR Down','AGI Down','DEX Down','VIT Down','MND Down','INT Down','STR Down','bane','Bio','blindness','curse','Dia','disease','Shock',
    'Rasp','Choke','Frost','Burn','Drown','Flash','paralysis','plague','poison','silence','slow','weight','doom'},
         spells=S{'Healing Waltz','Curing Waltz V','Curing Waltz IV','Curing Waltz III','Curing Waltz II','Curing Waltz'},}
        --AOE Weapon Skills
aoe_ws = S{"Spinning Attack","Aeolian Edge","Cyclone","Shockwave","Fell Cleave","Spinning Scythe","Cataclysm","Earth Crusher","Uriel Blade","Glory Slash","Circle Blade"}
        --CITYS TABLE
cities = S{"Ru'Lude Gardens","Upper Jeuno","Lower Jeuno","Port Jeuno","Port Windurst","Windurst Waters","Windurst Woods","Windurst Walls","Heavens Tower",
    "Port San d'Oria","Northern San d'Oria","Southern San d'Oria","Chateau d'Oraguille","Port Bastok","Bastok Markets","Bastok Mines","Metalworks",
    "Aht Urhgan Whitegate","Tavnazian Safehold","Nashmau","Selbina","Mhaura","Norg","Eastern Adoulin","Western Adoulin","Kazham"}
Cure = {spells = S{'Cura','Cura II','Cura III','Curaga','Curaga II','Curaga III','Curaga IV','Curaga V','Cure','Cure II','Cure III','Cure IV','Cure V','Cure VI'},}
Typ = {spells = S{'White Magic','Black Magic','Ninjutsu','Geomancy','Blue Magic','Bard Song'},abilitys = S{'/jobability','/pet','/weaponskill','/monsterskill','/range'},}
        --Finishing moves needed for Flourishes (use spell.en to get the amount)
min_fm_for_flourishes = {['Animated Flourish']=1,['Desperate Flourish']=1,['Violent Flourish']=1,['Reverse Flourish']=1,['Building Flourish']=1,['Wild Flourish']=2,
    ['Climactic Flourish']=1,['Striking Flourish']=2,['Ternary Flourish']=3,}
        --these are transportation spell's
transportation_spells = S{'Escape','Recall-Jugner','Recall-Meriph','Recall-Pashh','Retrace','Teleport-Altep','Teleport-Dem','Teleport-Holla','Teleport-Mea',
    'Teleport-Vahzl','Teleport-Yhoat','Warp','Warp II'}
        --these are the sets for Weapon Skill head/belt/neck and spell obi
sets.WS_types={['Hand-to-Hand']={head="Tokon Hachimaki"},['Dagger']={head="Issen Hachimaki"},['Sword']={head="Kensho Hachimaki"},['Great Sword']={head="Hako Hachimaki"},
    ['Axe']={head="Ryoshi Hachimaki"},['Great Axe']={head="Senshin Hachimaki"},['Scythe']={head="Rekka Hachimaki"},['Polearm']={head="Shitotsu Hachimaki"},
    ['Katana']={head="Kanja Hachimaki"},['Great Katana']={head="Kengo Hachimaki"},['Club']={head="Rokugo Hachimaki"},['Staff']={head="Hakke Hachimaki"},
    ['Archery']={head="Shunten Hachimaki"},['Marksmanship']={head="Saika Hachimaki"},['Throwing']={},}
sets.ws_belt={Dark={waist="Shadow Belt"},Water={waist="Aqua Belt"},Earth={waist="Soil Belt"},Ice={waist="Snow Belt"},Fire={waist="Flame Belt"},
    Wind={waist="Breeze Belt"},Lightning={waist="Thunder Belt"},Light={waist="Light Belt"},}
sets.ws_neck={Dark={neck="Shadow Gorget"},Water={neck="Aqua Gorget"},Earth={neck="Soil Gorget"},Ice={neck="Snow Gorget"},Fire={neck="Flame Gorget"},
    Wind={neck="Breeze Gorget"},Lightning={neck="Thunder Gorget"},Light={neck="Light Gorget"},}
sets.spell_obi={Fire={waist="Karin Obi"},Earth={waist="Dorin Obi"},Water={waist="Suirin Obi"},Wind={waist="Furin Obi"},Ice={waist="Hyorin Obi"},
    Lightning={waist="Rairin Obi"},Light={waist="Korin Obi"},Dark={waist="Anrin Obi"},}
        -- unusable_buff.spell  unusable_buff.ability these contain buff the bloc the specific types
unusable_buff = {spell={'Charm','Mute','Omerta','Petrification','Silence','Sleep','Stun','Terror'},
    ability={'Amnesia','Charm','Impairment','Petrification','Sleep','Stun','Terror'}}
        --Job type table 
jobs = {ammo=S{"WAR","RDM","THF","PLD","DRK","BST","RNG","SAM","NIN","COR"},magic=S{"WHM","BLM","RDM","BRD","SMN","SCH","GEO"},pet=S{"SMN","PUP","GEO","BST","DRG"},}
cure_gear = {en={main="Arka IV",sub="Dominie's Grip",body="Heka's Kalasiris",hands="Bokwus Gloves",neck="Phalaina Locket",left_ear="Roundel Earring",},
             ja={main="アーカIV",sub="ドミニエズグリップ",body="ヘカカラシリス",hands="ボクワスグローブ",neck="ファライナロケット",left_ear="ラウンデルピアス",}}
lang = {english="en",japenese="ja"}
job_skills=T{[1]=S{1,2,6,13,18,19},[2]=S{1,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21},[3]=S{1,5,6,7,8,9,10,11,12,13,14,17,19,22},[4]=S{1,7,8,22},
    [5]=S{1,8,9,11,22},[6]=S{1,8,22},[7]=S{1,4,8,9},[8]=S{1,7,12,14},[9]=S{13},[10]=S{12,13},[11]=S{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,20,21,22},
    [12]=S{1,2,3,4,5,7,10,11,14,15,20,21},[22]=S{18},[23]=S{18},[24]=S{18},[25]=S{1,5,6,11,12,13},[26]=S{1,6,8,11,13,17},[27]=S{1,2,3,4,5,6,10,11,12,13,17,18,19,20},
    [28]=S{2,18},[29]=S{"All"},[30]=S{1,3,5,6,7,9},[31]=S{1,2,5,6,7,8,9,10,12,13,14,16,17,18,19,20,21,22},[32]=S{3,5,7,20,22},[33]=S{3,5,7,20},[34]=S{3,4,5,20,22},
    [35]=S{3,4,5,20,21},[36]=S{4,5,8,20,21},[37]=S{4,5,8,21},[38]=S{15},[39]=S{13},[40]=S{10},[41]=S{10},[42]=S{10},[43]=S{16},[44]=S{21},[45]=S{21},[48]=S{"All"},
    [49]=S{"All"},[50]=S{"All"},[51]=S{"All"},[52]=S{"All"},[53]=S{"All"},[54]=S{"All"},[55]=S{"All"},[56]=S{"All"},[57]=S{"All"},}