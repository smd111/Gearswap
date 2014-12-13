--[[How To Use:
    1. make sure that the files for this include setup is in the gearswap/data/<players name> directory
    2. to create a new job file just coppy this and rename it to the correct job name I.e. for Dancer name it DNC.lua
    3. add your gearsets in to function get_sets ware shown
    4. add rules to each function below ware shown
    5. your ready to use
    notes: i have included basic layouts for 3 gearsets Engaged,Idle,Resting]]
--include setup -------------------------------------------------------------------------------------------------------------------
function include_setup()
    --Disable All Includes (Default: false)
    Disable_All = false
    --Use Main Job includes (Default: true)
    MJi = true
    --Use Sub Job Includes (Default: true)
    SJi = true
    --Use Mage Stave Include (Default: true)
    MSi = true
    --Use Weapon Skill Include (Default: true)
    WSi = true
    --Use Ammo Include (Default: true)
    Ammo = true
    --Use Special_Weapons Include (Default: true)
    Special_Weapons = true
    --Use Conquest_Gear Include (Default: true)
    Conquest_Gear = true
    --Use File_Write Include (Default: true)
    File_Write = true
    --Use Registered_Events Include (Default: true)
    Registered_Events = true
    --Use Debug Include (Default: false)
    Debug = false
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
include('includes/Extras.lua')
--Job functions
function gear_setup()
    add_gear_modes({"test","tes2"})-- add more gear modes with this
    ---------------------------------------
    --these are your base sets put in your
    --default sets for status idle/resting
    --/engaged (these must be here)
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
    --put your weapons here
    --any that you do not want to use just comment out or remove 
    --(these must be here)
    ---------------------------------------
    sets.weapon = {}
    -- sets.weapon['Axe'] = {main="",sub="",}
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
    ---------------------------------------
    --put your range weapons here
    --any that you do not want to use just comment out or remove 
    --(these must be here)
    ---------------------------------------
    sets.range = {}
    -- sets.range['Archery'] = {range="",ammo="",}
    -- sets.range['Marksmanship'] = {range="",ammo="",}
    -- sets.range['Throwing'] = {range="Chakram",ammo="",}
    -- sets.range['Fishing'] = {range="",ammo="",}
    -- sets.range['Soultrapper'] = {range="",ammo="",}
    -- sets.range['Wind Instruments'] = {range="",ammo="",}
    -- sets.range['String Instruments'] = {range="",ammo="",}
    -- sets.range['Handbells'] = {range="",ammo="",}
    -- sets.range['Other'] = {range="",ammo="",}
    ---------------------------------------
    --put your other sets here
    ---------------------------------------
end
function mf_file_unload()
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
    if new=='Engaged' then
        set_gear = set_combine(set_gear, sets.Engaged)
    elseif new=='Idle' then
        set_gear = set_combine(set_gear, sets.Idle)
    elseif new=='Resting' then
        set_gear = set_combine(set_gear, sets.Resting)
    end
    return set_gear
end
function mf_pet_change(pet,gain,status,set_gear)
    ---------------------------------------
    --put your pet_change rules here
    --to stop processing of all precast rules use: return true
    ---------------------------------------
    --add gear to change with
    --set_gear = set_combine(set_gear, <setname>)
    ----------------------------------------
    return set_gear
end
function mf_filtered_action(spell,status,set_gear)
    ---------------------------------------
    --put your filtered_action rules here
    --to stop processing of all filtered_action rules use: return true
    ---------------------------------------
    --does not change gear as any thing
    --that comes in to this function
    --is a spell/ability your current job
    --does not have
    ----------------------------------------
    return
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
    --to stop processing of all precast rules use: return true
    ---------------------------------------
    --add gear to change with
    --set_gear = set_combine(set_gear, <setname>)
    ----------------------------------------
    return set_gear
