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
    sets.weapon['Staff'] = {main="Eminent Staff",sub="Danger Grip"}
    sets.weapon['None'] = {main=empty,sub=empty}
    sets.range['Other'] = {range="",ammo=""}
    sets.armor['Basic'] = {}
    sets.armor['Capacity_Points'] = {back="Aptitude Mantle +1",}
    sets.Engaged = {
        head="Tema. Headband",
        body="Temachtiani Shirt",
        hands="Temachtiani Gloves",
        legs="Temachtiani Pants",
        feet="Temachtiani Boots",
        neck={ name="Wivre Gorget", augments={'"Subtle Blow"+4','MP+3',}},
        waist={ name="Tarutaru Sash", augments={'CHR+2','INT+2','HP+15',}},
        left_ear="Liminus Earring",
        right_ear="Ardent Earring",
        left_ring="Rajas Ring",
        right_ring="Prouesse Ring",
        back="Jester's Cape",
        }
    sets.Idle = {
        head="Tema. Headband",
        body="Temachtiani Shirt",
        hands="Temachtiani Gloves",
        legs="Temachtiani Pants",
        feet="Temachtiani Boots",
        neck={ name="Wivre Gorget", augments={'"Subtle Blow"+4','MP+3',}},
        waist={ name="Tarutaru Sash", augments={'CHR+2','INT+2','HP+15',}},
        left_ear="Liminus Earring",
        right_ear="Ardent Earring",
        left_ring="Rajas Ring",
        right_ring="Prouesse Ring",
        back="Jester's Cape",
        }
    sets.Resting = {
        head="Tema. Headband",
        body="Temachtiani Shirt",
        hands="Temachtiani Gloves",
        legs="Temachtiani Pants",
        feet="Temachtiani Boots",
        neck={ name="Wivre Gorget", augments={'"Subtle Blow"+4','MP+3',}},
        waist={ name="Tarutaru Sash", augments={'CHR+2','INT+2','HP+15',}},
        left_ear="Liminus Earring",
        right_ear="Relaxing Earring",
        left_ring="Rajas Ring",
        right_ring="Prouesse Ring",
        back="Jester's Cape",
        }
end
function mf.file_load()
    if windower.ffxi.get_info().mog_house then
        send_command('gs org')
    end
end
function mf.precast(status,current_event,spell)
    if spell.action_type == "Ranged Attack" then
        sets.building[current_event] = set_combine(sets.building[current_event], {left_ring="Fistmele Ring",right_ring="Longshot Ring"})
    elseif spell.action_type == "Magic" then
        sets.building[current_event] = set_combine(sets.building[current_event], {left_ring="Acumen Ring",right_ring="Perception Ring"})
    end
end
function mf.buff_change(status,current_event,name,gain,buff_table)
    if Curenegstat then
        if name == 'blindness' and gain then
            send_command('@input /ma "Blindna" <me>')
        elseif (name == 'curse' or name == 'bane') and gain then
            send_command('@input /ma "Cursna" <me>')
        elseif name == 'paralysis' and gain then
            send_command('@input /ma "Paralyna" <me>')
        elseif name == 'poison' and gain then
            send_command('@input /ma "Poisona" <me>')
        elseif name == 'petrification' and gain then
            send_command('@input /ma "Stona" <me>')
        elseif (name == 'disease' or name == 'plague') and gain then
            send_command('@input /ma "Viruna" <me>')
        end
    end
end
function mf.midcast(status,current_event,spell)
    if spell.action_type == "Ranged Attack" then
        sets.building[current_event] = set_combine(sets.building[current_event], {left_ring="Fistmele Ring",right_ring="Longshot Ring"})
    elseif spell.action_type == "Magic" then
        sets.building[current_event] = set_combine(sets.building[current_event], {left_ring="Acumen Ring",right_ring="Perception Ring"})
    end
end
function mf.self_command(command)
    if command == 'tcurenegstat' then
        Curenegstat = not Curenegstat
        add_to_chat(123,'----- WILL ' .. (Curenegstat and '' or 'NOT ') .. 'AUTO CURE NEGITAVE STATUS -----')
    end
end
function mf.save()
    local save = '\nCurenegstat = '..tostring(Curenegstat or false)
    return save
end
function custom_menu_update()
    local custom_rules_table = {}
    custom_rules_table.curenegstat = Curenegstat and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
    return custom_rules_table
end
function custom_menu_build()
    local custom_properties = L{}
    custom_properties:append('Auto cure -Status ${curenegstat}')
    return custom_properties
end
function custom_menu_commands(com)
    if com == "{curenegstat}" then
        Curenegstat = not Curenegstat
    end
end