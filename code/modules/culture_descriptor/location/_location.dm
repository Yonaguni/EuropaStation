/decl/cultural_info/location
	desc_type = "Residence"
	secondary_langs = list(
		LANGUAGE_SIGN
	)
	category = TAG_HOMEWORLD
	var/distance = 0
	var/ruling_body = FACTION_OTHER
	var/capital
	var/list/flavour_locations

/decl/cultural_info/location/get_text_details()
	. = list()
	if(!isnull(capital))
		. += "<b>Capital:</b> [capital]."
	if(!isnull(ruling_body))
		. += "<b>Territory:</b> [ruling_body]."
	if(!isnull(distance))
		. += "<b>Distance from Sol:</b> [distance]."
	. += ..()

/decl/cultural_info/location/other
	name = LOCATION_OTHER
	description = "You are not from any known system."
