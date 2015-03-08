tool_bag_id = 0
menu = {}
menu.pos = {}
menu.pos.x = 0
menu.pos.y = 0
Conquest = {}
Conquest.neck = {}
Conquest.ring = {}
partynames = {}
auto_use_shards = false
weapon_types_count = 1
range_types_count = 1
armor_types_count = 1
sets.pretarget = {}
sets.precast = {}
sets.midcast = {}
sets.aftercast = {}
sets.pet_midcast = {}
sets.pet_aftercast = {}
sets.armor = {}
sets.range = {}
sets.weapon = {}
        --WALTZ TABLE (use Waltz.debuff or Waltz.spells)
        --This table is will give the waltz spells and all the debuffs that healing waltz can remove
Waltz = {
    debuff={'Max HP Down','Max MP Down','Magic Evasion Down','Max TP Down','Magic Atk. Down','Magic Acc. Down','Magic Def. Down','Defense Down','Evasion Down',
        'Attack Down','Accuracy Down','CHR Down','AGI Down','DEX Down','VIT Down','MND Down','INT Down','STR Down','bane','Bio','blindness','curse','Dia',
        'disease','Shock','Rasp','Choke','Frost','Burn','Drown','Flash','paralysis','plague','poison','silence','slow','weight','doom'},
    spells={'Healing Waltz','Curing Waltz V','Curing Waltz IV','Curing Waltz III','Curing Waltz II','Curing Waltz'},}
        --CITYS TABLE
cities = {"Ru'Lude Gardens","Upper Jeuno","Lower Jeuno","Port Jeuno","Port Windurst","Windurst Waters","Windurst Woods","Windurst Walls","Heavens Tower",
    "Port San d'Oria","Northern San d'Oria","Southern San d'Oria","Port Bastok","Bastok Markets","Bastok Mines","Metalworks","Aht Urhgan Whitegate",
    "Tavanazian Safehold","Nashmau","Selbina","Mhaura","Norg","Eastern Adoulin","Western Adoulin","Kazham"}
Cure = {spells = {'Cura','Cura II','Cura III','Curaga','Curaga II','Curaga III','Curaga IV','Curaga V','Cure','Cure II','Cure III','Cure IV','Cure V','Cure VI'},}
Typ = {spells = {'White Magic','Black Magic','Ninjutsu','Geomancy','Blue Magic','Bard Song'},abilitys = {'/jobability','/pet','/weaponskill','/monsterskill'},}
        --Finishing moves needed for Flourishes (use spell.en to get the amount)
min_fm_for_flourishes = {['Animated Flourish']=1,['Desperate Flourish']=1,['Violent Flourish']=1,['Reverse Flourish']=1,['Building Flourish']=1,
    ['Wild Flourish']=2,['Climactic Flourish']=1,['Striking Flourish']=2,['Ternary Flourish']=3,}
transportation_spells = {'Escape','Recall-Jugner','Recall-Meriph','Recall-Pashh','Retrace','Teleport-Altep','Teleport-Dem','Teleport-Holla','Teleport-Mea',
                        'Teleport-Vahzl','Teleport-Yhoat','Warp','Warp II'}
sets.WS_types={['Hand-to-Hand']={head="Tokon Hachimaki"},['Dagger']={head="Issen Hachimaki"},['Sword']={head="Kensho Hachimaki"},['Great Sword']={head="Hako Hachimaki"},
        ['Axe']={head="Ryoshi Hachimaki"},['Great Axe']={head="Senshin Hachimaki"},['Scythe']={head="Rekka Hachimaki"},['Polearm']={head="Shitotsu Hachimaki"},
        ['Katana']={head="Kanja Hachimaki"},['Great Katana']={head="Kengo Hachimaki"},['Club']={head="Rokugo Hachimaki"},['Staff']={head="Hakke Hachimaki"},
        ['Archery']={head="Shunten Hachimaki"},['Marksmanship']={head="Saika Hachimaki"},['Throwing']={},}
        --Job type table 
jobs = {ammo={"WAR","RDM","THF","PLD","DRK","BST","RNG","SAM","NIN","COR"},magic={"WHM","BLM","RDM","BRD","SMN","SCH","GEO"},}
        --Weapon types
weapon_types = L{'Axe','Club','Dagger','Great_Axe','Great_Sword','Hand-to-Hand','Polearm','Scythe','Staff','Sword','Great_Katana','Katana','Reserve','None'}
        --Range types
range_types = L{'Archery','Marksmanship','Throwing','Fishing','Soultrapper','Wind_Instruments','String_Instruments','Handbells','Other'}
        --Armore types
armor_types = L{'Basic','Tp','PDT','MDT'}
sets.ws={Dark={waist="Shadow Belt"},Water={waist="Aqua Belt"},Earth={waist="Soil Belt"},Ice={waist="Snow Belt"},Fire={waist="Flame Belt"},Wind={waist="Breeze Belt"},
        Lightning={waist="Thunder Belt"},Light={waist="Light Belt"},}

--has buff function---------------------------------------------------------------------------------------------------------------
function has_any_buff_of(buff_set)
    for i,v in pairs(buff_set) do if buffactive[v] ~= nil then return true end end
end