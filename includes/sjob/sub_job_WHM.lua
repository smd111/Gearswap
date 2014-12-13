function SJi_precast(spell,status,set_gear)
    if Cure.spells:contains(spell.english) and spell.target.type == 'SELF' then
        if player.hpp <= 75 and player.mp >= 88 and player.sub_job_level >= 41 then
            if spell.english ~= 'Cure IV' then
                send_command('@input /ma "Cure IV" <me>')
                status.end_spell=true
                status.end_event=true
                return
            end
        elseif player.hpp <= 75 and player.mp >= 46 and player.sub_job_level >= 21 then
            if spell.english ~= 'Cure III' then
                send_command('@input /ma "Cure III" <me>')
                status.end_spell=true
                status.end_event=true
                return
            end
        elseif player.hpp <= 75 and player.mp >= 24 and player.sub_job_level >= 11 then
            if spell.english ~= 'Cure II' then
                send_command('@input /ma "Cure II" <me>')
                status.end_spell=true
                status.end_event=true
                return
            end
        elseif player.hpp <= 75 and player.mp >= 8 and player.sub_job_level >= 1 then
            if spell.english ~= 'Cure' then
                send_command('@input /ma "Cure" <me>')
                status.end_spell=true
                status.end_event=true
                return
            end
        else
            status.end_spell=true
        end
    end
end