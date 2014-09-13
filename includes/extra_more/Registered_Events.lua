require 'actions'
stopskilltyp = {[1]="Hand_to_Hand",[2]="Dagger",[3]="Sword",[4]="Great_Sword",[5]="Axe",[6]="Great_Axe",[7]="Scythe",[8]="Polearm",[9]="Katana",[10]="Great_Katana",[11]="Club",[12]="Staff",[13]="Archery",[14]="Marksmanship",[15]="Throwing",[16]="Guarding",[17]="Evasion",[18]="Shield",[19]="Parrying",[20]="Divine_Magic",[21]="Healing_Magic",[22]="Enhancing_Magic",[23]="Enfeebling_Magic",[24]="Elemental_Magic",[25]="Dark_Magic",[26]="Summoning_Magic",[27]="Ninjutsu",[28]="Singing",[29]="Stringed_Instrument",[30]="Wind_Instrument",[31]="Blue_Magic",[32]="Geomancy",[33]="Handbell"}
stopskill_count = 16
stoponskillcap = false
skillclose = 1
partynames ={}
seqid = string.char(0,0)

if gearswap.pathsearch({'Data/registered_events.lua'}) then
	include('Data/registered_events.lua')
end
--clear old added events
-- if id_action then
	-- windower.unregister_event(id_action)
-- end
-- if id_incoming_chunk then
	-- windower.unregister_event(id_incoming_chunk)
-- end
-- if id_outgoing_chunk then
	-- windower.unregister_event(id_outgoing_chunk)
-- end
-- if id_target_change then
	-- windower.unregister_event(id_target_change)
-- end
--stop on selected skill cap function
function skill_cap(skill)
	if lvl[skill] == "Capped" then
		if skillclose == 1 then
			send_command('@load run;run -killonly "C:/Program Files (x86)/EliteMMO/XiClaim/XiClaim.exe";wait 1.0;unload run')
			stoponskillcap = false
		elseif skillclose == 2 then
			send_command('@load run;run -killonly "C:/Program Files (x86)/EliteMMO/XiClaim/XiClaim.exe";run -killonly "C:/Users/Steven/Desktop/FFXI/apps/Gambot v2 14SEP2011.0230/Gambot (4).exe";unload run')
			stoponskillcap = false
		elseif skillclose == 2 then
			send_command('@load run;run -killonly "C:/Program Files (x86)/EliteMMO/XiClaim/XiClaim.exe";run -killonly "C:/Users/Steven/Desktop/FFXI/apps/Gambot v2 14SEP2011.0230/Gambot (4).exe";run -killonly "C:/Users/Steven/Desktop/FFXI/apps/Gambot v3/Gambot.exe";unload run')
			stoponskillcap = false
		end
	end
end
-- added events--
-- Action event
function event_action(act)
	action = Action(act)
    if action:get_category_string() == 'item_finish' then
        if action.raw.param == tbid and player.id == action.raw.actor_id then
			send_command('wait 1.0;input /ma "'..last_nin_spell..'" <me>')
			tool_bag_id = 0
		end
    end