end
function mf_buff_change(name,gain)
    ---------------------------------------
    --put your buff_change rules here
    ---------------------------------------
    --change gear with
    --equip(<setname>)
    ----------------------------------------
    --recomended equip when loss of buff
    --equip(sets[player.status], sets.weapon[weapon_types[player.main_job][weapon_types_count]])
    ----------------------------------------
    return
end
function mf_midcast(spell,status,set_gear)
    ---------------------------------------
    --put your midcast rules here
    --to stop processing of all midcast rules use: return true
    ---------------------------------------
    --add gear to change with
    --set_gear = set_combine(set_gear, <setname>)
    ----------------------------------------
    return set_gear
end
function mf_pet_midcast(spell,status,set_gear)
    ---------------------------------------
    --put your pet_midcast rules here
    --to stop processing of all pet_midcast rules use: return true
    ---------------------------------------
    --add gear to change with
    --set_gear = set_combine(set_gear, <setname>)
    ----------------------------------------
    return set_gear
end
function mf_aftercast(spell,status,set_gear)
    ---------------------------------------
    --put your aftercast rules here
    --to stop processing of all aftercast rules use: return true
    ---------------------------------------
    set_gear = set_combine(set_gear, sets[player.status])--you can change this
    return set_gear
end
function mf_pet_aftercast(spell,status,set_gear)
    ---------------------------------------
    --put your pet_aftercast rules here
    --to stop processing of all pet_aftercast rules use: return true
    ---------------------------------------
    set_gear = set_combine(set_gear, sets[player.status])--you can change this 
    return set_gear
end
function mf_self_command(command)
    ---------------------------------------
    --put your self_command rules here
    ---------------------------------------
end
function mf_sub_job_change(new,old)
    ---------------------------------------
    --put your sub_job_change rules here
    ---------------------------------------
    return
end
-- function custom_rules()
    -- local custom_rules_table = {}
    -- if SJi then
        -- custom_rules_table.stepm = Stepmax
        -- custom_rules_table.ssteps = Stopsteps and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
    -- end
    -- if WSi then
        -- custom_rules_table.cstaff = Changestaff and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
        -- custom_rules_table.ustaff = Usestaff
    -- end
    -- if Conquest_Gear then
        -- custom_rules_table.cneckc = Conquest.neck.change and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
        -- custom_rules_table.cringc = Conquest.ring.change and '\\cs(0,255,0)☑\\cr' or '\\cs(255,255,0)☐\\cr'
        -- custom_rules_table.cneck = Conquest.neck.case[Conquest.neck.case_id]
        -- custom_rules_table.cring = Conquest.ring.case[Conquest.ring.case_id]
    -- end
    -- custom_rules_table.mjob = windower.ffxi.get_player().main_job_full
    -- custom_rules_table.mjob_lvl = windower.ffxi.get_player().main_job_level
    -- return custom_rules_table
-- end
-- function custom_menu()
    -- local properties = L{}
        -- if windower.ffxi.get_player().sub_job == 'DNC' and SJi then
            -- properties:append('-Steps-')
            -- properties:append('   Max Step = ${stepm}')
            -- properties:append('   Stop Steps   ${ssteps}')
        -- end
        -- if windower.wc_match(windower.ffxi.get_player().main_job, "WHM|BLM|RDM|BRD|SMN|SCH|GEO") and WSi then
            -- properties:append('Staves')
            -- properties:append('  Will ${cstaff}Change')
            -- properties:append('Staves Set To ${ustaff}')
        -- end
        -- if Conquest_Gear then
            -- properties:append('Conquest Neck')
            -- properties:append('  Will ${cneckc}Change')
            -- properties:append('Conquest Ring')
            -- properties:append('  Will ${cringc}Change')
            -- properties:append('Conquest')
            -- properties:append('  Neck Type = ${cneck}')
            -- properties:append('  Ring Type = ${cring}')
        -- end
        -- if lvlwatch then
            -- properties:append('${mjob}')
            -- properties:append('   lvl = ${mjob_lvl}')
        -- end
    -- return properties
-- end
-- function custom_menu_commands(a)
    -- print('a='..a)
-- end