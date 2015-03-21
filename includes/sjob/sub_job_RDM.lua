function SJi_precast(status,set_gear,event_type,spell)
    if table.contains(Cure.spells,spell.english) and spell.target.type == 'SELF' then
        if player.hpp <= 75 and player.mp >= 46 and player.sub_job_level >= 26 then
            if spell.english == 'Cure III' then
                send_command('@input /ma "Cure III" <me>')
                status.end_spell=true
                status.end_event=true
                return set_gear
            end
        elseif player.hpp <= 75 and player.mp >= 24 and player.sub_job_level >= 14 then
            if spell.english == 'Cure II' then
                send_command('@input /ma "Cure II" <me>')
                status.end_spell=true
                status.end_event=true
                return set_gear
            end
        elseif player.hpp <= 75 and player.mp >= 8 and player.sub_job_level >= 3 then
            if spell.english == 'Cure' then
                send_command('@input /ma "Cure" <me>')
                status.end_spell=true
                status.end_event=true
                return set_gear
            end
        else
            status.end_spell=true
            status.end_event=true
        end
    end
    return set_gear
end