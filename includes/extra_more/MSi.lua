if not Changestaff then
	Changestaff = false --Togle with //gs c tchangestaff (true for change staves, false for do not change staves)
end
if not Usestaff then
	Usestaff = 'Atk' --Togle with //gs c tstaveuse (Atk for Attack Staves, Acc for Accuracy Staves)
end

	sets.staff = {}
	sets.staff.Atk = {Fire={main="Atar I",sub="Fire Grip"},Ice={main="Vourukasha I",sub="Ice Grip"},Wind={main="Vayuvata I",sub="Wind Grip"},
		Earth={main="Vishrava I",sub="Earth Grip"},Lightning={main="Apamajas I",sub="Thunder Grip"},Water={main="Haoma I",sub="Water Grip"},
		Light={main="Arka I",sub="Light Grip"},Dark={main="Xsaeta I",sub="Dark Grip"},}
	sets.staff.Acc = {Fire={main="Atar II",sub="Fire Grip"},Ice={main="Vourukasha II",sub="Ice Grip"},Wind={main="Vayuvata II",sub="Wind Grip"},
		Earth={main="Vishrava II",sub="Earth Grip"},Lightning={main="Apamajas II",sub="Thunder Grip"},Water={main="Haoma II",sub="Water Grip"},
		Light={main="Arka II",sub="Light Grip"},Dark={main="Xsaeta II",sub="Dark Grip"},}
	sets.staff.Cur = {main="Arka IV",sub="Dominie's Grip",body="Heka's Kalasiris",hands="Bokwus Gloves",neck="Phalaina Locket",left_ear="Roundel Earring",}

function equip_elemental_magic_staves(spell,set_gear)
	if Changestaff then
		if Typ.spells:contains(spell.type) then
			if Cure.spells:contains(spell.english) then
				set_gear = set_combine(set_gear, sets.staff.Cur)
			else
				set_gear = set_combine(set_gear, sets.staff[Usestaff][spell.element])
			end
		end
	end
	return set_gear
end
function equip_elemental_magic_Gear_self_command(command)
	if string.lower(command[1]) == "t" or string.lower(command[1]) == "toggle" then
		if command[2] == 'stavetouse' then
			Usestaff = (Usestaff=='Atk' and 'Acc' or 'Atk')
			--add_to_chat(7, '----- Staves Set To '..Usestaff..' -----')
		elseif string.lower(command[2]) == 'changemagestaff' then
			Changestaff = not Changestaff
			--add_to_chat(7, '----- Staves Will ' .. (Changestaff and '' or 'NOT ') .. 'Change -----')
		end
	elseif string.lower(command[1]) == "s" or string.lower(command[1]) == "set" then
		if string.lower(command[2]) == 'stavetouse' then
			Usestaff = command[3]
		end
	else
		if command == 'tstavetouse' then
			Usestaff = (Usestaff=='Atk' and 'Acc' or 'Atk')
			--add_to_chat(7, '----- Staves Set To '..Usestaff..' -----')
		elseif command == 'tchangemagestaff' then
			Changestaff = not Changestaff
			--add_to_chat(7, '----- Staves Will ' .. (Changestaff and '' or 'NOT ') .. 'Change -----')
		end
	end
end