// Aspects are basically skills + stats + feats all rolled into one. You get to choose a certain number
// of them at character generation and they will alter some interactions with the world. Very WIP.
/decl/aspect
	var/name = "Filler Aspect"                        // Name/unique index.
	var/desc = "An aspect is a kind of skill."        // Flavour text.
	var/use_icon_state = ""                           // State to use for the above.
	//var/icon/use_icon                               // I REALLY HATE \icon A LOT. Causes a lot of lag.
	var/aspect_cost = 1
	var/category = "Traits"                           // Header for root aspects in char prefs.
	var/parent_name
	var/decl/aspect/parent
	var/list/children = list()
	var/available_at_chargen = TRUE

	var/aspect_flags = 0
	var/transfer_with_mind = TRUE
	var/sort_value = 0

/*
/decl/aspect/New()
	..()
	use_icon = icon(icon = 'icons/obj/aspects.dmi', icon_state = use_icon_state)
*/
/decl/aspect/dd_SortValue()
	return sort_value

/decl/aspect/Destroy()
	children.Cut()
	parent = null
	return ..()

/decl/aspect/proc/apply(var/mob/living/carbon/human/holder)
	return (istype(holder))

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
		result += "<a href='?src=\ref[caller];toggle_aspect=[name]'>[ticked ? "<font color='#E67300'>[name]</font>" : "[name]"] ([aspect_cost])</a>"
	else
		result += ticked ? "<font color='#E67300'>[name]</font>" : "[name]"

	result += "</td><td>"
	if(ticked)
		result += "<font size=1><i>[desc]</i></font>"
	result += "</td></tr>"
	if(children.len && !(ignore_children_if_unticked && !ticked))
		for(var/decl/aspect/A in children)
			result += A.get_aspect_selection_data(caller, ticked_aspects, (recurse_level+1), ignore_children_if_unticked)
	return result

/mob/proc/get_aspect_data(var/mob/show_to)

	if(!LAZYLEN(personal_aspects_by_name))
		show_to << "That mob has no aspects."
		return

	var/aspect_cost = 0
	for(var/aspect_name in personal_aspects_by_name)
		var/decl/aspect/A = aspects_by_name[aspect_name]
		if(A)
			aspect_cost += A.aspect_cost

	var/dat = "<b>[aspect_cost]/[config.max_character_aspects] aspects chosen.</b><br>"

	for(var/aspect_category in aspect_categories)
		var/datum/aspect_category/AC = aspect_categories[aspect_category]
		if(!istype(AC))
			continue
		var/printed_cat
		for(var/decl/aspect/A in AC.aspects)
			if(personal_aspects_by_name[A.name])
				if(!printed_cat)
					printed_cat = 1
					dat += "<b>[AC.category]:</b><br>"
				dat += "[A.name]: <font size=1><i>[A.desc]</i></font><br>"
		if(printed_cat)
			dat += "<br><hr><br>"

	if(dat)
		show_to << browse(dat, "window=aspect_list_[name];size=600x800")

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
	var/mob/M = input("Select mob.", "Select mob.") as null|anything in mob_list
	if(!M) return
	M.get_aspect_data(usr)
	return

/mob/proc/apply_aspects(var/aspect_types = 0)
	var/do_update = FALSE
	if(LAZYLEN(personal_aspects))
		if(need_aspect_sort)
			personal_aspects = dd_sortedObjectList(personal_aspects)
			need_aspect_sort = FALSE
		for(var/thing in personal_aspects)
			var/decl/aspect/A = thing
			if(!aspect_types || (aspect_types & A.aspect_flags))
				A.apply(src)
				do_update = TRUE
	return do_update

/mob/living/apply_aspects(var/aspect_type)
	// In case of psi aspects, which defer the update to avoid spamming it 20 times in a row.
	. = ..(aspect_type)
	if(. && psi)
		psi.update()

/mob/living/carbon/human/apply_aspects(var/aspect_type)
	. = ..(aspect_type)
	if(.)
		update_body()
		regenerate_icons()
