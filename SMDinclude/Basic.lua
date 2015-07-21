--include setup -----------------------------------------------------------------------------------------------------------------
function include_setup()
    --Disable All Includes (Default: false)
    Disable_All = false
    --Use Display Include (Default: true)
    Display = true
    --Start with minimized window (Default: false)
    window_hidden = false
end
include('includes/Include.lua')
--Job functions
function gear_setup()
    sets["Waltz"] = {} -- use this set for Curing Waltz I/II/II/IV/V
    sets.weapon['Axe'] = {main="",sub=""}
    sets.weapon['None'] = {main=empty,sub=empty}
    -- These are your Range sets (you can add as many as you want)
    sets.range['Throwing'] = {range="",ammo=empty}
    -- These are your Armor sets (you can add as many as you want)
    sets.armor['Basic'] = {} -- do not change this
    ---------------------------------------
    -- these are your base sets put in your
    -- default sets for status idle/resting
    -- engaged/Idle/Resting (these must be here)
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
    --this include includes these set dividers
    --sets.pretarget = {}
    --sets.precast = {}
    --sets.midcast = {}
    --sets.aftercast = {}
    --sets.pet_midcast = {}
    --sets.pet_aftercast = {}
    ---------------------------------------
    --if you want to equip a specific set based
    --on the event create your set like this
    --you only need to put in the gear that is
    --different from your sets above and they will
    --be equipped automatically
    --Example: for spell "Fire"
    --sets.precast["Fire"] = {body="Outrider Mail",hands="Outrider Mittens",legs="Outrider Hose",}
    --if you need to have the same gear in precast and midcast do this
    --sets.midcast["Fire"] = sets.precast["Fire"]
    ---------------------------------------
end
function mf.file_load()
    ---------------------------------------
    --put your file_load rules here
    --everything here will happen 1.5 seconds
    --after gearswap loads your file
    --i use this for my commands like
    --loading extra plugins and running Organizer's
    --commands
    ---------------------------------------
    --Example: 
    --send_command('org organize')
    --send_command('lua load PetTP')
    ---------------------------------------
end
function mf.file_unload(status,current_event,new_job)
    ---------------------------------------
    --put your file_unload rules here
    ---------------------------------------
end
function mf.status_change(status,current_event,new,old)
    ---------------------------------------
    --put your status_change rules here
    ---------------------------------------
    --add gear to change with
    --sets.building[current_event] = set_combine(sets.building[current_event], <setname>)
    ---------------------------------------
end
function mf.pet_change(status,current_event,pet,gain)
    ---------------------------------------
    --put your pet_change rules here
    ---------------------------------------
    --add gear to change with
    --sets.building[current_event] = set_combine(sets.building[current_event], <setname>)
    --only if status.stop_swapping_gear = false
    ---------------------------------------
end
function mf.filtered_action(status,current_event,spell)
    ---------------------------------------
    --put your filtered_action rules here
    ---------------------------------------
    --add gear to change with
    --sets.building[current_event] = set_combine(sets.building[current_event], <setname>)
    --only if status.stop_swapping_gear = false
    ---------------------------------------
end
function mf.pretarget(status,current_event,spell)
    ---------------------------------------
    --put your pretarget rules here
    ---------------------------------------
    --add gear to change with
    --sets.building[current_event] = set_combine(sets.building[current_event], <setname>)
    --only if status.stop_swapping_gear = false
    ---------------------------------------
end
function mf.precast(status,current_event,spell)
    ---------------------------------------
    --put your precast rules here
    ---------------------------------------
    --add gear to change with
    --sets.building[current_event] = set_combine(sets.building[current_event], <setname>)
    ---------------------------------------
end
function mf.buff_change(status,current_event,name,gain,buff_table)
    ---------------------------------------
    --put your buff_change rules here
    ---------------------------------------
    --change gear with
    --equip(<setname>)
    ---------------------------------------
    --recommended equip when loss of buff
    --equip(sets[player.status], sets.weapon[weapon_types[player.main_job][weapon_types_count]])
    ---------------------------------------
    --add gear to change with
    --sets.building[current_event] = set_combine(sets.building[current_event], <setname>)
    --only if status.stop_swapping_gear = false
    ---------------------------------------
