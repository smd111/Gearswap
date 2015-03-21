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
    -- These are your Weapon sets
    sets.weapon['Axe'] = {main="",sub="",}
    sets.weapon['None'] = {main=empty,sub=empty,}
    -- These are your Range sets
    sets.range['Throwing'] = {range="Chakram",ammo=empty,}
    -- These are your Armor sets
    sets.armor['Basic'] = {} -- do not change this
    ---------------------------------------
    -- these are your base sets put in your
    -- default sets for status idle/resting
    -- /engaged (these must be here)
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
    --this include includes these set deviders
    --sets.pretarget = {}
    --sets.precast = {}
    --sets.midcast = {}
    --sets.aftercast = {}
    --sets.pet_midcast = {}
    --sets.pet_aftercast = {}
    ---------------------------------------
    --if you want to equip a specific set based
    --on the event creat your set like this
    --you only need to put in the gear that is
    --different from you sets above and thay will
    --be equiped automatically
    --Example: for spell "Fire"
    --sets.precast["Fire"] = {body="Outrider Mail",hands="Outrider Mittens",legs="Outrider Hose",}
    --if you need to have the sam4e gear in precast and midcast do this
    --sets.midcast["Fire"] = sets.precast["Fire"]
    ---------------------------------------
end
function mf_file_unload(status,set_gear,event_type,new_job)
    ---------------------------------------
    --put your file_unload rules here
    ---------------------------------------
    return
end
function mf_status_change(status,set_gear,event_type,new,old)
    ----------------------------------------
    --put your status_change rules here
    ----------------------------------------
    --add gear to change with
    --set_gear = set_combine(set_gear, <setname>)
    ----------------------------------------
    return set_gear
end
function mf_pet_change(status,set_gear,event_type,pet,gain)
    ---------------------------------------
    --put your pet_change rules here
    --to stop processing of all precast rules use: return set_gear
    ---------------------------------------
    --add gear to change with
    --set_gear = set_combine(set_gear, <setname>)
    ----------------------------------------
    return set_gear
end
function mf_filtered_action(status,set_gear,event_type,spell)
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
function mf_pretarget(status,set_gear,event_type,spell)
    ---------------------------------------
    --put your pretarget rules here
    ---------------------------------------
    --add gear to change with
    --set_gear = set_combine(set_gear, <setname>)
    ----------------------------------------
    return set_gear
end
function mf_precast(status,set_gear,event_type,spell)
    ---------------------------------------
    --put your precast rules here
    --to stop processing of all precast rules use: return set_gear
    ---------------------------------------
    --add gear to change with
    --set_gear = set_combine(set_gear, <setname>)
    ----------------------------------------
    return set_gear
end
function mf_buff_change(status,set_gear,event_type,name,gain,buff_table)
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
function mf_midcast(status,set_gear,event_type,spell)
    ---------------------------------------
    --put your midcast rules here
    --to stop processing of all midcast rules use: return set_gear
    ---------------------------------------
    --add gear to change with
    --set_gear = set_combine(set_gear, <setname>)
    ----------------------------------------
    return set_gear
end
function mf_pet_midcast(status,set_gear,event_type,spell,)
    ---------------------------------------
    --put your pet_midcast rules here
    --to stop processing of all pet_midcast rules use: return set_gear
    ---------------------------------------
    --add gear to change with
    --set_gear = set_combine(set_gear, <setname>)
    ----------------------------------------
    return set_gear
end
function mf_aftercast(status,set_gear,event_type,spell)
    ---------------------------------------
    --put your aftercast rules here
    --to stop processing of all aftercast rules use: return set_gear
    ---------------------------------------
    return set_gear
end
function mf_pet_aftercast(status,set_gear,event_type,spell)
    ---------------------------------------
    --put your pet_aftercast rules here
    --to stop processing of all pet_aftercast rules use: return set_gear
    ---------------------------------------
    return set_gear
end
function mf_self_command(status,set_gear,event_type,command)
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
function mf_sub_job_change(status,set_gear,event_type,new,old)
    ---------------------------------------
    --put your sub_job_change rules here
    ---------------------------------------
    return set_gear
end
function mf_indi_change(status,set_gear,event_type,indi_table,gain) -- only needed for Geo main/sub jobs
    ---------------------------------------
    --put your indi_change rules here
    ---------------------------------------
    return set_gear
end
function mf_zone_change(new,old) -- only when Registered_Events include is active
    ---------------------------------------
    --put your zone_change rules here
    --new string name of the new zone
    --old string name of the old zone
    ---------------------------------------
end
--These are examples only use if you know how to create a text display--
--[[ function custom_menu_update()
    local custom_rules_table = {}
    custom_rules_table.stepmt = Stepmaxt and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
    custom_rules_table.sstepst = Stopstepst and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
    return custom_rules_table
end]]
--[[ function custom_menu_build()
    local custom_properties = L{}
    custom_properties:append('-test6-')
    custom_properties:append('   Max Step ${stepmt}')
    custom_properties:append('   Stop Steps   ${sstepst}')
    return custom_properties
end]]
--[[ function custom_menu_commands(a))
    if menu_set == 6 then
        print(a)
    end
    if a == "{stepmt}" then
        Stepmaxt = not Stepmaxt
    elseif a == "{sstepst}" then
        Stopstepst = not Stopstepst
    end
end]]