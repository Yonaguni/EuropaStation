// Aspects are basically skills + stats + feats all rolled into one. You get to choose a certain number
// of them at character generation and they will alter some interactions with the world. Very WIP.
/decl/aspect
	var/name = "Filler Aspect"                        // Name/unique index.
	var/desc = "An aspect is a kind of skill."        // Flavour text.
	var/use_icon_state = ""                           // State to use for the above.
	//var/icon/use_icon                               // I REALLY HATE \icon A LOT. Causes a lot of lag.
	var/category = "Traits"                           // Header for root aspects in char prefs.

	var/parent_name
	var/decl/aspect/parent
	var/list/children = list()
	var/apply_post_species_change

/*
/decl/aspect/New()
	..()
	use_icon = icon(icon = 'icons/obj/aspects.dmi', icon_state = use_icon_state)
*/

/decl/aspect/Destroy()
	children.Cut()
	parent = null
	return ..()

/decl/aspect/proc/do_post_spawn(var/mob/living/human/holder)
	return

// Called by preferences selection for HTML display.
/decl/aspect/proc/get_aspect_selection_data(var/caller, var/list/ticked_aspects = list(), var/recurse_level = 0, var/ignore_children_if_unticked = 1, var/ignore_unticked)

	var/ticked = (name in ticked_aspects)
	if(ignore_unticked)
		return ""

	var/result = "<tr><td width=50%>"
	if(recurse_level)
		for(var/x = 1 to recurse_level)
			result += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" // Padding.

	/*
	if(caller)
		result += "<img src='[name]_small.png'>&nbsp&nbsp<a href='?src=\ref[caller];toggle_aspect=[name]'><font color='[ticked ? "#E67300" : "#3366CC"]'>[name]</font></a>"
	else
		result += "<img src='[name]_small.png'>&nbsp&nbsp<font color='[ticked ? "#E67300" : "#3366CC"]'>[name]</font>"
	*/

	if(caller)
		result += "<a href='?src=\ref[caller];toggle_aspect=[name]'><font color='[ticked ? "#E67300" : "#3366CC"]'>[name]</font></a>"
	else
		result += "<font color='[ticked ? "#E67300" : "#3366CC"]'>[name]</font>"

	result += "</td><td>"
	if(ticked)
		result += "<font size=1><i>[desc]</i></font>"
	result += "</td></tr>"
	if(children.len && !(ignore_children_if_unticked && !ticked))
		for(var/decl/aspect/A in children)
			result += A.get_aspect_selection_data(caller, ticked_aspects, (recurse_level+1), ignore_children_if_unticked)
	return result

// Helpers.
/datum/mind/var/list/aspects = list()

/mob/proc/has_aspect(var/skillname)
	if(!mind || !mind.aspects.len)
		return 0
	return (skillname in mind.aspects)

/mob/proc/get_aspect_data(var/mob/show_to)

	if(!mind)
		show_to << "That mob has no mind."
		return
	if(!mind.aspects || !mind.aspects.len)
		show_to << "That mob has no aspects."
		return

	var/dat = "<b>[mind.aspects.len]/[config.max_character_aspects] aspects chosen.</b><br>"

	for(var/aspect_category in aspect_categories)
		var/datum/aspect_category/AC = aspect_categories[aspect_category]
		if(!istype(AC))
			continue
		var/printed_cat
		for(var/decl/aspect/A in AC.aspects)
			if(A.name in mind.aspects)
				if(!printed_cat)
					printed_cat = 1
					dat += "<b>[AC.category]:</b><br>"
				dat += "[A.name]: <font size=1><i>[A.desc]</i></font><br>"
		if(printed_cat)
			dat += "<br><hr><br>"

	if(dat)
		show_to << browse(dat, "window=aspect_list_[mind.name];size=600x800")

/mob/verb/show_own_aspects()
	set category = "IC"
	set name = "Show Own Aspects"
	get_aspect_data(src)

/datum/admins/proc/show_aspects()
	set category = "Admin"
	set name = "Show Aspects"
	if (!istype(src,/datum/admins))
		src = usr.client.holder
	if (!istype(src,/datum/admins))
		usr << "Error: you are not an admin!"
		return
	var/list/valid_mobs = list()
	for(var/mob/M in (living_mob_list + dead_mob_list)) // I swear there used to be a mob_list.
		if(M.mind)
			valid_mobs += M
	var/mob/M = input("Select mob.", "Select mob.") as null|anything in valid_mobs
	if(!M) return
	M.get_aspect_data(usr)
	return

/mob/living/proc/apply_aspects()
	return

/mob/living/human/apply_aspects()
	if(!mind || !mind.aspects || !mind.aspects.len)
		return
	for(var/aspect in mind.aspects)
		var/decl/aspect/A = aspects_by_name[aspect]
		if(istype(A))
			A.do_post_spawn(src)
