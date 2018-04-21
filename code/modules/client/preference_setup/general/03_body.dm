var/global/list/valid_bloodtypes = list("A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-")

/datum/preferences
	var/has_cortical_stack = TRUE
	var/equip_preview_mob = EQUIP_PREVIEW_ALL

/datum/category_item/player_setup_item/general/body
	name = "Body"
	sort_order = 3

/datum/category_item/player_setup_item/general/body/load_character(var/savefile/S)
	S["species"]			>> pref.species
	S["hair_red"]			>> pref.r_hair
	S["hair_green"]			>> pref.g_hair
	S["hair_blue"]			>> pref.b_hair
	S["facial_red"]			>> pref.r_facial
	S["facial_green"]		>> pref.g_facial
	S["facial_blue"]		>> pref.b_facial
	S["skin_tone"]			>> pref.s_tone
	S["skin_red"]			>> pref.r_skin
	S["skin_green"]			>> pref.g_skin
	S["skin_blue"]			>> pref.b_skin
	S["hair_style_name"]	>> pref.h_style
	S["facial_style_name"]	>> pref.f_style
	S["eyes_red"]			>> pref.r_eyes
	S["eyes_green"]			>> pref.g_eyes
	S["eyes_blue"]			>> pref.b_eyes
	S["b_type"]				>> pref.b_type
	S["has_cortical_stack"] >> pref.has_cortical_stack
	pref.preview_icon = null

/datum/category_item/player_setup_item/general/body/save_character(var/savefile/S)
	S["species"]			<< pref.species
	S["hair_red"]			<< pref.r_hair
	S["hair_green"]			<< pref.g_hair
	S["hair_blue"]			<< pref.b_hair
	S["facial_red"]			<< pref.r_facial
	S["facial_green"]		<< pref.g_facial
	S["facial_blue"]		<< pref.b_facial
	S["skin_tone"]			<< pref.s_tone
	S["skin_red"]			<< pref.r_skin
	S["skin_green"]			<< pref.g_skin
	S["skin_blue"]			<< pref.b_skin
	S["hair_style_name"]	<< pref.h_style
	S["facial_style_name"]	<< pref.f_style
	S["eyes_red"]			<< pref.r_eyes
	S["eyes_green"]			<< pref.g_eyes
	S["eyes_blue"]			<< pref.b_eyes
	S["b_type"]				<< pref.b_type
	S["has_cortical_stack"] << pref.has_cortical_stack

/datum/category_item/player_setup_item/general/body/sanitize_character(var/savefile/S)
	if(!pref.species || !(pref.species in playable_species))
		pref.species = DEFAULT_SPECIES
	pref.r_hair			= sanitize_integer(pref.r_hair, 0, 255, initial(pref.r_hair))
	pref.g_hair			= sanitize_integer(pref.g_hair, 0, 255, initial(pref.g_hair))
	pref.b_hair			= sanitize_integer(pref.b_hair, 0, 255, initial(pref.b_hair))
	pref.r_facial		= sanitize_integer(pref.r_facial, 0, 255, initial(pref.r_facial))
	pref.g_facial		= sanitize_integer(pref.g_facial, 0, 255, initial(pref.g_facial))
	pref.b_facial		= sanitize_integer(pref.b_facial, 0, 255, initial(pref.b_facial))
	pref.s_tone			= sanitize_integer(pref.s_tone, -185, 34, initial(pref.s_tone))
	pref.r_skin			= sanitize_integer(pref.r_skin, 0, 255, initial(pref.r_skin))
	pref.g_skin			= sanitize_integer(pref.g_skin, 0, 255, initial(pref.g_skin))
	pref.b_skin			= sanitize_integer(pref.b_skin, 0, 255, initial(pref.b_skin))
	pref.r_eyes			= sanitize_integer(pref.r_eyes, 0, 255, initial(pref.r_eyes))
	pref.g_eyes			= sanitize_integer(pref.g_eyes, 0, 255, initial(pref.g_eyes))
	pref.b_eyes			= sanitize_integer(pref.b_eyes, 0, 255, initial(pref.b_eyes))
	pref.b_type			= sanitize_text(pref.b_type, initial(pref.b_type))
	pref.has_cortical_stack = sanitize_bool(pref.has_cortical_stack, initial(pref.has_cortical_stack))

	if(pref.gender == MALE)
		pref.h_style		= sanitize_inlist(pref.h_style, hair_styles_male_list, initial(pref.h_style))
		pref.f_style		= sanitize_inlist(pref.f_style, facial_hair_styles_male_list, initial(pref.f_style))
	else if(pref.gender == FEMALE)
		pref.h_style		= sanitize_inlist(pref.h_style, hair_styles_female_list, initial(pref.h_style))
		pref.f_style		= sanitize_inlist(pref.f_style, facial_hair_styles_female_list, initial(pref.f_style))
	else
		pref.h_style		= sanitize_inlist(pref.h_style, hair_styles_list, initial(pref.h_style))
		pref.f_style		= sanitize_inlist(pref.f_style, facial_hair_styles_list, initial(pref.f_style))

