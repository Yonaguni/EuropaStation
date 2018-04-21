var/list/all_factions
var/list/factions_by_name
var/list/chargen_factions

/proc/get_faction(var/faction_name)
	if(!all_factions)
		chargen_factions = list()
		all_factions = list()
		factions_by_name = list()
		for(var/ftype in subtypesof(/datum/faction))
			var/datum/faction/faction = new ftype
			factions_by_name[faction.name] = faction
			all_factions[ftype] = faction
			if(faction.chargen_available)
				chargen_factions += faction.name
	return all_factions[faction_name] ? all_factions[faction_name] : factions_by_name[faction_name]

/datum/faction
	var/name
	var/blurb = "A nondescript faction."
	var/mob_faction = "neutral"
	var/chargen_available = TRUE

	// Character info.
	var/financial_influence = 1
	var/default_language = LANGUAGE_SOLCOM
	var/name_language = null
	var/num_alternate_languages = 2
	var/list/secondary_langs = list()

/datum/faction/proc/get_random_name(var/gender, var/species)
	if(!name_language)
		if(gender == FEMALE)
			return capitalize(pick(first_names_female)) + " " + capitalize(pick(last_names))
		else
			return capitalize(pick(first_names_male)) + " " + capitalize(pick(last_names))
	var/datum/language/faction_language = all_languages[name_language]
	if(!faction_language)
		faction_language = all_languages[default_language]
	if(!faction_language)
		return "unknown"
	return faction_language.get_random_name(gender)
