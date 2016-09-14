menu,auto_use_shards,File_Write,Registered_Events,ISr,tsstown,thfsub = {pos = {x = 100,y = 100}},false,true,true,true,true,false
weapon_types_count,range_types_count,armor_types_count,xpcpcoring,rings_count,skill_count = 1,1,1,1,1,1 conquest = {ring={},neck={}}
sets.armor,sets.pet_aftercast,sets.weapon,partynames,sets.pretarget,sets.precast,sets.midcast,sets.aftercast = {},{},{},{},{},{},{},{}
sets.range,sets.building,sets.pet_midcast,cc = {['ThrowLVL.99+'] = {range="Halakaala",ammo=empty}},{},{},{mc=9,r1=11,r2=10,g1=158,g2=6,b1=5,b2=205,y1=36,y2=37}
log_in_time = os.clock()
towaltz,tosamba,towaltzc = false,false,false
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
    