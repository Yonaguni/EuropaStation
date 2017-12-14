/datum/console_program
	var/name
	var/html[TERM_LINES]
	var/html_template = 'html/templates/terminal_template.html'
	var/obj/machinery/owner
	var/list/users = list()
	var/screen_index = 1

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
	if(!. && usr)

		if(href_list["close_window"])
			playsound(owner.loc, 'sound/effects/switch.ogg', 15, 0)
			usr << browse(null, "window=\ref[src]")
			if(usr.machine == owner)
				usr.unset_machine()
			users -= usr
			. = TRUE

		if(href_list["lastpage"] || href_list["nextpage"])
			if(href_list["lastpage"])
				screen_index--
			if(href_list["nextpage"])
				screen_index++
			owner.interact(usr)
			. = TRUE

/datum/console_program/proc/add_page_header(var/item_list_size, var/items_per_page)
	var/last_page = ceil(item_list_size/items_per_page)
	if(screen_index > last_page)
		screen_index = last_page
	else if(screen_index < 1)
		screen_index = 1
	var/page_header = " Page "
	var/page_num_len = length(num2text(screen_index)) + length(num2text(last_page))
	while(length(page_header) < 53 - page_num_len)
		page_header = "=[page_header]"
	if(screen_index == 1)
		if(screen_index == last_page)
			html += "[page_header] [screen_index]/[last_page] ==="
		else
			html += "[page_header] [screen_index]/<a href='?src=\ref[src];nextpage=1]'>[last_page]</a> ==="
	else if(screen_index == last_page)
		html += "[page_header] <a href='?src=\ref[src];lastpage=1]'>[screen_index]</a>/[last_page] ==="
	else
		html += "[page_header] <a href='?src=\ref[src];lastpage=1]'>[screen_index]</a>/<a href='?src=\ref[src];nextpage=1]'>[last_page]</a> ==="
	html += " "
