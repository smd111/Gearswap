--include setup -------------------------------------------------------------------------------------------------------------------
function include_setup()
    --Disable All Includes (Default: false)
    Disable_All = false
    --Use Display Include (Default: true)
    Display = true
    --Start with minimized window (Default: false)
    window_hidden = true
    -----------------------------------------------------------------------------------------------------------------------------------
    jobneck = {neck={ name="Magus Torque", augments={'MP+10','Mag. Acc.+1',}},} --if using the conquest include put the neck that you want as your main neck when conquest neck is not needed
    jobring = {left_ring="Onyx Ring",} --if using the conquest include put the left_ring that you want as your main ring when conquest ring is not needed
    -- example:
    -- jobneck = {neck={ name="Wivre Gorget", augments={'"Subtle Blow"+4','MP+3',}},}
    -- jobring = {left_ring="Prouesse Ring",}
end
include('includes/Include.lua')
--Job functions
function gear_setup()
    ---------------------------------------
    -- add more weapon modes with this add_weapon_modes = {'name1','name2'}
    -- called with armor_types[armor_types_count]
    -- 'Axe, Club, Dagger, Great_Axe, Great_Sword, Hand-to-Hand, Polearm, Scythe, Staff, Sword, Great_Katana, Katana, Reserve, None are already included
    -- if you dont plan on using it remove or comment out
    ---------------------------------------
    sets.weapon['Axe'] = {main="",sub="",}
    -- sets.weapon['Club'] = {main="",sub="",}
    -- sets.weapon['Dagger'] = {main="",sub="",}
    -- sets.weapon['Great_Axe'] = {main="",sub="",}
    -- sets.weapon['Great_Sword'] = {main="",sub="",}
    -- sets.weapon['Hand-to-Hand'] = {main="",sub="",}
    -- sets.weapon['Great_Katana'] = {main="",sub="",}
    -- sets.weapon['Katana'] = {main="",sub="",}
    -- sets.weapon['Polearm'] = {main="",sub="",}
    -- sets.weapon['Scythe'] = {main="",sub="",}
    -- sets.weapon['Staff'] = {main="",sub="",}
    -- sets.weapon['Sword'] = {main="",sub="",}
    -- sets.weapon['Reserve'] = {main="",sub="",}
    sets.weapon['None'] = {main=empty,sub=empty,}
    ---------------------------------------
    -- add more range modes with this add_range_modes = {'name1','name2'}
    -- called with range_types[range_types_count]
    -- Archery, Marksmanship, Throwing, Fishing, Soultrapper, Wind_Instruments, String_Instruments, Handbells, Other are already included
    -- if you dont plan on using it remove or comment out
    ---------------------------------------
    -- sets.range['Archery'] = {range="",ammo="",}
    -- sets.range['Marksmanship'] = {range="",ammo="",}
    sets.range['Throwing'] = {range="Chakram",ammo=empty,}
    -- sets.range['Fishing'] = {range="",ammo="",}
    -- sets.range['Soultrapper'] = {range="",ammo="",}
    -- sets.range['Wind Instruments'] = {range="",ammo="",}
    -- sets.range['String Instruments'] = {range="",ammo="",}
    -- sets.range['Handbells'] = {range="",ammo="",}
    -- sets.range['Other'] = {range="",ammo="",}
    ---------------------------------------
    -- add more armor modes with this add_armor_modes = {'name1','name2'}
    -- called with armor_types[armor_types_count]
    -- Basic is already included
    -- if you dont plan on using it remove or comment out
    ---------------------------------------
    sets.armor['Basic'] = {} -- do not change this
    ---------------------------------------
    -- these are your base sets put in your
    -- default sets for status idle/resting
    -- engaged (these must be here)
    ---------------------------------------
    sets.Engaged = {
        head="",
        body="",
        hands="",
        legs="",
        feet="",
        neck="",
        waist="",
        left_ear="",
        right_ear="",
        left_ring="",
        right_ring="",
        back="",
    }
    sets.Idle = {
        head="",
        body="",
        hands="",
        legs="",
        feet="",
        neck="",
        waist="",
        left_ear="",
        right_ear="",
        left_ring="",
        right_ring="",
        back="",
    }
    sets.Resting = {
        head="",
        body="",
        hands="",
        legs="",
        feet="",
        neck="",
        waist="",
        left_ear="",
        right_ear="",
        left_ring="",
        right_ring="",
        back="",
    }
    ---------------------------------------
    --put your other sets here
    ---------------------------------------
