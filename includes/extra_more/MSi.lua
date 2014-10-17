if not Changestaff then
	Changestaff = false --Togle with //gs c tchangestaff (true for change staves, false for do not change staves)
end
if not Usestaff then
	Usestaff = 'Atk' --Togle with //gs c tstaveuse (Atk for Attack Staves, Acc for Accuracy Staves)
end

	sets.precast = {}
	sets.precast.Atk = {
		Fire={main="Atar I",sub="Fire Grip"},
		Ice={main="Vourukasha I",sub="Ice Grip"},
		Wind={main="Vayuvata I",sub="Wind Grip"},
		Earth={main="Vishrava I",sub="Earth Grip"},
		Lightning={main="Apamajas I",sub="Thunder Grip"},
		Water={main="Haoma I",sub="Water Grip"},
		Light={main="Arka I",sub="Light Grip"},
		Dark={main="Xsaeta I",sub="Dark Grip"},
	}
	sets.precast.Acc = {
		Fire={main="Atar II",sub="Fire Grip"},
		Ice={main="Vourukasha II",sub="Ice Grip"},
		Wind={main="Vayuvata II",sub="Wind Grip"},
		Earth={main="Vishrava II",sub="Earth Grip"},
		Lightning={main="Apamajas II",sub="Thunder Grip"},
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

function equip_elemental_magic_staves(spell,set_gear)
	if Changestaff then
		if Typ.spells:contains(spell.type) then
			if Cure.spells:contains(spell.english) then
				equip_set(set_gear, sets.precast.Cur)
			else
				equip_set(set_gear, sets.precast[Usestaff][spell.element])
			end
		end
	end
end

function equip_elemental_magic_Gear_command(command)
	if command == 'tstavetouse' then
		Usestaff = (Usestaff=='Atk' and 'Acc' or 'Atk')
		--add_to_chat(7, '----- Staves Set To '..Usestaff..' -----')
	elseif command == 'tchangemagestaff' then
		Changestaff = not Changestaff
		--add_to_chat(7, '----- Staves Will ' .. (Changestaff and '' or 'NOT ') .. 'Change -----')
	end
end