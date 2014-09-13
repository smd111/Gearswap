if not specialweaponwscount then
	specialweaponwscount = 0
end
function special_weapon()
	if spell.type == "WeaponSkill" then
		if player.equipment.main == "Molva Maul" and spell.name ~= "Randgrith" then --club
			if specialweaponwscount < 13 then
				specialweaponwscount = specialweaponwscount +1
			elseif specialweaponwscount == 13 then
				cancel_spell()
				send_command('input /ws "Randgrith" <t>')
				specialweaponwscount = 0
			end
		elseif player.equipment.main == "Skogul Lance" and spell.name ~= "Geirskogul" then --polearm
			if specialweaponwscount < 13 then
				specialweaponwscount = specialweaponwscount +1
			elseif specialweaponwscount == 13 then
				cancel_spell()
				send_command('input /ws "Geirskogul" <t>')
				specialweaponwscount = 0
			end
		elseif player.equipment.main == "Cleofun Axe" and spell.name ~= "Onslaught" then --axe
			if specialweaponwscount < 13 then
				specialweaponwscount = specialweaponwscount +1
			elseif specialweaponwscount == 13 then
				cancel_spell()
				send_command('input /ws "Onslaught" <t>')
				specialweaponwscount = 0
			end
		elseif player.equipment.main == "Corbenic Sword" and spell.name ~= "Knights of Round" then --sword
			if specialweaponwscount < 13 then
				specialweaponwscount = specialweaponwscount +1
			elseif specialweaponwscount == 13 then
				cancel_spell()
				send_command('input /ws "Knights of Round" <t>')
				specialweaponwscount = 0
			end
		elseif player.equipment.main == "Murti Bow" and spell.name ~= "Namas Arrow" then --archery
			if specialweaponwscount < 13 then
				specialweaponwscount = specialweaponwscount +1
			elseif specialweaponwscount == 13 then
				cancel_spell()
				send_command('input /ws "Namas Arrow" <t>')
				specialweaponwscount = 0
			end
		elseif player.equipment.main == "Heofon Knuckles" and spell.name ~= "Final Heaven" then --hand to hand
			if specialweaponwscount < 13 then
				specialweaponwscount = specialweaponwscount +1
			elseif specialweaponwscount == 13 then
				cancel_spell()
				send_command('input /ws "Final Heaven" <t>')
				specialweaponwscount = 0
			end
		elseif player.equipment.main == "Clement Skean" and spell.name ~= "Mercy Stroke" then --dagger
			if specialweaponwscount < 13 then
				specialweaponwscount = specialweaponwscount +1
			elseif specialweaponwscount == 13 then
				cancel_spell()
				send_command('input /ws "Mercy Stroke" <t>')
				specialweaponwscount = 0
			end
		elseif player.equipment.main == "Khloros Blade" and spell.name ~= "Scourge" then --great sword
			if specialweaponwscount < 13 then
				specialweaponwscount = specialweaponwscount +1
			elseif specialweaponwscount == 13 then
				cancel_spell()
				send_command('input /ws "Scourge" <t>')
				specialweaponwscount = 0
			end
		elseif player.equipment.main == "Barbarus Bhuj" and spell.name ~= "Metatron Torment" then --great axe
			if specialweaponwscount < 13 then
				specialweaponwscount = specialweaponwscount +1
			elseif specialweaponwscount == 13 then
				cancel_spell()
				send_command('input /ws "Metatron Torment" <t>')
				specialweaponwscount = 0
			end
		elseif player.equipment.main == "Crisis Scythe" and spell.name ~= "Catastrophe" then --scythe
			if specialweaponwscount < 13 then
				specialweaponwscount = specialweaponwscount +1
			elseif specialweaponwscount == 13 then
				cancel_spell()
				send_command('input /ws "Catastrophe" <t>')
				specialweaponwscount = 0
			end
		elseif player.equipment.main == "Sekirei" and spell.name ~= "Blade: Metsu" then --katana
			if specialweaponwscount < 13 then
				specialweaponwscount = specialweaponwscount +1
			elseif specialweaponwscount == 13 then
				cancel_spell()
				send_command('input /ws "Blade: Metsu" <t>')
				specialweaponwscount = 0
			end
		elseif player.equipment.main == "Ame-no-ohabari" and spell.name ~= "Tachi: Kaiten" then --great katana
			if specialweaponwscount < 13 then
				specialweaponwscount = specialweaponwscount +1
			elseif specialweaponwscount == 13 then
				cancel_spell()
				send_command('input /ws "Tachi: Kaiten" <t>')
				specialweaponwscount = 0
			end
		elseif player.equipment.main == "Chthonic Staff" and spell.name ~= "Gate of Tartarus" then --staff
			if specialweaponwscount < 13 then
				specialweaponwscount = specialweaponwscount +1
			elseif specialweaponwscount == 13 then
				cancel_spell()
				send_command('input /ws "Gate of Tartarus" <t>')
				specialweaponwscount = 0
			end
		elseif player.equipment.main == "Exequy Gun" and spell.name ~= "Coronach" then --marksmanship
			if specialweaponwscount < 13 then
				specialweaponwscount = specialweaponwscount +1
			elseif specialweaponwscount == 13 then
				cancel_spell()
				send_command('input /ws "Coronach" <t>')
				specialweaponwscount = 0
			end
		end
	end
end