end
function mf_file_unload(new_job)
    ---------------------------------------
    --put your file_unload rules here
    ---------------------------------------
    return
end
function mf_status_change(new,old,status,set_gear)
    ----------------------------------------
    --put your status_change rules here
    ----------------------------------------
    --add gear to change with
    --set_gear = set_combine(set_gear, <setname>)
    ----------------------------------------
    return set_gear
end
function mf_pet_change(pet,gain,status,set_gear)
    ---------------------------------------
    --put your pet_change rules here
    --to stop processing of all precast rules use: return set_gear
    ---------------------------------------
    --add gear to change with
    --set_gear = set_combine(set_gear, <setname>)
    ----------------------------------------
    return set_gear
end
function mf_filtered_action(spell,status,set_gear)
    ---------------------------------------
    --put your filtered_action rules here
    --to stop processing of all filtered_action rules use: return set_gear
    ---------------------------------------
    --does not change gear as any thing
    --that comes in to this function
    --is a spell/ability your current job
    --does not have
    ----------------------------------------
    return set_gear
end
function mf_pretarget(spell,status,set_gear)
    ---------------------------------------
    --put your pretarget rules here
    ---------------------------------------
    --add gear to change with
    --set_gear = set_combine(set_gear, <setname>)
    ----------------------------------------
    return set_gear
end
function mf_precast(spell,status,set_gear)
    ---------------------------------------
    --put your precast rules here
    --to stop processing of all precast rules use: return set_gear
    ---------------------------------------
    --add gear to change with
    --set_gear = set_combine(set_gear, <setname>)
    ----------------------------------------
    return set_gear
end
function mf_buff_change(name,gain,buff_table,status,set_gear)
    ---------------------------------------
    --put your buff_change rules here
    ---------------------------------------
    --change gear with
    --equip(<setname>)
    ----------------------------------------
    --recomended equip when loss of buff
    --equip(sets[player.status], sets.weapon[weapon_types[player.main_job][weapon_types_count]])
    ----------------------------------------
    return set_gear
end
function mf_midcast(spell,status,set_gear)
    ---------------------------------------
    --put your midcast rules here
    --to stop processing of all midcast rules use: return set_gear
    ---------------------------------------
    --add gear to change with
    --set_gear = set_combine(set_gear, <setname>)
    ----------------------------------------
    return set_gear
end
function mf_pet_midcast(spell,status,set_gear)
    ---------------------------------------
    --put your pet_midcast rules here
    --to stop processing of all pet_midcast rules use: return set_gear
    ---------------------------------------
    --add gear to change with
    --set_gear = set_combine(set_gear, <setname>)
    ----------------------------------------
    return set_gear
end
function mf_aftercast(spell,status,set_gear)
    ---------------------------------------
    --put your aftercast rules here
    --to stop processing of all aftercast rules use: return set_gear
    ---------------------------------------
    return set_gear
end
function mf_pet_aftercast(spell,status,set_gear)
    ---------------------------------------
    --put your pet_aftercast rules here
    --to stop processing of all pet_aftercast rules use: return set_gear
    ---------------------------------------
    return set_gear
