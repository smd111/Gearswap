--include setup -------------------------------------------------------------------------------------------------------------------
function include_setup()
    --Disable All Includes (Default: false)
    Disable_All = false
    --Use Display Include (Default: true)
    Display = true
    --Start with minimized window (Default: false)
    window_hidden = true
end
include('SMDinclude/includes/Include.lua')
--Job functions
function gear_setup()
    sets["Waltz"] = {} -- use this set for Waltz
    sets.weapon['Hand-to-Hand'] = {main="Em. Baghnakhs",sub=empty}
    sets.weapon['None'] = {main=empty,sub=empty}
    sets.range['Other'] = {range="Em. Animator",ammo=empty}
    sets.armor['Basic'] = {}
    sets.Engaged = {
    head="Tema. Headband",
    body="Temachtiani Shirt",
    hands="Temachtiani Gloves",
    legs="Temachtiani Pants",
    feet="Temachtiani Boots",
    neck={ name="Wivre Gorget", augments={'"Subtle Blow"+4','MP+3',}},
    waist="Mrc.Cpt. Belt",
    left_ear="Upsurge Earring",
    right_ear="Impreg. Earring",
    left_ring="Enlivened Ring",
    right_ring="Vehemence Ring",
    back="Rainbow Cape",
    }
    sets.Idle = {
    head="Tema. Headband",
    body="Temachtiani Shirt",
    hands="Temachtiani Gloves",
    legs="Temachtiani Pants",
    feet="Temachtiani Boots",
    neck={ name="Wivre Gorget", augments={'"Subtle Blow"+4','MP+3',}},
    waist="Mrc.Cpt. Belt",
    left_ear="Upsurge Earring",
    right_ear="Impreg. Earring",
    left_ring="Enlivened Ring",
    right_ring="Vehemence Ring",
    back="Rainbow Cape",
    }
    sets.Resting = {
    head="Tema. Headband",
    body="Temachtiani Shirt",
    hands="Temachtiani Gloves",
    legs="Temachtiani Pants",
    feet="Temachtiani Boots",
    neck={ name="Wivre Gorget", augments={'"Subtle Blow"+4','MP+3',}},
    waist="Mrc.Cpt. Belt",
    left_ear="Upsurge Earring",
    right_ear="Sanative Earring",
    left_ring="Enlivened Ring",
    right_ring="Vehemence Ring",
    back="Rainbow Cape",
    }
end
function mf.file_load()
    send_command('lua load PetTP') if windower.ffxi.get_info().mog_house then send_command('org organize') end
end
function mf.file_unload(new_job)
    if not S{'BST','PUP','GEO','DRG','SMN'}:contains(new_job) then send_command('lua unload PetTP') end
end
function mf.status_change(status,current_event,new,old)
end
function mf.pet_change(status,current_event,pet,gain)
end
function mf.filtered_action(status,current_event,spell)
end
function mf.pretarget(status,current_event,spell)
    if spell.type == "WeaponSkill" and aggro_count() >= 2 and spell.name ~= "Spinning Attack" then 
        status.end_event=true status.end_spell=true
        send_command('input /ws "Spinning Attack" <t>')
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
function mf.save()
    local save = '\nEnable_auto_pup = '..tostring(Enable_auto_pup or false)..
    '\nEnable_pup_skill_up = '..tostring(Enable_pup_skill_up or false)
    return save
end
function custom_menu_update()
    local custom_rules_table = {}
    custom_rules_table.eap = Enable_auto_pup and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
    if Enable_auto_pup then custom_rules_table.esku = Enable_pup_skill_up and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr' end
    return custom_rules_table
end
function custom_menu_build()
    local custom_properties = L{}
    custom_properties:append('Enable Auto Pup ${eap}')
    if Enable_auto_pup then custom_properties:append('Auto Skill Up Maneuver\'s ${esku}') end
    return custom_properties
end
function custom_menu_commands(a)
    if a == "{eap}" then Enable_auto_pup = not Enable_auto_pup
    elseif a == "{esku}" then Enable_pup_skill_up = not Enable_pup_skill_up
    end
end
function
windower.raw_register_event('prerender', function()
    if Enable_auto_pup and (os.clock()-log_in_time) >= 10 then
        if check_recast('ability',205) and not pet.isvalid then send_command('input /ja "Activate" <me>')
        elseif pet.isvalid and player.hpp > 75 and pet.hpp < 25 and check_recast('ability',211) then send_command('input /ja "Role Reversal" <me>')
        elseif player.in_combat then
            if pet.status ~= 'Engaged' then send_command('input /ja "Deploy" <t>')
            elseif check_recast('ability',114) and buffactive['Overload'] then send_command('input /ja "Cooldown" <t>')
            elseif check_recast('ability',210) and not buffactive['Overload'] then 
                if Enable_pup_skill_up then
                    -- if not buffactive['Water Maneuver'] then send_command('input /ja "Water Maneuver" <me>') --skill up 1
                    if buffactive['Water Maneuver'] ~= 2 then send_command('input /ja "Water Maneuver" <me>') --skill up x2
                    elseif not buffactive['Light Maneuver'] then send_command('input /ja "Light Maneuver" <me>') --HP
                    -- elseif buffactive['Dark Maneuver'] ~= 2 then send_command('input /ja "Dark Maneuver" <me>') -- MP
                    end
                end
            end
        end
    end
end)