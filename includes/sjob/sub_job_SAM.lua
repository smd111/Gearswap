
    sets.sam_job = {left_ear='Haten Earring'}

function SJi_precast(spell,status,set_gear)
    if spell.english == 'Meditate' then
        if player.tp >= 2750 then
            status.end_spell=true
            status.end_event=true
            return
        end
    end
end