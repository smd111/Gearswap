require 'actions'
packets = require('packets')
partynames ={}
skill = {}
seqid = string.char(0,0)
skill_type = {'Axe','Club','Dagger','Great Axe','Great Katana','Great Sword','Hand-to-Hand','Katana','Polearm','Scythe','Staff','Sword','Archery','Marksmanship',
            'Throwing','Evasion','Guard','Parrying','Shield','Blue Magic','Dark Magic','Divine Magic','Elemental Magic','Enfeebling Magic','Enhancing Magic',
            'Geomancy','Handbell','Healing Magic','Ninjutsu','Singing','Stringed Instrument','Summoning Magic','Wind Instrument','Automaton Archery','Automaton Magic',
            'Automaton Melee'}
skill_count = 1

-- added events--
-- Action event
function Registered_Events_event_action(act)
    local action = Action(act)
    if action:get_category_string() == 'item_finish' then
        if action.raw.param == tbid and player.id == action.raw.actor_id then
            send_command('wait 1.0;input /ma "'..last_nin_spell..'" <me>')
            tool_bag_id = 0
        end
    end
end
--Registered_Events_action_id = windower.raw_register_event('action', Registered_Events_event_action)
-- LVL up event
function Registered_Events_level_up()
    if updatedisplay then
        coroutine.schedule(updatedisplay, 3)
    end
end
Registered_Events_level_up_id = windower.raw_register_event('level up', Registered_Events_level_up)
Registered_Events_level_down_id = windower.raw_register_event('level down', Registered_Events_level_up)
--Incoming Chunk Event(Packets Received)
function Registered_Events_incoming_chunk(id, data, modified, injected, blocked)
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
    if id == 0x062 then
        local packet = packets.parse('incoming', data)
        skill = packet
        if Display then
            updatedisplay()
        end
    end
    if id == 0x0C8 then
        triggered = true
    end
    seqid = data:sub(3,4)
end
Registered_Events_incoming_chunk_id = windower.raw_register_event('incoming chunk', Registered_Events_incoming_chunk)