end
function mf_self_command(command)
    ---------------------------------------
    --put your self_command rules here
    ---------------------------------------
    if type(command) == 'table' then
        if command[1]:lower() == 'set' or command[1]:lower() == 's' then
            --put commands that you want to the set command for example: gs c s stepmax 3 note: changes the variable directly to what you want
            --example code:
            -- if command[2]:lower() == 'stepmax' then
                -- Stepmax = tonumber(command[3])
                -- add_to_chat(7,'Max step = ' ..Stepmax)
            -- end
        elseif command[1]:lower() == 'cycle' or command[1]:lower() == 'c' then
            --put commands that you want to the cycle command for example: gs c c stepmax note: for cycling through all posible variables
            --example code:
            -- if command[2]:lower() == 'stepmax' then
                -- Stepmax = (Stepmax % 5) + 1
                -- add_to_chat(7,'Max step = ' ..Stepmax)
            -- end
        elseif command[1]:lower() == 'toggle' or command[1]:lower() == 't' then
            --put commands that you want to the toggle command for example: gs c t stopsteps note: onle needed fot true/false variable
            --example code:
            -- if command == 'stopsteps' then
                -- Stopsteps = not Stopsteps
                -- add_to_chat(7, '----- Steps Will ' .. (Stopsteps and '' or 'Not ') .. 'Stop -----')
            -- end
        end
    else
        --put all other commands here example: gs c tstopsteps note: this is for single string commands
        --example code:
        -- if command == 'tstopsteps' then
            -- Stopsteps = not Stopsteps
            -- add_to_chat(7, '----- Steps Will ' .. (Stopsteps and '' or 'Not ') .. 'Stop -----')
        -- end
    end
end
function mf_sub_job_change(new,old,status,set_gear)
    ---------------------------------------
    --put your sub_job_change rules here
    ---------------------------------------
    return set_gear
end
function mf_indi_change(indi_table,gain,status,set_gear) -- only needed for Geo main/sub jobs
    ---------------------------------------
    --put your indi_change rules here
    ---------------------------------------
    return set_gear
end
--[[ function custom_menu_update()
    local custom_rules_table = {}
    if SJi then
        custom_rules_table.stepm = Stepmax
        custom_rules_table.ssteps = Stopsteps and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
    end
    if WSi then
        custom_rules_table.cstaff = Changestaff and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
        custom_rules_table.ustaff = Usestaff
    end
    if Conquest_Gear then
        custom_rules_table.cneckc = Conquest.neck.change and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
        custom_rules_table.cringc = Conquest.ring.change and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
        custom_rules_table.cneck = Conquest.neck.case[Conquest.neck.case_id]
        custom_rules_table.cring = Conquest.ring.case[Conquest.ring.case_id]
    end
    custom_rules_table.mjob = windower.ffxi.get_player().main_job_full
    custom_rules_table.mjob_lvl = windower.ffxi.get_player().main_job_level
    return custom_rules_table
end]]
--[[ function custom_menu_build()
    local properties = L{}
        if windower.ffxi.get_player().sub_job == 'DNC' and SJi then
            properties:append('-Steps-')
            properties:append('   Max Step = ${stepm}')
            properties:append('   Stop Steps   ${ssteps}')
        end
        if windower.wc_match(windower.ffxi.get_player().main_job, "WHM|BLM|RDM|BRD|SMN|SCH|GEO") and WSi then
            properties:append('Staves')
            properties:append('  Will ${cstaff}Change')
            properties:append('Staves Set To ${ustaff}')
        end
        if Conquest_Gear then
            properties:append('Conquest Neck')
            properties:append('  Will ${cneckc}Change')
            properties:append('Conquest Ring')
            properties:append('  Will ${cringc}Change')
            properties:append('Conquest')
            properties:append('  Neck Type = ${cneck}')
            properties:append('  Ring Type = ${cring}')
        end
        if lvlwatch then
            properties:append('${mjob}')
            properties:append('   lvl = ${mjob_lvl}')
        end
    return properties
end]]
--[[ function custom_menu_commands(a)
    print('a='..a)
end]]