--include setup -------------------------------------------------------------------------------------------------------------------
function include_setup()
    --Disable All Includes (Default: false)
    Disable_All = false
    --Use Display Include (Default: true)
    Display = true
    --Start with minimized window (Default: false)
    window_hidden = true
end
include('organizer-lib')
include('SMDinclude/includes/Include.lua')
--Job functions
function gear_setup()
    sets["Waltz"] = {} -- use this set for all Waltz
    sets.weapon['Great_Katana'] = {main="Ichimonji-Yofusa",sub="Danger Grip"}
    sets.weapon['None'] = {main=empty,sub=empty}
    sets.range['Archery'] = {range="Shortbow",ammo="Iron Arrow"}
    sets.armor['Basic'] = {}
    sets.armor['Capacity_Points'] = {back="Aptitude Mantle +1",}
    sets.Engaged = {
        head="Outrider Mask",
        body="Outrider Mail",
        hands="Outrider Mittens",
        legs="Outrider Hose",
        feet="Outrider Greaves",
        neck={ name="Wivre Gorget", augments={'"Subtle Blow"+4','MP+3',}},
        waist="Marid Belt",
        left_ear="Impreg. Earring",
        right_ear="Upsurge Earring",
        left_ring="Vehemence Ring",
        right_ring="Enlivened Ring",
        back="Unkai Sugemino",
        }
    sets.Idle = {
        head="Outrider Mask",
        body="Outrider Mail",
        hands="Outrider Mittens",
        legs="Outrider Hose",
        feet="Danzo Sune-Ate",
        neck={ name="Wivre Gorget", augments={'"Subtle Blow"+4','MP+3',}},
        waist="Marid Belt",
        left_ear="Impreg. Earring",
        right_ear="Upsurge Earring",
        left_ring="Vehemence Ring",
        right_ring="Enlivened Ring",
        back="Unkai Sugemino",
        }
    sets.Resting = {
        head="Outrider Mask",
        body="Outrider Mail",
        hands="Outrider Mittens",
        legs="Outrider Hose",
        feet="Danzo Sune-Ate",
        neck={ name="Wivre Gorget", augments={'"Subtle Blow"+4','MP+3',}},
        waist="Marid Belt",
        left_ear="Sanative Earring",
        right_ear="Terminus Earring",
        left_ring="Vehemence Ring",
        right_ring="Enlivened Ring",
        back="Unkai Sugemino",
        }
end
function mf.file_load()
    if windower.ffxi.get_info().mog_house then
        send_command('gs org')
    end
end
function mf.file_unload(new_job)
end
function mf.status_change(status,current_event,new,old)
end
function mf.pet_change(status,current_event,pet,gain)
end
function mf.filtered_action(status,current_event,spell)
end
function mf.pretarget(status,current_event,spell)
end
function mf.precast(status,current_event,spell)
    if spell.en == 'Meditate' and (player.tp >= 2750 or buffactive['Invisible']) then
        status.end_spell=true
        status.end_event=true
        return set_gear
    end
    if spell.action_type == "Ranged Attack" then
        sets.building[current_event] = set_combine(sets.building[current_event], {left_ring="Fistmele Ring",right_ring="Longshot Ring"})
    end
end
function mf.buff_change(status,current_event,name,gain,buff_table)
end
function mf.midcast(status,current_event,spell)
    if spell.action_type == "Ranged Attack" then
        sets.building[current_event] = set_combine(sets.building[current_event], {left_ring="Fistmele Ring",right_ring="Longshot Ring"})
    end
end
function mf.pet_midcast(status,current_event,spell)
end
function mf.aftercast(status,current_event,spell)
end
function mf.pet_aftercast(status,current_event,spell)
end
function mf.self_command(command)
end