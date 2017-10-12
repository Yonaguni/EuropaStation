/atom/proc/get_specific_codex_entry()
	return FALSE

/atom/proc/get_default_codex_value()
	return src

/atom/examine(var/mob/user, var/distance = -1, var/infix = "", var/suffix = "")
	. = ..(user, distance, infix, suffix)
	spawn(0) // So that any parent-object description text is printed properly before showing the codex link.
		if(SScodex && SScodex.get_codex_entry(get_default_codex_value()) && user.can_use_codex())
			to_chat(user, "<span class='notice'>Your codex implant notifies you it has <b><a href='?src=\ref[SScodex];show_examined_info=\ref[src];show_to=\ref[user]'>relevant information</a></b> available.</span>")
