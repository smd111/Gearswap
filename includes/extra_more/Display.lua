texts = require('texts')
box.text = {}
box.text.font = 'Dotum'
box.text.size = 9
box.bg = {}
box.bg.alpha = 100
box.flags = {}
box.flags.draggable = true
window_hidden = false
auto_hide_cycle = 0
--display functions---------------------------------------------------------------------------------------------------------------
--Display Creator
window = texts.new(box)
function initialize(text, settings)
    local properties = L{}
	if player.sub_job == 'DNC' and SJi then
		properties:append('\\cs(255,0,0)Max Step = \\cs(255,255,0)${stepm}')
		properties:append('\\cs(255,0,0)Steps\n  \\cs(255,255,0)Will ${ssteps|Not }Stop')
	end
	if player.main_job == 'DNC' and MJi then
		properties:append('\\cs(255,0,0)Max Step = \\cs(255,255,0)${stepm}')
		properties:append('\\cs(255,0,0)Steps\n  \\cs(255,255,0)Will ${ssteps|Not }Stop')
	end
	if windower.wc_match(player.main_job, "WHM|BLM|RDM|BRD|SMN|SCH|GEO") and WSi then
		properties:append('\\cs(255,0,0)Staves\n  \\cs(255,255,0)Will ${cstaff|Not }Change')
		properties:append('\\cs(255,0,0)Staves Set To \\cs(255,255,0)${ustaff|Atk}')
	end
	if Conquest_Gear then
		properties:append('\\cs(255,0,0)Conquest Neck\n  \\cs(255,255,0)Will ${cneckc|Not }Change')
		properties:append('\\cs(255,0,0)Conquest Ring\n  \\cs(255,255,0)Will ${cringc|Not }Change')
		properties:append('\\cs(255,0,0)Conquest\n  \\cs(0,255,0)Neck Type = \\cs(255,255,0)${cneck}\n  \\cs(0,255,0)Ring Type = \\cs(255,255,0)${cring}')
	end
	if autolock and Registered_Events then
		properties:append('\\cs(255,0,0)Auto Lock\n  \\cs(255,255,0)Enabled')
	end
	if autotarget then
		properties:append('\\cs(255,0,0)Auto Self Target \nAfter Battle \\cs(255,255,0)Enabled')
	end
	if stoponskillcap and Registered_Events then
		properties:append('\\cs(255,0,0)Auto Stop On\n  \\cs(255,255,0)'..string.gsub(stopskilltyp[stopskill_count], "_", " ")..'\\cs(255,0,0) Cap')
		if lvl then
			properties:append('\\cs(255,0,0)Current Skill\n  Level = \\cs(255,255,0)'..lvl[stopskilltyp[stopskill_count]])
		end
	end
	if lvlwatch then
		properties:append('\\cs(255,0,0)'..player.main_job_full..'\n  \\cs(255,255,0) lvl = '..player.main_job_level)
	end

    text:clear()
    text:append(properties:concat('\n'))
end
initialize(window, box)
--Display Updater
function updatedisplay()
	initialize(window, box)
	local info = {}
	if SJi then
		info.stepm = Stepmax
		info.ssteps = Stopsteps and '' or 'Not '
	end
	if WSi then
		info.cstaff = Changestaff and '' or 'Not '
		info.ustaff = Usestaff
	end
	if Conquest_Gear then
		info.cneckc = Conquest.neck.change and '' or 'Not '
		info.cringc = Conquest.ring.change and '' or 'Not '
		info.cneck = Conquest.neck.case[Conquest.neck.case_id]
		info.cring = Conquest.ring.case[Conquest.ring.case_id]
	end
	
	window:update(info)
	if not window_hidden then
		window:show()
	end
end
function auto_hide_window()
	if auto_hide_cycle == 3 then
		if windower.ffxi.get_info().menu_open and not windower.ffxi.get_player().in_combat and not window_hidden then
			window:hide()
		elseif not windower.ffxi.get_info().menu_open and not windower.ffxi.get_player().in_combat and not window_hidden then
			window:show()
		end
		auto_hide_cycle = 0
	else
		auto_hide_cycle = auto_hide_cycle +1
	end
end
--windower.raw_register_event('prerender', auto_hide_window)