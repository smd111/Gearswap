
    sets.drk_job = {neck='Nyx Gorget',left_ear='Chaotic Earring'}

function SJi_buff_change(name,gain,buff_table)
    if name == "Arcane Circle" then
        if gain then
            equip(sets.drk_job)
            disable("neck","left_ear")
        else
            enable("neck","left_ear")
            equip(sets[player.status])
        end
    end
end