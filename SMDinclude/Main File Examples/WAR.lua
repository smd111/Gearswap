--include setup -------------------------------------------------------------------------------------------------------------------
function include_setup()
    --Disable All Includes (Default: false)
    Disable_All = false
    --Use Display Include (Default: true)
    Display = true
    --Start with minimized window (Default: false)
    window_hidden = true
end
include('includes/Include.lua')
--Job functions
function gear_setup()
    waltz_stats = {vit=64,chr=77} --these are the stats need to calulate curing waltz hp recovery
    sets.weapon['Axe'] = {main="Eminent Axe",sub="Eminent Scimitar"}
    sets.weapon['Dagger'] = {main="Eminent Dagger",sub="Eminent Scimitar"}
    sets.weapon['Great_Axe'] = {main="Eminent Voulge",sub="Uther's Grip"}
    sets.weapon['Great_Sword'] = {main="Eminent Sword",sub="Uther's Grip"}
    sets.weapon['Hand-to-Hand'] = {main="Em. Baghnakhs",ammo=empty}
    sets.weapon['Scythe'] = {main="Eminent Sickle",sub="Uther's Grip"}
    sets.weapon['Sword'] = {main="Eminent Scimitar",sub="Eminent Dagger"}
    sets.weapon['None'] = {main=empty,sub=empty}
    sets.range['Marksmanship'] = {range="Lion Crossbow",ammo="Crossbow Bolt"}
    sets.range['Throwing'] = {range="Snakeeye",ammo=empty}
    sets.armor['Basic'] = {}
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
    left_ring="Enlivened Ring",
    right_ring="Vehemence Ring",
    back="Cerberus Mantle",
    }
    sets.Idle = {
    head="Outrider Mask",
    body="Outrider Mail",
    hands="Outrider Mittens",
    legs="Outrider Hose",
    feet="Outrider Greaves",
    neck={ name="Wivre Gorget", augments={'"Subtle Blow"+4','MP+3',}},
    waist="Marid Belt",
    left_ear="Impreg. Earring",
    right_ear="Upsurge Earring",
    left_ring="Enlivened Ring",
    right_ring="Vehemence Ring",
    back="Cerberus Mantle",
    }
    sets.Resting = {
    head="Outrider Mask",
    body="Outrider Mail",
    hands="Outrider Mittens",
    legs="Outrider Hose",
    feet="Outrider Greaves",
    neck={ name="Wivre Gorget", augments={'"Subtle Blow"+4','MP+3',}},
    waist="Marid Belt",
    left_ear="Sanative Earring",
    right_ear="Upsurge Earring",
    left_ring="Enlivened Ring",
    right_ring="Vehemence Ring",
    back="Cerberus Mantle",
    }
    sets.precast['Tomahawk'] = {range=empty,ammo="Thr. Tomahawk"}
end
function mf.file_load()
    if windower.ffxi.get_info().mog_house then
        send_command('org organize')
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
    if spell.type == "WeaponSkill" and aggro_count() >= 2 and spell.name ~= "Fell Cleave" then
        status.end_event=true
        status.end_spell=true
        send_command('input /ws "Fell Cleave" <t>')
    end
    if spell.en == 'Spectral Jig' then
        send_command('cancel 71')
    end
end
function mf.precast(status,current_event,spell)
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
function mf.self_command(status,current_event,command)
end