/datum/category_item/player_setup_item/general/body/content(var/mob/user)
	. = list()
	if(!pref.preview_icon)
		pref.update_preview_icon()
	user << browse_rsc(pref.preview_icon, "previewicon.png")

	var/datum/species/mob_species = pref.get_current_species()
	. += "<table><tr style='vertical-align:top'><td><b>Body</b> "
	. += "(<a href='?src=\ref[src];random=1'>&reg;</A>)"
	. += "<br>"

	. += "Genotype: <a href='?src=\ref[src];show_species=1'>[pref.species]</a><br>"
	. += "Blood Type: <a href='?src=\ref[src];blood_type=1'>[pref.b_type]</a><br>"

	if(has_flag(mob_species, HAS_SKIN_TONE))
		. += "Skin Tone: <a href='?src=\ref[src];skin_tone=1'>[-pref.s_tone + 35]/220</a><br>"
	. += "<br><br>"

	. += "</td><td><b>Preview</b><br>"
	. += "<div class='statusDisplay'><center><img src=previewicon.png width=[pref.preview_icon.Width()] height=[pref.preview_icon.Height()]></center></div>"
	. += "<br><a href='?src=\ref[src];toggle_preview_value=[EQUIP_PREVIEW_LOADOUT]'>[pref.equip_preview_mob & EQUIP_PREVIEW_LOADOUT ? "Hide loadout" : "Show loadout"]</a>"
	. += "<br><a href='?src=\ref[src];toggle_preview_value=[EQUIP_PREVIEW_JOB]'>[pref.equip_preview_mob & EQUIP_PREVIEW_JOB ? "Hide job gear" : "Show job gear"]</a>"
	. += "</td></tr></table>"

	. += "<b>Hair</b><br>"
	if(has_flag(mob_species, HAS_HAIR_COLOR))
		. += "<a href='?src=\ref[src];hair_color=1'>Change Color</a> <font face='fixedsys' size='3' color='#[num2hex(pref.r_hair, 2)][num2hex(pref.g_hair, 2)][num2hex(pref.b_hair, 2)]'><table style='display:inline;' bgcolor='#[num2hex(pref.r_hair, 2)][num2hex(pref.g_hair, 2)][num2hex(pref.b_hair)]'><tr><td>__</td></tr></table></font> "
	. += " Style: <a href='?src=\ref[src];hair_style=1'>[pref.h_style]</a><br>"

	. += "<br><b>Facial</b><br>"
	if(has_flag(mob_species, HAS_HAIR_COLOR))
		. += "<a href='?src=\ref[src];facial_color=1'>Change Color</a> <font face='fixedsys' size='3' color='#[num2hex(pref.r_facial, 2)][num2hex(pref.g_facial, 2)][num2hex(pref.b_facial, 2)]'><table  style='display:inline;' bgcolor='#[num2hex(pref.r_facial, 2)][num2hex(pref.g_facial, 2)][num2hex(pref.b_facial)]'><tr><td>__</td></tr></table></font> "
	. += " Style: <a href='?src=\ref[src];facial_style=1'>[pref.f_style]</a><br>"

	if(has_flag(mob_species, HAS_EYE_COLOR))
		. += "<br><b>Eyes</b><br>"
		. += "<a href='?src=\ref[src];eye_color=1'>Change Color</a> <font face='fixedsys' size='3' color='#[num2hex(pref.r_eyes, 2)][num2hex(pref.g_eyes, 2)][num2hex(pref.b_eyes, 2)]'><table  style='display:inline;' bgcolor='#[num2hex(pref.r_eyes, 2)][num2hex(pref.g_eyes, 2)][num2hex(pref.b_eyes)]'><tr><td>__</td></tr></table></font><br>"

	if(has_flag(mob_species, HAS_SKIN_COLOR))
		. += "<br><b>Body Color</b><br>"
		. += "<a href='?src=\ref[src];skin_color=1'>Change Color</a> <font face='fixedsys' size='3' color='#[num2hex(pref.r_skin, 2)][num2hex(pref.g_skin, 2)][num2hex(pref.b_skin, 2)]'><table style='display:inline;' bgcolor='#[num2hex(pref.r_skin, 2)][num2hex(pref.g_skin, 2)][num2hex(pref.b_skin)]'><tr><td>__</td></tr></table></font><br>"
	. = jointext(.,null)