end
function mf.midcast(status,current_event,spell)
    ---------------------------------------
    --put your midcast rules here
    ---------------------------------------
    --add gear to change with
    --sets.building[current_event] = set_combine(sets.building[current_event], <setname>)
    ---------------------------------------
end
function mf.pet_midcast(status,current_event,spell,)
    ---------------------------------------
    --put your pet_midcast rules here
    ---------------------------------------
    --add gear to change with
    --sets.building[current_event] = set_combine(sets.building[current_event], <setname>)
    ---------------------------------------
end
function mf.aftercast(status,current_event,spell)
    ---------------------------------------
    --put your aftercast rules here
    ---------------------------------------
    --add gear to change with
    --sets.building[current_event] = set_combine(sets.building[current_event], <setname>)
    ---------------------------------------
end
function mf.pet_aftercast(status,current_event,spell)
    ---------------------------------------
    --put your pet_aftercast rules here
    ---------------------------------------
    --add gear to change with
    --sets.building[current_event] = set_combine(sets.building[current_event], <setname>)
    ---------------------------------------
end
function mf.self_command(status,current_event,command)
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
            --put commands that you want to the cycle command for example: gs c c stepmax note: for cycling through all possible variables
            --example code:
            -- if command[2]:lower() == 'stepmax' then
                -- Stepmax = (Stepmax % 5) + 1
                -- add_to_chat(7,'Max step = ' ..Stepmax)
            -- end
        elseif command[1]:lower() == 'toggle' or command[1]:lower() == 't' then
            --put commands that you want to the toggle command for example: gs c t stopsteps note: only needed for true/false variable
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
function mf.sub_job_change(status,current_event,new,old)
    ---------------------------------------
    --put your sub_job_change rules here
    ---------------------------------------
    --add gear to change with
    --sets.building[current_event] = set_combine(sets.building[current_event], <setname>)
    --only if status.stop_swapping_gear = false
    ---------------------------------------
end
function mf.indi_change(status,current_event,indi_table,gain) -- only needed for Geo main/sub jobs
    ---------------------------------------
    --put your indi_change rules here
    ---------------------------------------
    --add gear to change with
    --sets.building[current_event] = set_combine(sets.building[current_event], <setname>)
    --only if status.stop_swapping_gear = false
    ---------------------------------------
end
function mf.zone_change(new,old) -- only when Registered_Events include is active
    ---------------------------------------
    --put your zone_change rules here
    --new string name of the new zone
    --old string name of the old zone
    ---------------------------------------
    --change gear with
    --equip(<setname>)
    ---------------------------------------
    --example: rule (change gear on entering city)
    --if cities:contains(new) then
    --  equip(sets.city)
    --end
    ---------------------------------------
    
end
function mf.treasure_hunter_change(gain,count,mob_name) -- only when Registered_Events include is active
    ---------------------------------------
    --put your treasure_hunter_change rules here
    --gain = boolean
    --count = number the count of the current th on mob
    --mob_name = string name of the mob
    ---------------------------------------
    --change gear with
    --equip(<setname>)
    ---------------------------------------
end
--These are examples only use if you know what your doing and know how to use io.write--
-- <var> is the variable you want to save, <start> is the default you want it set at
-- for boolean types use '\n<var> = '..tostring(<var> or <start>)..
-- for number types use '\n<var> = '..tostring(<var> or <start>)..
-- for string types use '\n<var> = "'..tostring(<var> or <start>)..'"'..
--[[ function mf.save()
    local save = '\nEnable_auto_pup = '..tostring(Enable_auto_pup or false).. --boolean
        '\nskill_count = '..tostring(skill_count or 1).. --number
        '\nUsestaff = "'..tostring(Usestaff or 'Atk')..'"'.. --string
        '' 
    return save
end]]
--These are examples only use if you know how to create a text display--
--[[ function custom_menu_update()
    local custom_rules_table = {}
    custom_rules_table.testa = Testa and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
    custom_rules_table.testb = Testb and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr' 
    return custom_rules_table
end]]
--[[ function custom_menu_build()
    local custom_properties = L{}
    custom_properties:append('Testa ${testa}')
    custom_properties:append('Testb ${testb}') 
    return custom_properties
end]]
--[[ function custom_menu_commands(com)
    if menu_set == 6 then
        print(com)
    end
    if com == "{testa}" then
        Testa = not Testa
    elseif com == "{testb}" then
        Testb = not Testb
    end
end]]