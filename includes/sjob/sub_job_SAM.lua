
    sets.sam_job = {left_ear='Haten Earring'}

function SJi_precast(spell,status,set_gear)
    if spell.en == 'Meditate' and (player.tp >= 2750 or buffactive['Invisible']) then
        status.end_spell=true
        status.end_event=true
        return set_gear
    end
    return set_gear
end