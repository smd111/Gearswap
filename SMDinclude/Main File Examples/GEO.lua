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
    if dwsj() then
        sets.weapon['Club'] = {main="Rose Wand",sub="Rose Wand"}
    end
    sets.weapon['None'] = {main=empty,sub=empty}
    sets.range['Handbells'] = {range="Matre Bell",ammo=empty}
    sets.armor['Basic'] = {}
    sets.armor['Capacity_Points'] = {back="Aptitude Mantle +1",}
    sets.Engaged = {
        head="Tct.Mgc. Hat",
        body="Tct.Mgc. Coat",
        hands="Tct.Mgc. Cuffs",
        legs="Tct.Mgc. Slops",
        feet="Tct.Mgc. Pigaches",
        waist="Mrc.Cpt. Belt",
        left_ear="Ardent Earring",
        right_ear="Zircon Earring",
        left_ring="Rajas Ring",
        right_ring="Bastokan Ring",
        }
    sets.Idle = {
        head="Tct.Mgc. Hat",
        body="Tct.Mgc. Coat",
        hands="Tct.Mgc. Cuffs",
        legs="Tct.Mgc. Slops",
        feet="Tct.Mgc. Pigaches",
        waist="Mrc.Cpt. Belt",
        left_ear="Ardent Earring",
        right_ear="Zircon Earring",
        left_ring="Rajas Ring",
        right_ring="Bastokan Ring",
        }
    sets.Resting = {
        head="Tct.Mgc. Hat",
        body="Tct.Mgc. Coat",
        hands="Tct.Mgc. Cuffs",
        legs="Tct.Mgc. Slops",
        feet="Tct.Mgc. Pigaches",
        waist="Mrc.Cpt. Belt",
        left_ear="Ardent Earring",
        right_ear="Zircon Earring",
        left_ring="Rajas Ring",
        right_ring="Bastokan Ring",
        }
end
function mf.file_load()
    send_command('lua load PetTP')
    if windower.ffxi.get_info().mog_house then
        send_command('gs org')
    end
end
function mf.file_unload(new_job)
    if not S{'BST','PUP','GEO','DRG','SMN'}:contains(new_job) then
        send_command('lua unload PetTP')
    end
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
    if spell.action_type == "Ranged Attack" then
        sets.building[current_event] = set_combine(sets.building[current_event], {left_ring="Fistmele Ring",right_ring="Longshot Ring"})
    elseif spell.action_type == "Magic" then
        sets.building[current_event] = set_combine(sets.building[current_event], {left_ring="Acumen Ring",right_ring="Perception Ring"})
    end
end
function mf.buff_change(status,current_event,name,gain,buff_table)
end
function mf.midcast(status,current_event,spell)
    if spell.action_type == "Ranged Attack" then
        sets.building[current_event] = set_combine(sets.building[current_event], {left_ring="Fistmele Ring",right_ring="Longshot Ring"})
    elseif spell.action_type == "Magic" then
        sets.building[current_event] = set_combine(sets.building[current_event], {left_ring="Acumen Ring",right_ring="Perception Ring"})
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
function mf.indi_change(indi_table,gain,status,set_gear)
end