/datum/category_item/player_setup_item/general/body/proc/has_flag(var/datum/species/mob_species, var/flag)
	return mob_species && (mob_species.appearance_flags & flag)

/datum/category_item/player_setup_item/general/body/OnTopic(var/href,var/list/href_list, var/mob/user)
	var/datum/species/mob_species = pref.get_current_species()

	if(href_list["random"])
		pref.randomize_appearance_and_body_for()
		return TOPIC_REFRESH_UPDATE_PREVIEW

	else if(href_list["toggle_stack"])
		pref.has_cortical_stack = !pref.has_cortical_stack
		return TOPIC_REFRESH

	else if(href_list["blood_type"])
		var/new_b_type = input(user, "Choose your character's blood-type:", "Character Preference") as null|anything in valid_bloodtypes
		if(new_b_type && CanUseTopic(user))
			pref.b_type = new_b_type
			return TOPIC_REFRESH

	else if(href_list["hair_color"])
		if(!has_flag(mob_species, HAS_HAIR_COLOR))
			return TOPIC_NOACTION
		var/new_hair = input(user, "Choose your character's hair colour:", "Character Preference", rgb(pref.r_hair, pref.g_hair, pref.b_hair)) as color|null
		if(new_hair && has_flag(mob_species, HAS_HAIR_COLOR) && CanUseTopic(user))
			pref.r_hair = hex2num(copytext(new_hair, 2, 4))
			pref.g_hair = hex2num(copytext(new_hair, 4, 6))
			pref.b_hair = hex2num(copytext(new_hair, 6, 8))
			return TOPIC_REFRESH_UPDATE_PREVIEW

	else if(href_list["hair_style"])
		var/list/valid_hairstyles = list()
		for(var/hairstyle in hair_styles_list)
			var/datum/sprite_accessory/S = hair_styles_list[hairstyle]
			if(!(mob_species.get_bodytype() in S.species_allowed))
				continue

			valid_hairstyles[hairstyle] = hair_styles_list[hairstyle]

		var/new_h_style = input(user, "Choose your character's hair style:", "Character Preference", pref.h_style)  as null|anything in valid_hairstyles
		if(new_h_style && CanUseTopic(user))
			pref.h_style = new_h_style
			return TOPIC_REFRESH_UPDATE_PREVIEW

	else if(href_list["facial_color"])
		if(!has_flag(mob_species, HAS_HAIR_COLOR))
			return TOPIC_NOACTION
		var/new_facial = input(user, "Choose your character's facial-hair colour:", "Character Preference", rgb(pref.r_facial, pref.g_facial, pref.b_facial)) as color|null
		if(new_facial && has_flag(mob_species, HAS_HAIR_COLOR) && CanUseTopic(user))
			pref.r_facial = hex2num(copytext(new_facial, 2, 4))
			pref.g_facial = hex2num(copytext(new_facial, 4, 6))
			pref.b_facial = hex2num(copytext(new_facial, 6, 8))
			return TOPIC_REFRESH_UPDATE_PREVIEW

	else if(href_list["eye_color"])
		if(!has_flag(mob_species, HAS_EYE_COLOR))
			return TOPIC_NOACTION
		var/new_eyes = input(user, "Choose your character's eye colour:", "Character Preference", rgb(pref.r_eyes, pref.g_eyes, pref.b_eyes)) as color|null
		if(new_eyes && has_flag(mob_species, HAS_EYE_COLOR) && CanUseTopic(user))
			pref.r_eyes = hex2num(copytext(new_eyes, 2, 4))
			pref.g_eyes = hex2num(copytext(new_eyes, 4, 6))
			pref.b_eyes = hex2num(copytext(new_eyes, 6, 8))
			return TOPIC_REFRESH_UPDATE_PREVIEW

	else if(href_list["skin_tone"])
		if(!has_flag(mob_species, HAS_SKIN_TONE))
			return TOPIC_NOACTION
		var/new_s_tone = input(user, "Choose your character's skin-tone:\n(Light 1 - 220 Dark)", "Character Preference", (-pref.s_tone) + 35)  as num|null
		if(new_s_tone && has_flag(mob_species, HAS_SKIN_TONE) && CanUseTopic(user))
			pref.s_tone = 35 - max(min( round(new_s_tone), 220),1)
			return TOPIC_REFRESH_UPDATE_PREVIEW

	else if(href_list["skin_color"])
		if(!has_flag(mob_species, HAS_SKIN_COLOR))
			return TOPIC_NOACTION
		var/new_skin = input(user, "Choose your character's skin colour: ", "Character Preference", rgb(pref.r_skin, pref.g_skin, pref.b_skin)) as color|null
		if(new_skin && has_flag(mob_species, HAS_SKIN_COLOR) && CanUseTopic(user))
			pref.r_skin = hex2num(copytext(new_skin, 2, 4))
			pref.g_skin = hex2num(copytext(new_skin, 4, 6))
			pref.b_skin = hex2num(copytext(new_skin, 6, 8))
			return TOPIC_REFRESH_UPDATE_PREVIEW

	else if(href_list["facial_style"])
		var/list/valid_facialhairstyles = list()
		for(var/facialhairstyle in facial_hair_styles_list)
			var/datum/sprite_accessory/S = facial_hair_styles_list[facialhairstyle]
			if(pref.gender == MALE && S.gender == FEMALE)
				continue
			if(pref.gender == FEMALE && S.gender == MALE)
				continue
			if(!(mob_species.get_bodytype() in S.species_allowed))
				continue

			valid_facialhairstyles[facialhairstyle] = facial_hair_styles_list[facialhairstyle]

		var/new_f_style = input(user, "Choose your character's facial-hair style:", "Character Preference", pref.f_style)  as null|anything in valid_facialhairstyles
		if(new_f_style && has_flag(mob_species, HAS_HAIR_COLOR) && CanUseTopic(user))
			pref.f_style = new_f_style
			return TOPIC_REFRESH_UPDATE_PREVIEW

	else if(href_list["toggle_preview_value"])
		pref.equip_preview_mob ^= text2num(href_list["toggle_preview_value"])
		return TOPIC_REFRESH_UPDATE_PREVIEW

	return ..()
