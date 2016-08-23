
/client/verb/who()
	set name = "Who"
	set category = "OOC"

	var/msg = "<b>Current Players:</b>\n"

	var/list/Lines = list()

	if(holder && (holder.rights & R_ADMIN))
		for(var/client/C in clients)
			var/entry = "\t[C.key]"
			entry += " - Playing as [C.mob.real_name]"
			switch(C.mob.stat)
				if(UNCONSCIOUS)
					entry += " - <font color='darkgray'><b>Unconscious</b></font>"
				if(DEAD)
					if(isobserver(C.mob))
						var/mob/dead/observer/O = C.mob
						if(O.started_as_observer)
							entry += " - <font color='gray'>Observing</font>"
						else
							entry += " - <font color='black'><b>DEAD</b></font>"
					else
						entry += " - <font color='black'><b>DEAD</b></font>"

			var/age
			if(isnum(C.player_age))
				age = C.player_age
			else
				age = 0

			if(age <= 1)
				age = "<font color='#ff0000'><b>[age]</b></font>"
			else if(age < 10)
				age = "<font color='#ff8c00'><b>[age]</b></font>"

			entry += " - [age]"

			if(is_special_character(C.mob))
				entry += " - <b><font color='red'>Antagonist</font></b>"
			entry += " (<A HREF='?_src_=holder;adminmoreinfo=\ref[C.mob]'>?</A>)"

			if(C.ckey in vips)
				Lines += "<span class='vip_channel'>[entry]</span>"
			else
				Lines += entry
	else
		for(var/client/C in clients)
			if(C.ckey in vips)
				Lines += "<span class='vip_channel'>[C.key]</span>"
			else
				Lines += C.key

	for(var/line in sortList(Lines))
		msg += "[line]\n"

	msg += "<b>Total Players: [length(Lines)]</b>"
	src << msg

/client/verb/staffwho()
	set category = "Admin"
	set name = "Staffwho"

	var/msg = ""
	var/num_admins_online = 0

	for(var/client/C in admins)
		msg += "\t[C] is a [C.holder.rank]\n"
		if(C.holder && (C.holder.rights & R_ADMIN))
			num_admins_online++
		if(holder)
			if(isobserver(C.mob))
				msg += " - Observing"
			else if(istype(C.mob,/mob/new_player))
				msg += " - Lobby"
			else
				msg += " - Playing"
			if(C.is_afk())
				msg += " (AFK)"
			msg += "\n"


	if(config.admin_irc)
		src << "<span class='info'>Adminhelps are also sent to IRC. If no admins are available in game try anyway and an admin on IRC may see it and respond.</span>"
	msg = "<b>Current Admins ([num_admins_online]):</b>\n" + msg
	src << msg
