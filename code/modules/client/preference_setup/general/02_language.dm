/datum/category_item/player_setup_item/general/language
	name = "Language"
	sort_order = 2

/datum/category_item/player_setup_item/general/language/load_character(var/savefile/S)
	S["language"]			>> pref.alternate_languages
	S["radio_voice"]        >> pref.radio_voice

/datum/category_item/player_setup_item/general/language/save_character(var/savefile/S)
	S["language"]			<< pref.alternate_languages
	S["radio_voice"]        << pref.radio_voice

/datum/category_item/player_setup_item/general/language/sanitize_character()
	if(!islist(pref.alternate_languages))
		pref.alternate_languages = list()
	if(!pref.radio_voice || pref.radio_voice == "")
		if(pref.gender == MALE)
			pref.radio_voice = "a male [pref.species] voice"
		else if(pref.gender == FEMALE)
			pref.radio_voice = "a female [pref.species] voice"
		else
			pref.radio_voice = "a [pref.species] voice"

/datum/category_item/player_setup_item/general/language/content()
	. += "<b>Speech</b><br>"
	. += "<b>Radio voice:</b> [pref.radio_voice] <a href='?src=\ref[src];set_radio_voice=1'>\[change\]</a><br>"
	. += "<b>Languages</b><br>"
	var/datum/species/S = all_species[pref.species]
	if(S.language)
		. += "- [S.language]<br>"
	if(S.default_language && S.default_language != S.language)
		. += "- [S.default_language]<br>"
	if(S.num_alternate_languages)
		if(pref.alternate_languages.len)
			for(var/i = 1 to pref.alternate_languages.len)
				var/lang = pref.alternate_languages[i]
				. += "- [lang] - <a href='?src=\ref[src];remove_language=[i]'>remove</a><br>"

		if(pref.alternate_languages.len < S.num_alternate_languages)
			. += "- <a href='?src=\ref[src];add_language=1'>add</a> ([S.num_alternate_languages - pref.alternate_languages.len] remaining)<br>"
	else
		. += "- [pref.species] cannot choose secondary languages.<br>"

/datum/category_item/player_setup_item/general/language/OnTopic(var/href,var/list/href_list, var/mob/user)
	if(href_list["set_radio_voice"])
		var/raw_choice = sanitize(input(user, "Please enter a radio voice (such as 'a rough baritone' or 'a hissing, rasping voice').", "Character Preference")  as text|null, MAX_NAME_LEN)
		if(raw_choice && CanUseTopic(user))
			pref.radio_voice = raw_choice
		return TOPIC_REFRESH
	else if(href_list["remove_language"])
		var/index = text2num(href_list["remove_language"])
		pref.alternate_languages.Cut(index, index+1)
		return TOPIC_REFRESH
	else if(href_list["add_language"])
		var/datum/species/S = all_species[pref.species]
		if(pref.alternate_languages.len >= S.num_alternate_languages)
			alert(user, "You have already selected the maximum number of alternate languages for this species!")
		else
			var/list/available_languages = S.secondary_langs.Copy()
			for(var/L in all_languages)
				var/datum/language/lang = all_languages[L]
				if(!(lang.flags & RESTRICTED) && (!config.usealienwhitelist || is_alien_whitelisted(user, L) || !(lang.flags & WHITELISTED)))
					available_languages |= L

			// make sure we don't let them waste slots on the default languages
			available_languages -= S.language
			available_languages -= S.default_language
			available_languages -= pref.alternate_languages

			if(!available_languages.len)
				alert(user, "There are no additional languages available to select.")
			else
				var/new_lang = input(user, "Select an additional language", "Character Generation", null) as null|anything in available_languages
				if(new_lang)
					pref.alternate_languages |= new_lang
					return TOPIC_REFRESH
	return ..()
