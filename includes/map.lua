		--WALTZ TABLE (use Waltz.debuff or Waltz.spells)
		--This table is will give the waltz spells and all the debuffs that healing waltz can remove
Waltz = {
	debuff = S{'Max HP Down','Max MP Down','Magic Evasion Down','Max TP Down','Magic Atk. Down','Magic Acc. Down','Magic Def. Down',
				'Defense Down','Evasion Down','Attack Down','Accuracy Down','CHR Down','AGI Down','DEX Down','VIT Down','MND Down','INT Down','STR Down',
				'bane','Bio','blindness','curse','Dia','disease','Shock','Rasp','Choke','Frost','Burn','Drown','Flash','paralysis','plague','poison',
				'silence','slow','weight'},
	spells = S{'Healing Waltz','Curing Waltz V','Curing Waltz IV','Curing Waltz III','Curing Waltz II','Curing Waltz'},
	}

		--CITYS TABLE
cities = S{
	"Ru'Lude Gardens",
	"Upper Jeuno",
	"Lower Jeuno",
	"Port Jeuno",
	"Port Windurst",
	"Windurst Waters",
	"Windurst Woods",
	"Windurst Walls",
	"Heavens Tower",
	"Port San d'Oria",
	"Northern San d'Oria",
	"Southern San d'Oria",
	"Port Bastok",
	"Bastok Markets",
	"Bastok Mines",
	"Metalworks",
	"Aht Urhgan Whitegate",
	"Tavanazian Safehold",
	"Nashmau",
	"Selbina",
	"Mhaura",
	"Norg",
	"Eastern Adoulin",
	"Western Adoulin",
	"Kazham"
}

sets.sleep = {neck="Opo-opo Necklace",back="Aries Mantle"}

sets.obi = {
	Fire = {waist="Karin Obi"},
	Earth = {waist="Dorin Obi"},
	Water = {waist="Suirin Obi"},
	Wind = {waist="Furin Obi"},
	Ice = {waist="Hyorin Obi"},
	Lightning = {waist="Rairin Obi"},
	Light = {waist="Korin Obi"},
	Dark = {waist="Anrin Obi"},
	}

Cure = {
	spells = S{'Cura','Cura II','Cura III','Curaga','Curaga II','Curaga III','Curaga IV','Curaga V','Cure','Cure II','Cure III','Cure IV','Cure V','Cure VI'}
	}

Typ = {
	spells = S{'White Magic','Black Magic','Ninjutsu','Geomancy','Blue Magic','Bard Song'},
	abilitys = S{'/jobability','/pet','/weaponskill','/monsterskill'},
	}
		--Finishing moves needed for Flourishes (use spell.en to get the amount)
min_fm_for_flourishes = {['Animated Flourish']=1, ['Desperate Flourish']=1, ['Violent Flourish']=1, ['Reverse Flourish']=1, ['Building Flourish']=1,
						['Wild Flourish']=2, ['Climactic Flourish']=1, ['Striking Flourish']=2, ['Ternary Flourish']=3,}

		--Job type table 
jobs = {ammo = {"WAR","RDM","THF","PLD","DRK","BST","RNG","SAM","NIN","COR"},magic = {"WHM","BLM","RDM","BRD","SMN","SCH","GEO"},}