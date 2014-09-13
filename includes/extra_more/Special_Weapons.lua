if not specialweaponwscount then
	specialweaponwscount = 0
end
function special_weapon()
	if spell.type == "WeaponSkill" then
		if player.equipment.main == "Molva Maul" then --club
			if specialweaponwscount < 13 then
				specialweaponwscount = specialweaponwscount +1
				file_write()
			elseif specialweaponwscount == 13 then
				cancel_spell()
				send_command('input /ws "Randgrith" <t>')
				specialweaponwscount = 0
				file_write()
			end
		elseif player.equipment.main == "Skogul Lance" then --polearm
			if specialweaponwscount < 13 then
				specialweaponwscount = specialweaponwscount +1
				file_write()
			elseif specialweaponwscount == 13 then
				cancel_spell()
				send_command('input /ws "Geirskogul" <t>')
				specialweaponwscount = 0
				file_write()
			end
		elseif player.equipment.main == "Cleofun Axe" then --axe
			if specialweaponwscount < 13 then
				specialweaponwscount = specialweaponwscount +1
				file_write()
			elseif specialweaponwscount == 13 then
				cancel_spell()
				send_command('input /ws "Onslaught" <t>')
				specialweaponwscount = 0
				file_write()
			end
		elseif player.equipment.main == "Corbenic Sword" then --sword
			if specialweaponwscount < 13 then
				specialweaponwscount = specialweaponwscount +1
				file_write()
			elseif specialweaponwscount == 13 then
				cancel_spell()
				send_command('input /ws "Knights of Round" <t>')
				specialweaponwscount = 0
				file_write()
			end
		elseif player.equipment.main == "Murti Bow" then --archery
			if specialweaponwscount < 13 then
				specialweaponwscount = specialweaponwscount +1
				file_write()
			elseif specialweaponwscount == 13 then
				cancel_spell()
				send_command('input /ws "Namas Arrow" <t>')
				specialweaponwscount = 0
				file_write()
			end
		elseif player.equipment.main == "Heofon Knuckles" then --hand to hand
			if specialweaponwscount < 13 then
				specialweaponwscount = specialweaponwscount +1
				file_write()
			elseif specialweaponwscount == 13 then
				cancel_spell()
				send_command('input /ws "Final Heaven" <t>')
				specialweaponwscount = 0
				file_write()
			end
		elseif player.equipment.main == "Clement Skean" then --dagger
			if specialweaponwscount < 13 then
				specialweaponwscount = specialweaponwscount +1
				file_write()
			elseif specialweaponwscount == 13 then
				cancel_spell()
				send_command('input /ws "Randgrith" <t>')
				specialweaponwscount = 0
				file_write()
			end
		elseif player.equipment.main == "Khloros Blade" then --great sword
			if specialweaponwscount < 13 then
				specialweaponwscount = specialweaponwscount +1
				file_write()
			elseif specialweaponwscount == 13 then
				cancel_spell()
				send_command('input /ws "Scourge" <t>')
				specialweaponwscount = 0
				file_write()
			end
		elseif player.equipment.main == "Barbarus Bhuj" then --great axe
			if specialweaponwscount < 13 then
				specialweaponwscount = specialweaponwscount +1
				file_write()
			elseif specialweaponwscount == 13 then
				cancel_spell()
				send_command('input /ws "Metatron Torment" <t>')
				specialweaponwscount = 0
				file_write()
			end
		elseif player.equipment.main == "Crisis Scythe" then --scythe
			if specialweaponwscount < 13 then
				specialweaponwscount = specialweaponwscount +1
				file_write()
			elseif specialweaponwscount == 13 then
				cancel_spell()
				send_command('input /ws "Catastrophe" <t>')
				specialweaponwscount = 0
				file_write()
			end
		elseif player.equipment.main == "Sekirei" then --katana
			if specialweaponwscount < 13 then
				specialweaponwscount = specialweaponwscount +1
				file_write()
			elseif specialweaponwscount == 13 then
				cancel_spell()
				send_command('input /ws "Blade: Metsu" <t>')
				specialweaponwscount = 0
				file_write()
			end
		elseif player.equipment.main == "Ame-no-ohabari" then --great katana
			if specialweaponwscount < 13 then
				specialweaponwscount = specialweaponwscount +1
				file_write()
			elseif specialweaponwscount == 13 then
				cancel_spell()
				send_command('input /ws "Tachi: Kaiten" <t>')
				specialweaponwscount = 0
				file_write()
			end
		elseif player.equipment.main == "Chthonic Staff" then --staff
			if specialweaponwscount < 13 then
				specialweaponwscount = specialweaponwscount +1
				file_write()
			elseif specialweaponwscount == 13 then
				cancel_spell()
				send_command('input /ws "Gate of Tartarus" <t>')
				specialweaponwscount = 0
				file_write()
			end
		elseif player.equipment.main == "Exequy Gun" then --marksmanship
			if specialweaponwscount < 13 then
				specialweaponwscount = specialweaponwscount +1
				file_write()
			elseif specialweaponwscount == 13 then
				cancel_spell()
				send_command('input /ws "Coronach" <t>')
				specialweaponwscount = 0
				file_write()
			end
		end
	end
end