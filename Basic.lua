--[[How To Use:
	1. make sure that the files for this include set-up is in the gearswap/data/<players name> directory
	2. to create a new job file just copy this and rename it to the correct job name I.e. for Dancer name it DNC.lua
	3. add your gearsets in to function get_sets ware shown
	4. add rules to each function below ware shown
	5. your ready to use
	notes: i have included basic layouts for 3 gearsets Engaged,Idle,Resting]]
--include set-up -------------------------------------------------------------------------------------------------------------------
--Disable All Includes (Default: false)
--this will disable all includes with one change so you can find bugs in your job file easer
Disable_All = false
--Use Main Job includes (Default: true)
--these files are used primarily for things like large tables and there rules to keep your main file smaller and easer to read
MJi = true
--Use Sub Job Includes (Default: true)
--these files are used primarily for rules you want the same for all main jobs that you use the specific sub job with
SJi = true
--Use Mage Stave Include (Default: true)
--this include will automatically equip top lvl Magians staves (like Atar I)  
MSi = true
--Use Weapon Skill Include (Default: true)
--this include will automatically equip weapon skill belts/gorgets and Hachimaki
WSi = true
--Use Ammo Include (Default: true)
--this include has rules to automatically get more ammo from Quiver's/Box's/Pouch's as long as there in your gobbie bag
Ammo = true
--Use Special_Weapons Include (Default: true)
--this include automatically changes your weapon skill when using false relic weapons like Molva Maul 
--and if you also use the File_Write include will remember how many you have done between jobs and play cycles
Special_Weapons = true
--Use Conquest_Gear Include (Default: true)
--this include will automatically changes your neck and left_ring depending on the zones Conquest info
Conquest_Gear = true
--Use File_Write Include (Default: true)
--this include is used to save specific settings that my include has like what mage staves you prefer to use
File_Write = true
--Use Registered_Events Include (Default: true)
Registered_Events = true
--Use Debug Include (Default: false)
--with this enabled it will output to chat lots of info about the spell you are using
Debug = false
--Use Display Include (Default: true)
--this include creats a display on your screen so you can see your settings
Display = true
--Display Main Job and LVL (Default: false)
lvlwatch = false
--Start with minimized window (Default: false)
window_hidden = true
-----------------------------------------------------------------------------------------------------------------------------------
jobneck = {neck=""} --if using the conquest include put the neck that you want as your main neck when conquest neck is not needed
jobring = {left_ring=""} --if using the conquest include put the left_ring that you want as your main ring when conquest ring is not needed
-- example:
-- jobneck = {neck={ name="Wivre Gorget", augments={'"Subtle Blow"+4','MP+3',}},}
-- jobring = {left_ring="Prouesse Ring",}
include('includes/Extras.lua')
function get_sets()
	---------------------------------------
	--these are your base sets put in your
	--default sets for status idle/resting
	--/engaged (these must be here)
	---------------------------------------
	sets.Engaged = {
		main="",
		sub="",
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
		range="",
		ammo=""
	}
	sets.Idle = {
		main="",
		sub="",
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
		range="",
		ammo=""
	}
	sets.Resting = {
		main="",
		sub="",
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
		range="",
		ammo=""
	}
	---------------------------------------
	--put your other sets here
	---------------------------------------
	if update_display then
		coroutine.schedule(update_display, 3)
	end
end
function mf_file_unload()
	---------------------------------------
	--put your file_unload rules here
	---------------------------------------
	return
end
function mf_status_change(new,old, status, set_gear)
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
function mf_buff_change(name,gain,status,set_gear)
	---------------------------------------
	--put your buff_change rules here
	---------------------------------------
	--add gear to change with
	--set_gear = set_combine(set_gear, <setname>)
	----------------------------------------
	return set_gear
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
--custom menu setup (if you do not know what your doing leave this alone)
-- function custom_rules()
	-- local custom_rules = {}
	-- return custom_rules
-- end
-- function custom_menu()
	-- local properties = L{}
		-- if windower.ffxi.get_player().sub_job == 'DNC' and SJi then
			-- properties:append('Max Step = ${stepm}')
			-- properties:append('Steps')
			-- properties:append('  Will ${ssteps}Stop')
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
		-- if autolock and Registered_Events then
			-- properties:append('Auto Lock')
			-- properties:append('  Enabled')
		-- end
		-- if autotarget then
			-- properties:append('Auto Self Target ')
			-- properties:append('After Battle Enabled')
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