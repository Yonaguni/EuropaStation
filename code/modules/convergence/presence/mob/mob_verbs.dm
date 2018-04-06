/mob/living/presence/verb/select_presence_type()
	set name = "Select Presence Type"
	set category = "Presence"

	if(stat)
		return 0

	if(istype(presence))
		verbs -= /mob/living/presence/verb/select_presence_type
		return

	var/choice = input("Select a presence type to assume.", "Presence") as null|anything in presence_templates

	if(istype(presence))
		verbs -= /mob/living/presence/verb/select_presence_type
		return

	if(choice && presence_templates[choice])
		presence = presence_templates[choice]
		presence.welcome_presence(src)
		if(istype(presence))
			verbs -= /mob/living/presence/verb/select_presence_type
			forceMove(locate(1,1,1))
			update_icon()

/mob/living/presence/verb/set_presence_name()

	set name = "Set Presence Name"
	set category = "Presence"

	if(stat)
		return

	var/newname = sanitize(input(src, "You are a strange presence. What is your name?", "Select deity name") as text, MAX_NAME_LEN)
	if(newname)
		name = newname
		if(mind)
			mind.name = name
		if(name != initial(name))
			verbs -= /mob/living/presence/verb/set_presence_name

/mob/living/presence/verb/list_believers()

	set name = "List Believers"
	set category = "Presence"

	if(!presence)
		to_chat(src, "<span class='warning'>Select a presence type first using the Select Presence verb.</span>")
		return

	to_chat(src, "<b>Current living believers:</b>")
	for(var/thing in believers)
		var/mob/M = thing
		if(M.loc && M.stat == CONSCIOUS)
			to_chat(src, "<b>\The [thing]</b> - [get_area(thing)] - <a href='?src=\ref[src];jump_to_believer=\ref[thing]'>(JMP)</a>")

/mob/living/presence/verb/jump_to_believer()

	set name = "Jump To Believer"
	set category = "Presence"

	if(stat)
		return

	if(!presence)
		to_chat(src, "<span class='warning'>Select a presence type first using the Select Presence verb.</span>")
		return

	if(!LAZYLEN(believers))
		to_chat(src, "<span class='warning'>You have no believers to jump to.</span>")
		return

	var/believer = input("Select a believer to jump to.", "Presence") as null|anything in believers
	if(believer && believers[believer])
		forceMove(get_turf(believer))

/mob/living/presence/verb/list_powers()

	set name = "Show Power Menu"
	set category = "Presence"

	if(stat)
		return 0

	if(!presence)
		to_chat(src, "<span class='warning'>Select a presence type first using the Select Presence verb.</span>")
		return

	var/list/dat = list("<hr><b>Available [presence.unit_name]\s:</b> [mojo]/[max_mojo]<hr><table border = 1 width = 100%>")
	for(var/datum/presence_power/power in presence.available_powers) dat += "[power.get_print_data(0, src)]"
	dat += "</table><hr><a href='?src=\ref[src];refresh_power_page=1'>Refresh</a> <a href='?src=\ref[src];clear_selected_power=1'>Clear Selected Power</a><hr>"

	var/datum/browser/popup = new(src, "presence", "Powers")
	popup.set_content(jointext(dat,""))
	popup.open()

/mob/living/presence/verb/indoctrinate_believer_debug()

	set name = "Indoctrinate Victim (DEBUG)"
	set category = "Presence"

	if(stat)
		return

	if(!presence)
		to_chat(src, "<span class='warning'>Select a presence type first using the Select Presence verb.</span>")
		return

	var/list/options = list()
	for(var/thing in clients)
		var/client/C = thing
		if(C.mob && C.mob.mind)
			options += C.mob.mind
	if(!options.len)
		to_chat(src, "There are no valid targets to indoctrinate.")
		return
	var/datum/mind/victim = input("Who do you want to indoctrinate?", "Indoctrination") as null|anything in options
	if(istype(victim)) godtouched.add_antagonist(victim, TRUE, TRUE, FALSE, TRUE, TRUE, src)
