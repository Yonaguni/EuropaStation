/datum/admins/proc/check_antagonists()
	if (ticker && ticker.current_state >= GAME_STATE_PLAYING)
		var/dat = "<html><head><title>Round Status</title></head><body><h1><B>Round Status</B></h1>"
		dat += "Current Game Mode: <B>[ticker.mode.name]</B><BR>"
		dat += "Round Duration: <B>[round(world.time / 36000)]:[add_zero(world.time / 600 % 60, 2)]:[world.time / 100 % 6][world.time / 100 % 10]</B><BR>"
		dat += "<B>Emergency shuttle</B><BR>"
		if (!emergency_shuttle.online())
			dat += "<a href='?src=\ref[src];call_shuttle=1'>Call Evac</a><br>"
		else
			if (emergency_shuttle.wait_for_launch)
				var/timeleft = emergency_shuttle.estimate_launch_time()
				dat += "ETL: <a href='?src=\ref[src];edit_shuttle_time=1'>[(timeleft / 60) % 60]:[add_zero(num2text(timeleft % 60), 2)]</a><BR>"

			else if (emergency_shuttle.shuttle.has_arrive_time())
				var/timeleft = emergency_shuttle.estimate_arrival_time()
				dat += "ETA: <a href='?src=\ref[src];edit_shuttle_time=1'>[(timeleft / 60) % 60]:[add_zero(num2text(timeleft % 60), 2)]</a><BR>"
				dat += "<a href='?src=\ref[src];call_shuttle=2'>Send Back</a><br>"

			if (emergency_shuttle.shuttle.moving_status == SHUTTLE_WARMUP)
				dat += "Launching now..."

		dat += "<a href='?src=\ref[src];delay_round_end=1'>[ticker.delay_end ? "End Round Normally" : "Delay Round End"]</a><br>"
		dat += "<hr>"
		for(var/antag_type in all_antag_types)
			var/datum/antagonist/A = all_antag_types[antag_type]
			dat += A.get_check_antag_output(src)
		dat += "</body></html>"
		usr << browse(dat, "window=roundstatus;size=400x500")
	else
		alert("The game hasn't started yet!")