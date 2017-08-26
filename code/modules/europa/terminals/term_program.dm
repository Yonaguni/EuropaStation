/datum/console_program
	var/name
	var/html[22]
	var/html_template = 'html/templates/terminal_template.html'
	var/obj/machinery/owner
	var/list/users = list()

/datum/console_program/New(var/obj/machinery/new_owner)
	if(!istype(new_owner))
		qdel(src)
		return
	owner = new_owner

/datum/console_program/proc/Process()

	if(!users.len)
		return

	if(!owner.powered() || (owner.stat && (BROKEN|NOPOWER)))
		for(var/thing in users)
			var/mob/user = thing
			user << browse(null, "window=\ref[src]")
			if(user.machine == owner)
				user.unset_machine()
		users.Cut()
	else
		for(var/thing in users)
			var/mob/user = thing
			if(!user || QDELETED(user))
				users -= user
			else if(user.is_physically_disabled() || (!isAI(user) && !user.Adjacent(owner)))
				user << browse(null, "window=\ref[src]")
				if(user.machine == owner)
					user.unset_machine()
				users -= user
		if(users.len)
			UpdateContents(silent = TRUE)

/datum/console_program/proc/initialize()
	return

/datum/console_program/Destroy()
	if(owner)
		owner.RemoveInstalledTerminalSoftware(src)
		owner = null
	return ..()

/datum/console_program/proc/Run(mob/user)
	if(user.machine != owner)
		OpenTerminal(user)
	user.set_machine(owner)
	UpdateContents()

/datum/console_program/proc/UpdateContents(var/silent = FALSE)
	while(html.len < 22)
		html += " "
	html[22] = "==================================================<a href='?src=\ref[src];close_window=1'>\[CLOSE\]</a>="
	ShowContents(silent)

/datum/console_program/proc/ShowContents(var/silent = FALSE)
	if(!silent)
		PlayUpdateSounds()
	if(owner.in_use)
		for(var/thing in (viewers(1, owner) + ai_list))
			var/mob/M = thing
			if(M.client && M.machine == owner)
				UpdateViewer(thing)

/datum/console_program/proc/PlayUpdateSounds()
	set waitfor = 0
	set background = 1

	for(var/i = 1 to html.len)
		if(html[i] && html[i] != " " && html[i] != "")
			playsound(owner.loc, 'sound/effects/screen.ogg', 5, 0)
		sleep(1)

/datum/console_program/proc/UpdateViewer(var/mob/viewer)
	set waitfor = 0
	set background = 1
	users |= viewer
	for(var/i = 1 to html.len)
		viewer << output(list2params(list("[i]", html[i])), "\ref[src].browser:replaceRow")
		sleep(1)

/datum/console_program/proc/OpenTerminal(var/mob/user)
	PushCommonAssets(user)
	user << browse(html_template, "window=\ref[src];size=800x600;can_resize=0;can_close=0")
	sleep(5)
	UpdateContents()

/datum/console_program/proc/PushCommonAssets(mob/user)
	user << browse('html/css/terminal.css', "display=0")
	user << browse('html/js/terminalFunctions.js', "display=0")
	user << browse('html/images/terminal_bg.png', "display=0")

/datum/console_program/Topic(href, href_list)
	. = ..()
	if(!. && usr && href_list["close_window"])
		playsound(owner.loc, 'sound/effects/switch.ogg', 15, 0)
		usr << browse(null, "window=\ref[src]")
		if(usr.machine == owner)
			usr.unset_machine()
		users -= usr
