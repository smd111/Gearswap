 		--AMMO TABLE (use the ammo you want to equip to get quiver or pouch)
		--these will convert any ammo you can store in a quiver(arrow or bolt) or pouch(bullet) to the correct quiver or pouch
	combined_ammo = {
		["Crude Arrow"]="Old Quiver",["Old Arrow"]="Rotten Quiver",["Stone Arrow"]="Stone Quiver",["Bone Arrow"]="Bone Quiver",["Beetle Arrow"]="Beetle Quiver",
		["Horn Arrow"]="Horn Quiver",["Scorpion Arrow"]="Scorpion Quiver",["Demon Arrow"]="Demon Quiver",["Iron Arrow"]="Iron Quiver",["Silver Arrow"]="Silver Quiver",
		["Kabura Arrow"]="Kabura Quiver",["Sleep Arrow"]="Sleep Quiver",["Antlion Arrow"]="Antlion Quiver",["Ruszor Arrow"]="Ruszor Quiver",
		["Gargouille Arrow"]="Gargou. Quiver",["Chapuli Arrow"]="Chapuli Quiver",["Mantid Arrow"]="Mantid Quiver",["Achiyal. Arrow"]="Achiyal. Quiver",
		["Adlivun Arrow"]="Adlivun Quiver",["Tulfaire Arrow"]="Tulfaire Quiver",["Raaz Arrow"]="Raaz Quiver",["Eminent Arrow"]="Eminent Quiver",
		["Ra'Kaznar Arrow"]="Ra'Kaznar Quiver",["T.K. Arrow"]="T.K. Quiver",["Cmb.Cst. Arrow"]="Cmb.Cst. Quiver",["Dogbolt"]="Old Bolt Box",
		["Irn.Msk. Bolt"]="Irn.Msk. Quiver",["Bronze Bolt"]="B. Bolt Quiver",["Mythril Bolt"]="M. Bolt Quiver",["Darksteel Bolt"]="D. Bolt Quiver",
		["Blind Bolt"]="Bln. Bolt Quiver",["Acid Bolt"]="Ac. Bolt Quiver",["Holy Bolt"]="Hol. Bolt Quiver",["Sleep Bolt"]="Slp. Bolt Quiver",
		["Venom Bolt"]="Vn. Bolt Quiver",["Bloody Bolt"]="Bld. Bolt Quiver",["Darkling Bolt"]="Dkl. Bolt Quiver",["Fusion Bolt"]="Fsn. Bolt Quiver",
		["Drk. Adm. Bolt"]="D.A. Bolt Quiver",["Adaman Bolt"]="A. Bolt Quiver",["Midrium Bolt"]="Mid. Bolt Quiver",["Damascus Bolt"]="Dm. Bolt Quiver",
		["Oxidant Bolt"]="O. Bolt Quiver",["Achiyal. Bolt"]="Al. Bolt Quiver",["Adlivun Bolt"]="Ad. Bolt Quiver",["Titanium Bolt"]="T. Bolt Quiver",
		["Bismuth Bolt"]="Bi. Bolt Quiver",["Eminent Bolt"]="Em. Bolt Quiver",["Abrasion Bolt"]="Abr. Bolt Quiver",["Righteous Bolt"]="Rig. Bolt Quiver",
		["Ra'Kaznar Bolt"]="Ra. Bolt Quiver",["Antique Bullet"]="Old Bullet Box",["Silver Bullet"]="Silv. Bul. Pouch",["Spartan Bullet"]="Spar. Bul. Pouch",
		["Corsair Bullet"]="Cor. Bull. Pouch",["Iron Bullet"]="Iron Bull. Pouch",["Bronze Bullet"]="Brz. Bull. Pouch",["Bullet"]="Bullet Pouch",
		["Steel Bullet"]="Stl. Bull. Pouch",["Dweomer Bullet"]="Dwm. Bul. Pouch",["Oberon's Bullet"]="Obr. Bull. Pouch",["Drk. Adm. Bullet"]="D.A. Bull. Pouch",
		["Orichalc. Bullet"]="O. Bull. Pouch",["Adaman Bullet"]="A. Bull. Pouch",["Midrium Bullet"]="Mid. Bul. Pouch",["Damascus Bullet"]="Dm. Bul. Pouch",
		["Achiyal. Bullet"]="Al. Bull. Pouch",["Adlivun Bullet"]="Ad. Bull. Pouch",["Titanium Bullet"]="Ti. Bull. Pouch",["Bismuth Bullet"]="Bi. Bull. Pouch",
		["Eminent Bullet"]="Em. Bul. Pouch",["Ra'Kaznar Bullet"]="Ra. Bul. Pouch",}

	sets.ammo_empty = {ammo=empty,}
--Ammo functions
function ammo_check()
	if player.inventory[combined_ammo[sets[player.status].ammo]] and player.inventory[sets[player.status].ammo] == nil then
		return true
	end
	return false
end
function ammo_reequip()
	if player.inventory[combined_ammo[sets[player.status].ammo]] ~= nil then
		return combined_ammo[sets[player.status].ammo]
	end
end
function ammo_rule(spell)
	if spell.english == "Ranged" and ammo_check() then
		status.end_event = true
		status.end_spell = true
		equip(sets.ammo_empty)
		send_command('input /item "'..ammo_reequip()..'" <me>')
	end
end