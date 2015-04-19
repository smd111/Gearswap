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
    waltz_stats = {vit=68,chr=81} --these are the stats need to calulate curing waltz hp recovery
    -- These are your Weapon sets (you can add as many as you want)
    sets.weapon['Axe'] = {main="",sub=""}
    sets.weapon['None'] = {main=empty,sub=empty}
    -- These are your Range sets (you can add as many as you want)
    sets.range['Throwing'] = {range="",ammo=empty}
    -- These are your Armor sets (you can add as many as you want)
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
function mf.file_load()
    ---------------------------------------
    --put your file_load rules here
    --everything here will happen 1.5 seconds
    --after gearswap load your file
    --i use this for my commands like
    --loading exter plugins and running Organizer's
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
    ----------------------------------------
    --put your status_change rules here
    ----------------------------------------
    --add gear to change with
    --sets.building[current_event] = set_combine(sets.building[current_event], <setname>)
    ----------------------------------------
end
function mf.pet_change(status,current_event,pet,gain)
    ---------------------------------------
    --put your pet_change rules here
    --to stop processing of all precast rules use: return set_gear
    ---------------------------------------
    --add gear to change with
    --sets.building[current_event] = set_combine(sets.building[current_event], <setname>)
    ----------------------------------------
end
function mf.filtered_action(status,current_event,spell)
    ---------------------------------------
    --put your filtered_action rules here
    --to stop processing of all filtered_action rules use: return set_gear
    ---------------------------------------
    --does not change gear as any thing
    --that comes in to this function
    --is a spell/ability your current job
    --does not have
    ----------------------------------------
end
function mf.pretarget(status,current_event,spell)
    ---------------------------------------
    --put your pretarget rules here
    ---------------------------------------
    --add gear to change with
    --sets.building[current_event] = set_combine(sets.building[current_event], <setname>)
    ----------------------------------------
end
function mf.precast(status,current_event,spell)
    ---------------------------------------
    --put your precast rules here
    --to stop processing of all precast rules use: return set_gear
    ---------------------------------------
    --add gear to change with
    --sets.building[current_event] = set_combine(sets.building[current_event], <setname>)
    ----------------------------------------
end
function mf.buff_change(status,current_event,name,gain,buff_table)
    ---------------------------------------
    --put your buff_change rules here
    ---------------------------------------
    --change gear with
    --equip(<setname>)
    ----------------------------------------
    --recomended equip when loss of buff
    --equip(sets[player.status], sets.weapon[weapon_types[player.main_job][weapon_types_count]])
    ----------------------------------------
end
function mf.midcast(status,current_event,spell)
    ---------------------------------------
    --put your midcast rules here
    --to stop processing of all midcast rules use: return set_gear
    ---------------------------------------
    --add gear to change with
    --sets.building[current_event] = set_combine(sets.building[current_event], <setname>)
    ----------------------------------------
end
function mf.pet_midcast(status,current_event,spell,)
    ---------------------------------------
    --put your pet_midcast rules here
    --to stop processing of all pet_midcast rules use: return set_gear
    ---------------------------------------
    --add gear to change with
    --sets.building[current_event] = set_combine(sets.building[current_event], <setname>)
    ----------------------------------------
end
function mf.aftercast(status,current_event,spell)
    ---------------------------------------
    --put your aftercast rules here
    --to stop processing of all aftercast rules use: return set_gear
    ---------------------------------------
end
function mf.pet_aftercast(status,current_event,spell)
    ---------------------------------------
    --put your pet_aftercast rules here
    --to stop processing of all pet_aftercast rules use: return set_gear
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
function mf.sub_job_change(status,current_event,new,old)
    ---------------------------------------
    --put your sub_job_change rules here
    ---------------------------------------
end
function mf.indi_change(status,current_event,indi_table,gain) -- only needed for Geo main/sub jobs
    ---------------------------------------
    --put your indi_change rules here
    ---------------------------------------
end
function mf.zone_change(new,old) -- only when Registered_Events include is active
    ---------------------------------------
    --put your zone_change rules here
    --new string name of the new zone
    --old string name of the old zone
    ---------------------------------------
end
function mf.treasure_hunter_change(gain,count,mob_name) -- only when Registered_Events include is active
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
        '' save
end]]
--These are examples only use if you know how to create a text display--
--[[ function custom_menu_update()
    local custom_rules_table = {}
    custom_rules_table.testa = Testa and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
    custom_rules_table.testb = Testb and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr' custom_rules_table
end]]
--[[ function custom_menu_build()
    local custom_properties = L{}
    custom_properties:append('Testa ${testa}')
    custom_properties:append('Testb ${testb}') custom_properties
end]]
--[[ function custom_menu_commands(a))
    if menu_set == 6 then
        print(a)
    end
    if a == "{testa}" then
        Testa = not Testa
    elseif a == "{testb}" then
        Testb = not Testb
    end
end]]