end
id_action = windower.raw_register_event('action', event_action)
--Incoming Chunk Event(Packets Received)
function incoming_chunk(id, data, modified, injected, blocked)
	if triggered and data:sub(3,4) ~= seqid then
			--gearswap.refresh_Globals()
			triggered = nil
		if partynames.party1 then
			partynames.party1 = nil
		end
		if partynames.party2 then
			partynames.party2 = nil
		end
		if partynames.party2 then
			partynames.party3 = nil
		end
		for pt_num,pt in ipairs(alliance) do
			for pos,player in ipairs(pt) do
				if not partynames['party'..pt_num] then
					partynames['party'..pt_num] = S{}
				end
				partynames['party'..pt_num]:add(player.name)
			end
		end
	end
	if id == 0x062 and stoponskillcap then
		lvl = {
			Hand_to_Hand = data:unpack('H', 0x83) > 32768 and 'Capped' or data:unpack('H', 0x83),
			Dagger = data:unpack('H', 0x85) > 32768 and 'Capped' or data:unpack('H', 0x85),
			Sword = data:unpack('H', 0x87) > 32768 and 'Capped' or data:unpack('H', 0x87),
			Great_Sword = data:unpack('H', 0x89) > 32768 and 'Capped' or data:unpack('H', 0x89),
			Axe = data:unpack('H', 0x8B) > 32768 and 'Capped' or data:unpack('H', 0x8B),
			Great_Axe = data:unpack('H', 0x8D) > 32768 and 'Capped' or data:unpack('H', 0x8D),
			Scythe = data:unpack('H', 0x7F) > 32768 and 'Capped' or data:unpack('H', 0x7F),
			Polearm = data:unpack('H', 0x91) > 32768 and 'Capped' or data:unpack('H', 0x91),
			Katana = data:unpack('H', 0x93) > 32768 and 'Capped' or data:unpack('H', 0x93),
			Great_Katana = data:unpack('H', 0x95) > 32768 and 'Capped' or data:unpack('H', 0x95),
			Club = data:unpack('H', 0x97) > 32768 and 'Capped' or data:unpack('H', 0x97),
			Staff = data:unpack('H', 0x99) > 32768 and 'Capped' or data:unpack('H', 0x99),
			Archery = data:unpack('H', 0xB3) > 32768 and 'Capped' or data:unpack('H', 0xB3),
			Marksmanship = data:unpack('H', 0xB5) > 32768 and 'Capped' or data:unpack('H', 0xB5),
			Throwing = data:unpack('H', 0xB7) > 32768 and 'Capped' or data:unpack('H', 0xB7),
			Guarding = data:unpack('H', 0xB9) > 32768 and 'Capped' or data:unpack('H', 0xB9),
			Evasion = data:unpack('H', 0xBB) > 32768 and 'Capped' or data:unpack('H', 0xBB),
			Shield = data:unpack('H', 0xBD) > 32768 and 'Capped' or data:unpack('H', 0xBD),
			Parrying = data:unpack('H', 0xBF) > 32768 and 'Capped' or data:unpack('H', 0xBF),
			Divine_Magic = data:unpack('H', 0xC1) > 32768 and 'Capped' or data:unpack('H', 0xC1),
			Healing_Magic = data:unpack('H', 0xC3) > 32768 and 'Capped' or data:unpack('H', 0xC3),
			Enhancing_Magic = data:unpack('H', 0xC5) > 32768 and 'Capped' or data:unpack('H', 0xC5),
			Enfeebling_Magic = data:unpack('H', 0xC7) > 32768 and 'Capped' or data:unpack('H', 0xC7),
			Elemental_Magic = data:unpack('H', 0xC9) > 32768 and 'Capped' or data:unpack('H', 0xC9),
			Dark_Magic = data:unpack('H', 0xCB) > 32768 and 'Capped' or data:unpack('H', 0xCB),
			Summoning_Magic = data:unpack('H', 0xCD) > 32768 and 'Capped' or data:unpack('H', 0xCD),
			Ninjutsu = data:unpack('H', 0xBF) > 32768 and 'Capped' or data:unpack('H', 0xBF),
			Singing = data:unpack('H', 0xD1) > 32768 and 'Capped' or data:unpack('H', 0xD1),
			Stringed_Instrument = data:unpack('H', 0xD3) > 32768 and 'Capped' or data:unpack('H', 0xD3),
			Wind_Instrument = data:unpack('H', 0xD5) > 32768 and 'Capped' or data:unpack('H', 0xD5),
			Blue_Magic = data:unpack('H', 0xC3) > 32768 and 'Capped' or data:unpack('H', 0xC3),
			Geomancy = data:unpack('H', 0xD9) > 32768 and 'Capped' or data:unpack('H', 0xD9),
			Handbell = data:unpack('H', 0xDB) > 32768 and 'Capped' or data:unpack('H', 0xDB),
			}
		initialize(window, box)
		updatedisplay()
		skill_cap(stopskilltyp[stopskill_count])
	end
	if id == 0x029 and data:unpack('H', 0x19) == 12 then
		send_command('setkey ctrl down;setkey n down;wait .1;setkey n up;setkey ctrl up')
	end
	-- if id == 0x00E then -- NPC Update
		-- if data:unpack('q', 0x0B, 1) then
			-- print("bit1")
		-- elseif data:unpack('q', 0x0B, 2) then
			-- print("bit2")
		-- elseif data:unpack('q', 0x0B, 3) then
			-- print("bit3")
		-- elseif data:unpack('q', 0x0B, 4) then
			-- print("bit4")
		-- elseif data:unpack('q', 0x0B, 5) then
			-- print("bit5")
		-- elseif data:unpack('q', 0x0B, 6) then
			-- print("bit6")
		-- elseif data:unpack('q', 0x0B, 7) then
			-- print("bit7")
		-- end
	-- end
	-- if id == 0x05B and data:unpack('C', 0x17) ~= 3 then
		-- add_to_chat(7,"treasure casket info = "..data:unpack('C', 0x18).." / "..data:unpack('I', 0x19))
	-- end
	if id == 0x0C8 then
		triggered = true
	end
	seqid = data:sub(3,4)
end
id_incoming_chunk = windower.raw_register_event('incoming chunk', incoming_chunk)
--Outgoing Chunk Event(Packets Sent)
function outgoing_chunk(id, data, modified, injected, blocked)
	local lastjob = player.main_job
	if id == 0x100 then
        -- local newmain = data:unpack('C', 0x05)
        -- if newmain <= 23 and newmain ~= 0 and newmain ~= player.main_job_id then
			main_job_change()
		-- end
	end
end
id_outgoing_chunk = windower.raw_register_event('outgoing chunk', outgoing_chunk)
--Target Change Event
function target_change(number)
    local target = windower.ffxi.get_mob_by_target("t")
    if autolock and target then
		if windower.ffxi.get_player().id == target.id then
			target.type = 'SELF'
		elseif target.is_npc then
			if target.id%4096>2047 then --divides 4096 by target.id to get remainder then check to see if remainder is higher the 2047
				target.type = 'NPC'
			else
				target.type = 'MONSTER'
			end
		else
			target.type = 'PLAYER'
		end
        if target.type == 'MONSTER' and not windower.ffxi.get_player().target_locked then
            send_command('input /lockon')
        end
    end
end
id_target_change = windower.raw_register_event('target change', target_change)