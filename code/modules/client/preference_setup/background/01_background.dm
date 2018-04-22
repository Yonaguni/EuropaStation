/datum/category_item/player_setup_item/background/background
	name = "Background"
	sort_order = 1

/datum/category_item/player_setup_item/background/background/load_character(var/savefile/S)
	S["species"]     >> pref.species
	S["faction"]     >> pref.faction
	S["home_system"] >> pref.home_system

/datum/category_item/player_setup_item/background/background/save_character(var/savefile/S)
	S["species"]     << pref.species
	S["faction"]     << pref.faction
	S["home_system"] << pref.home_system

/datum/category_item/player_setup_item/background/background/sanitize_character()
	if(!pref.species || !(pref.species in playable_species))
		pref.species = DEFAULT_SPECIES
	if(!pref.faction || !(pref.faction in factions_by_name))
		var/datum/faction/faction = get_faction(using_map.default_faction)
		pref.faction = faction.name
	if(!pref.home_system || !(pref.home_system in stellar_locs_by_name))
		var/datum/stellar_location/sloc = get_stellar_location(using_map.default_stellar_location)
		pref.home_system = sloc.name

/datum/category_item/player_setup_item/background/background/content(var/mob/user)

	var/datum/species/current_species = all_species[pref.species]
	. += "<body><center><b>Genotype:</b> [current_species.name] (<a href='?src=\ref[src];change_species=1'>change</a>)</center><hr>"
	. += "<table padding='8px'><tr><td width = 70%>[current_species.blurb]</td><td width = 30% align='center'>"
	if("preview" in icon_states(current_species.get_icobase()))
		usr << browse_rsc(icon(current_species.get_icobase(),"preview"), "species_preview_[current_species.name].png")
		. += "<img src='species_preview_[current_species.name].png' width='64px' height='64px'><br/><br/>"
	. += "<small>"
	if(current_species.spawn_flags & SPECIES_IS_WHITELISTED)
		. += "</br><b>Whitelist restricted.</b>"
	. += "<br><b>Economic power:</b> [round(100*current_species.economic_modifier)]%."
	. += "</small></td></tr></table><hr>"

	var/datum/faction/general_faction = get_faction(pref.faction)
	. += "<center><b>Faction:</b> [pref.faction] (<a href='?src=\ref[src];change_faction=1'>change</a>)</center><hr>"
	. += "<table padding='8px'>"
	. += "<tr><td width = 70%>[general_faction.blurb]</td>"
	. += "<td width = 30%><small>"
	. += "<b>Common language:</b> [general_faction.default_language]<br>"
	. += "<b>Other languages:</b> [english_list(general_faction.secondary_langs, and_text = ", ")]<br>"
	. += "<b>Economic power:</b> [round(100 * general_faction.financial_influence)]%"
	. += "</small></td></tr>"
	. += "</table><hr>"

	var/datum/stellar_location/stellar_location = get_stellar_location(pref.home_system)
	. += "<center><b>Home System:</b> [pref.home_system] (<a href='?src=\ref[src];change_home_system=1'>change</a>)</center><hr>"
	. += "<table padding='8px'>"
	. += "<tr><td width = 70%>[stellar_location.character_info]</td>"
	. += "<td width = 30%><small>"
	. += "<b>Capitol:</b> [stellar_location.capitol]<br>"
	. += "<b>Territory:</b> [stellar_location.ruling_body]<br>"
	. += "<b>Distance:</b> [stellar_location.distance] AU</br>"
	. += "<b>Common language:</b> [stellar_location.default_language]<br>"
	. += "<b>Economic power:</b> [round(100 * stellar_location.economic_power)]%"
	. += "</small></td></tr>"
	. += "</table><hr>"

	.+= "</body>"

/datum/category_item/player_setup_item/background/background/OnTopic(var/href,var/list/href_list, var/mob/user)
	if(href_list["change_faction"])
		var/choice = input("Select a political association.") as null|anything in chargen_factions
		if(choice) pref.faction = choice
		return TOPIC_REFRESH_UPDATE_PREVIEW

	if(href_list["change_home_system"])
		var/choice = input("Select a home system.") as null|anything in stellar_locs_by_name
		if(choice) pref.home_system = choice
		return TOPIC_REFRESH_UPDATE_PREVIEW

	if(href_list["change_species"])

		var/next_species = input("Select a genotype.") as null|anything in playable_species
		if(next_species && next_species != pref.species)

			var/datum/species/current_species = all_species[next_species]
			if(config.usealienwhitelist) //If we're using the whitelist, make sure to check it!n
				if(!(current_species.spawn_flags & SPECIES_CAN_JOIN))
					to_chat(user, "<span class = 'danger'>You cannot play as this species.</br><small>This species is not available for play as a crew race..</small></span>")
					return
				else if((current_species.spawn_flags & SPECIES_IS_WHITELISTED) && !is_alien_whitelisted(preference_mob(),current_species))
					to_chat(user, "<span class = 'danger'>You cannot play as this species.</br><small>If you wish to be whitelisted, you can make an application post on <a href='?src=\ref[user];preference=open_whitelist_forum'>the forums</a>.</small></span>")
					return

			pref.species = next_species
			current_species = pref.get_current_species()
			if(!(pref.gender in current_species.genders))
				pref.gender = current_species.genders[1]

			//grab one of the valid hair styles for the newly chosen species
			var/list/valid_hairstyles = list()
			for(var/hairstyle in hair_styles_list)
				var/datum/sprite_accessory/S = hair_styles_list[hairstyle]
				if(pref.gender == MALE && S.gender == FEMALE)
					continue
				if(pref.gender == FEMALE && S.gender == MALE)
					continue
				if(!(current_species.get_bodytype() in S.species_allowed))
					continue
				valid_hairstyles[hairstyle] = hair_styles_list[hairstyle]

			if(valid_hairstyles.len)
				pref.h_style = pick(valid_hairstyles)
			else
				//this shouldn't happen
				pref.h_style = hair_styles_list["Bald"]

			//grab one of the valid facial hair styles for the newly chosen species
			var/list/valid_facialhairstyles = list()
			for(var/facialhairstyle in facial_hair_styles_list)
				var/datum/sprite_accessory/S = facial_hair_styles_list[facialhairstyle]
				if(pref.gender == MALE && S.gender == FEMALE)
					continue
				if(pref.gender == FEMALE && S.gender == MALE)
					continue
				if(!(current_species.get_bodytype() in S.species_allowed))
					continue

				valid_facialhairstyles[facialhairstyle] = facial_hair_styles_list[facialhairstyle]

			if(valid_facialhairstyles.len)
				pref.f_style = pick(valid_facialhairstyles)
			else
				//this shouldn't happen
				pref.f_style = facial_hair_styles_list["Shaved"]

			//reset hair colour and skin colour
			pref.r_hair = 0//hex2num(copytext(new_hair, 2, 4))
			pref.g_hair = 0//hex2num(copytext(new_hair, 4, 6))
			pref.b_hair = 0//hex2num(copytext(new_hair, 6, 8))
			pref.s_tone = 0
			pref.age = max(min(pref.age, current_species.max_age), current_species.min_age)
			pref.faction = current_species.associated_faction
			return TOPIC_REFRESH_UPDATE_PREVIEW

