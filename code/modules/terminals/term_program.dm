/datum/console_program
	var/name
	var/html[22]
	var/mob/cur_user
	var/html_template = 'html/templates/terminal_template.html'
	var/obj/machinery/console/owner

/datum/console_program/New(var/obj/machinery/console/new_owner)
	if(!istype(new_owner))
		qdel(src)
		return
	owner = new_owner

/datum/console_program/proc/initialize()
	return

/datum/console_program/Destroy()
	cur_user = null
	if(owner)
		owner.installed_software[name] = null
		owner.installed_software -= name
		owner = null
	return ..()

/datum/console_program/proc/Run(mob/user)
	if(cur_user && user != cur_user)
		return
	else if(!cur_user)
		cur_user = user

	OpenTerminal(user)

/datum/console_program/proc/OpenTerminal(mob/user)
	PushCommonAssets(user)
	user << browse(html_template, "window=\ref[src];size=800x600;can_resize=0")

	sleep(30)

	//Push the starting page, row-by-row to the browser, using the replaceRow javascript function - I couldn't get an array push to work
	for(var/i = 1 to html.len)
		user << output(list2params(list("[i]", html[i])), "\ref[src].browser:replaceRow")

/datum/console_program/proc/PushCommonAssets(mob/user)
	user << browse('html/css/terminal.css', "display=0")
	user << browse('html/js/terminalFunctions.js', "display=0")
	user << browse('html/images/terminal_bg.png', "display=0")
