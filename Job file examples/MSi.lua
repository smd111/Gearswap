	-- How To Use
	-- 1. put include('Mage Staves include.lua') in function get_sets()
	-- 2. put equip_elemental_magic_gear(spell) in function precast(spell)
	-- 3. put equip_elemental_magic_gear_command(command) in function self_command(command)

	sets.precast = {}
	sets.precast.Atk = {
		Fire={main="Atar I",sub="Fire Grip"},
		Ice={main="Vourukasha I",sub="Ice Grip"},
		Wind={main="Vayuvata I",sub="Wind Grip"},
		Earth={main="Vishrava I",sub="Earth Grip"},
		Thunder={main="Apamajas I",sub="Thunder Grip"},
		Water={main="Haoma I",sub="Water Grip"},
		Light={main="Arka I",sub="Light Grip"},
		Dark={main="Xsaeta I",sub="Dark Grip"},
	}
	sets.precast.Acc = {
		Fire={main="Atar II",sub="Fire Grip"},
		Ice={main="Vourukasha II",sub="Ice Grip"},
		Wind={main="Vayuvata II",sub="Wind Grip"},
		Earth={main="Vishrava II",sub="Earth Grip"},
		Thunder={main="Apamajas II",sub="Thunder Grip"},
		Water={main="Haoma II",sub="Water Grip"},
		Light={main="Arka II",sub="Light Grip"},
		Dark={main="Xsaeta II",sub="Dark Grip"},
	}
	sets.precast.Cur = {
		main="Arka IV",
		sub="Dominie's Grip",
		body="Heka's Kalasiris",
		hands="Bokwus Gloves",
		neck="Phalaina Locket",
		left_ear="Roundel Earring",
	}
	sets.obi = {
		Fire = {waist="Karin Obi"},
		Earth = {waist="Dorin Obi"},
		Water = {waist="Suirin Obi"},
		Wind = {waist="Furin Obi"},
		Ice = {waist="Hyorin Obi"},
		Thunder = {waist="Rairin Obi"},
		Light = {waist="Korin Obi"},
		Dark = {waist="Anrin Obi"},
	}
	cure = {}
	cure.spells = S{'Cura','Cura II','Cura III','Curaga','Curaga II','Curaga III','Curaga IV','Curaga V','Cure','Cure II','Cure III','Cure IV','Cure V','Cure VI'}
	typ = {}
	typ.spells = S{'WhiteMagic','BlackMagic','Ninjutsu','Geomancy','BlueMagic','BardSong'}
	Changestaff = true --Togle with //gs c tchangestaff (true for change staves, false for do not change staves)
	Usestaff = 'Atk' --Togle with //gs c tstaveuse (Atk for Attack Staves, Acc for Accuracy Staves)


function equip_elemental_magic_gear(spell)
	if Changestaff then
		if typ.spells[spell.type] then
			if cure.spells[spell.english] then
				equip(sets.precast.Cur)
			else
				equip(sets.precast[Usestaff][spell.element])
			end
		end
	end
	if spell.element == world.weather_element or spell.element == world.day_element then
		equip(sets.obi[spell.element])
	end
end
function equip_elemental_magic_gear_command(command)
	if command == 'tstavetouse' then
		if Usestaff == 'Atk' then
			Usestaff = 'Acc'
			add_to_chat(123, '----- STAVES SET TO ACC -----')
		elseif Usestaff == 'Acc' then
			Usestaff = 'Atk'
			add_to_chat(123, '----- STAVES SET TO ATK -----')
		end
	elseif command == 'tchangemagestaff' then
		Changestaff = not Changestaff
		add_to_chat(123, '----- STAVES WILL ' .. (Changestaff and '' or 'NOT ') .. 'CHANGE -----')
	end
end