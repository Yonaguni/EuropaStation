var/datum/controller/subsystem/codex/SScodex

/datum/controller/subsystem/codex
	name = "Codex"
	flags = SS_NO_FIRE
	var/list/entries_by_path = list()
	var/list/entries_by_string = list()

/datum/controller/subsystem/codex/New()
	NEW_SS_GLOBAL(SScodex)

/datum/controller/subsystem/codex/Initialize()
	// Create general hardcoded entries.
	for(var/ctype in typesof(/datum/codex_entry))
		var/datum/codex_entry/centry = ctype
		if(initial(centry.display_name) || initial(centry.associated_paths) || initial(centry.associated_strings))
			centry = new centry()
			for(var/associated_path in centry.associated_paths)
				entries_by_path[associated_path] = centry
			for(var/associated_string in centry.associated_strings)
				entries_by_string[associated_string] = centry
			if(centry.display_name)
				entries_by_string[centry.display_name] = centry

	// Create entries for reagents/recipes.
	if(!chemical_reagents_list)
		initialize_chemical_reagents()
	if(!chemical_reactions_list)
		initialize_chemical_reactions()

	for(var/rid in chemical_reagents_list)
		var/datum/reagent/reagent = chemical_reagents_list[rid]
		if(!istype(reagent) || reagent.hidden_from_codex)
			continue
		var/datum/codex_entry/entry = new( \
		 _display_name = "[lowertext(reagent.name)] (chemical)", \
		 _associated_strings = list("[lowertext(reagent.name)] pill"), \
		 _lore_text = "[reagent.lore_text] It apparently tastes of [reagent.taste_description].", \
		 _antag_text = reagent.antag_text, \
		 _mechanics_text = reagent.mechanics_text
		)

		var/list/production_strings = list()
		if(chemical_reactions_by_result[reagent.id])
			for(var/datum/chemical_reaction/reaction in chemical_reactions_by_result[reagent.id])

				if(reaction.hidden_from_codex)
					continue

				var/list/reactant_values = list()
				for(var/reactant_id in reaction.required_reagents)
					var/datum/reagent/reactant = chemical_reagents_list[reactant_id]
					if(istype(reactant))
						reactant_values += "[reaction.required_reagents[reactant_id]]u [reactant.name]"

				if(!reactant_values.len)
					continue

				var/list/catalysts = list()
				for(var/catalyst_id in reaction.catalysts)
					var/datum/reagent/catalyst = chemical_reagents_list[catalyst_id]
					if(istype(catalyst))
						catalysts += "[reaction.catalysts[catalyst_id]]u [catalyst.name]"

				var/datum/reagent/result = chemical_reagents_list[reaction.result]
				if(istype(result))
					if(catalysts.len)
						production_strings += "- [jointext(reactant_values, " + ")] (catalysts: [jointext(catalysts, ", ")]): [reaction.result_amount]u [result.name]"
					else
						production_strings += "- [jointext(reactant_values, " + ")]: [reaction.result_amount]u [result.name]"

		if(production_strings.len)
			if(!entry.mechanics_text)
				entry.mechanics_text = "It can be produced as follows:<br>"
			else
				entry.mechanics_text += "<br><br>It can be produced as follows:<br>"
			entry.mechanics_text += jointext(production_strings, "<br>")
		entries_by_string[entry.display_name] = entry

	// Create entries for materials.
	get_material_by_name() // Make sure the list has been populated already.
	for(var/material_name in name_to_material)
		var/material/mat = name_to_material[material_name]
		if(!istype(mat) || mat.hidden_from_codex)
			continue

		var/datum/codex_entry/entry = new(_display_name = "[mat.display_name] (material)")
		entry.lore_text = mat.lore_text
		entry.antag_text = mat.antag_text

		//TODO: summary of material properties and uses.
		entry.mechanics_text = mat.mechanics_text ? mat.mechanics_text : ""

		entries_by_string[entry.display_name] = entry

	// Create entries for locations.
	get_stellar_location()
	for(var/sloc in all_stellar_locations)
		var/datum/stellar_location/stellar_loc = all_stellar_locations[sloc]
		var/datum/codex_entry/entry = new(_display_name = "[stellar_loc.name] (location)")
		entry.lore_text = "[stellar_loc.name]<br><b>Distance from Sol</b>: [stellar_loc.distance]AU"
		if(LAZYLEN(stellar_loc.flavour_locations))
			entry.associated_strings = list()
			entry.lore_text += "<br><br><b>Areas of interest:</b>"
			for(var/specific_loc in stellar_loc.flavour_locations)
				entry.associated_strings += lowertext(specific_loc)
				entry.lore_text += "<br>- <b>[specific_loc]</b>"
				if(stellar_loc.flavour_locations[specific_loc])
					entry.lore_text += " - [stellar_loc.flavour_locations[specific_loc]]"

	// Create entries for factions.

	// Create entries for species.

	// Load additional entries from config.
	// TODO

	. = ..()

