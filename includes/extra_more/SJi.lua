if not Stepmax then
	Stepmax = 1
end
if not Stopsteps then
	Stopsteps = false
end
	Hwauto = false

if gearswap.pathsearch({'includes/sjob/sub_job_'..player.sub_job..'.lua'}) then
	include('includes/sjob/sub_job_'..player.sub_job..'.lua')
end

function sub_jobs_command(command)
	if command == 'tstopsteps' then
		Stopsteps = not Stopsteps
		-- add_to_chat(7, '----- Steps Will ' .. (Stopsteps and '' or 'Not ') .. 'Stop -----')
	end
	if command == 'stepcount' then
		Stepmax = (Stepmax % 5) + 1
		-- add_to_chat(7,'Max step = ' ..Stepmax)
	end
	if command == 'autohw' then
		Hwauto = not Hwauto
		add_to_chat(7, '----- Auto Healing Waltz Is ' .. (Hwauto and 'Enabled' or 'Disabled'))
	end
end