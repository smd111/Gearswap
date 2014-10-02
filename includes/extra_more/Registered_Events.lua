require 'actions'
partynames ={}
seqid = string.char(0,0)

-- added events--
-- Action event
function event_action(act)
	local action = Action(act)
    if action:get_category_string() == 'item_finish' then
        if action.raw.param == tbid and player.id == action.raw.actor_id then
			send_command('wait 1.0;input /ma "'..last_nin_spell..'" <me>')
			tool_bag_id = 0
		end
    end
end
windower.raw_register_event('action', event_action)
-- LVL up event
function level_up()
	if updatedisplay then
		coroutine.schedule(updatedisplay, 3)
	end
end
windower.raw_register_event('level up', level_up)
windower.raw_register_event('level down', level_up)
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
	if id == 0x0C8 then
		triggered = true
	end
	seqid = data:sub(3,4)
end
windower.raw_register_event('incoming chunk', incoming_chunk)
--Target Change Event
function target_change(number)
    local target = windower.ffxi.get_mob_by_target("t")
    if autolock and target then
		if windower.ffxi.get_player().id == target.id then
			target.type = 'SELF'
		elseif target.is_npc then
			if target.id%4096>2047 then
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
windower.raw_register_event('target change', target_change)