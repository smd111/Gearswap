
    sets.drg_job = {body="Barone Corazza",legs="Barone Cosciales"}

function SJi_precast(status,set_gear,spell)
    if spell.english == 'Jump' then
        set_gear = set_combine(set_gear, sets.drg_job)
    end
    if spell.english == 'High Jump' then
        set_gear = set_combine(set_gear, sets.drg_job)
    end
    return set_gear
end