/datum/controller/subsystem/codex/proc/get_codex_entry(var/datum/codex_entry/entry, var/skip_specific)
	if(!isnull(entry) && !istype(entry))
		var/thing = entry
		if(istype(thing, /atom))
			var/atom/entity = thing
			if(!skip_specific)
				entry = entity.get_specific_codex_entry()
			if(!entry)
				var/entity_name = sanitize(trim(lowertext(entity.name)))
				if(entries_by_string[entity_name])
					entry = entries_by_string[entity_name]
			if(!entry)
				var/entity_name = sanitize(trim(lowertext(initial(entity.name))))
				if(entries_by_string[entity_name])
					entry = entries_by_string[entity_name]
				else
					entry = entries_by_path[entity.type]
		else if(!isnull(thing))
			var/thing_path = text2path(thing)
			if(ispath(thing_path))
				entry = entries_by_path[thing_path]
			else
				var/entry_name = sanitize(trim(lowertext(thing)))
				if(entry_name)
					entry = entries_by_string[entry_name]
	if(istype(entry))
		return entry

/datum/controller/subsystem/codex/proc/present_codex_entry(var/mob/presenting_to, var/datum/codex_entry/entry)
	if(entry && istype(presenting_to) && presenting_to.client)
		var/list/dat = list("<font size=5>[entry.display_name]</font>")
		if(entry.lore_text)
			dat += "<font color='#298A08'><b>[entry.lore_text]</b></font>"
			dat += " "
		if(entry.mechanics_text)
			dat += "<font color='#084B8A'><b>[entry.mechanics_text]</b></font>"
			dat += " "
		if(entry.antag_text && presenting_to.mind && player_is_antag(presenting_to.mind))
			dat += "<font color='#8A0808'><b>[entry.antag_text]</b></font>"

		if(dat && dat.len)
			presenting_to.client.codex_data = dat
			to_chat(presenting_to, "<span class='notice'>Your codex implant shunts a chunk of data forward. Check the <b>Codex</b> tab for more information.</span>")

/datum/controller/subsystem/codex/proc/retrieve_entries_for_string(var/searching)
	. = list()
	searching = sanitize(lowertext(trim(searching)))
	if(!searching)
		return
	if(entries_by_string[searching])
		return list(entries_by_string[searching])
	for(var/entry_title in entries_by_string)
		if(findtext(entry_title, searching))
			var/datum/codex_entry/entry = entries_by_string[entry_title]
			. |= entry
	. = dd_sortedObjectList(.)

/datum/controller/subsystem/codex/Topic(href, href_list)
	. = ..()
	if(!. && href_list["show_examined_info"] && href_list["show_to"])
		var/atom/showing_atom = locate(href_list["show_examined_info"])
		var/mob/showing_mob =   locate(href_list["show_to"])
		var/entry = get_codex_entry(showing_atom)
		if(entry && showing_mob.can_use_codex())
			present_codex_entry(showing_mob, entry)
			return TRUE
