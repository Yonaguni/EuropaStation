/datum/category_item/player_setup_item/aspects
	name = "Aspects"
	sort_order = 1

/datum/category_item/player_setup_item/aspects/load_character(var/savefile/S)
	S["aspects"] >> pref.aspects

/datum/category_item/player_setup_item/aspects/save_character(var/savefile/S)
	S["aspects"] << pref.aspects

/datum/category_item/player_setup_item/aspects/sanitize_character()
	// Either they have never had aspects before, or they have too many.
	if(!pref.aspects || pref.aspects.len > config.max_character_aspects)
		pref.aspects = list()
	for(var/aspect in pref.aspects)
		if(!(aspect in aspects_by_name))
			pref.aspects -= aspect

/datum/category_item/player_setup_item/aspects/content()

	// Make sure we have an aspect list and forward the icons to the client.
	populate_aspects()
	for(var/decl/aspect/A in aspect_datums)
		usr << browse_rsc(A.use_icon, "[A.name]_small.png")

	// Change our formatting data if needed.
	var/fcolor =  "#3366CC"
	if(pref.aspects.len == config.max_character_aspects)
		fcolor = "#E67300"

	// Build the string.
	. += "<table align = 'center' width = 500px>"
	. += "<tr><td colspan=2><center><b><font color = '[fcolor]'>[pref.aspects.len]/[config.max_character_aspects]</font> aspects chosen.</b></center></td></tr>"

	for(var/aspect_category in aspect_categories)
		var/datum/aspect_category/AC = aspect_categories[aspect_category]
		if(!istype(AC))
			continue
		. += "<tr><td colspan=2><hr></td></tr>"
		. += "<tr><td colspan=2><b><center>[AC.category]</center></b></td></tr>"
		. += "<tr><td colspan=2><hr></td></tr>"
		for(var/decl/aspect/A in AC.aspects)
			if(A.parent)
				continue
			. += A.get_aspect_selection_data(src, pref.aspects)
	. += "</table>"

/datum/category_item/player_setup_item/aspects/OnTopic(href, href_list, user)
	if(href_list["toggle_aspect"])
		var/aspect_text = href_list["toggle_aspect"]
		if(aspect_text in pref.aspects)
			var/decl/aspect/A = aspects_by_name[aspect_text]
			var/list/aspects_to_remove = list()
			if(A && A.children)
				aspects_to_remove = A.children.Copy()
			while(aspects_to_remove.len)
				A = aspects_to_remove[1]
				aspects_to_remove -= A
				pref.aspects -= A.name
				if(A.children)
					aspects_to_remove |= A.children.Copy()
			pref.aspects -= aspect_text
		else
			if(pref.aspects.len < config.max_character_aspects)
				pref.aspects |= aspect_text
		return TOPIC_REFRESH
	return ..()
