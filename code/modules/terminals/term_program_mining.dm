/datum/console_program/mining
	name = "ore processing module"
	var/obj/machinery/mineral/ore_machine

/datum/console_program/mining/UpdateContents(var/silent = FALSE)
	html.Cut()
	html += "<pre class='alignCentre'>=== Ore Processing Terminal ===</pre>"
	html += "=========================================================="
	if(!ore_machine)
		for(var/c in cardinal)
			var/turf/T = get_step(owner, c)
			ore_machine = locate() in T
			if(ore_machine)
				ore_machine.console = owner
				break
	if(!ore_machine)
		html += "NO DEVICE LOCATED, CONTACT HARDWARE VENDOR"
	else
		for(var/line in ore_machine.get_console_data())
			html += line
			if(html.len >= (TERM_LINES-1))
				break
	html += "=========================================================="
	..(silent)