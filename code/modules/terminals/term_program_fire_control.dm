/datum/console_program/fire_control
	name = "fire control module"

/datum/console_program/fire_control/UpdateContents(var/silent = FALSE)

	html.Cut()
	html += "<pre class='alignCentre'>=== Fire Control Terminal ===</pre>"
	html += "=========================================================="
	var/obj/machinery/computer/weapons/console = owner
	if(!istype(console) || !console.linked)
		for(var/i = 1 to 5)
			html += " "
		html += "ERROR ERROR ERROR"
		for(var/i = 1 to 5)
			html += " "
		html += "=========================================================="
		..(silent)
		return
	for(var/obj/machinery/power/ship_weapon/W in console.linked.weapons)
		var/list/weapon_status = W.get_status()
		html += " "
		html += "=== [weapon_status["name"]] ([weapon_status["location"]]) ==="
		html += "===== [weapon_status["status"]] === <a href='?src=\ref[console];fire=\ref[W]'>\[FIRE\]</a>"
	..(silent)
