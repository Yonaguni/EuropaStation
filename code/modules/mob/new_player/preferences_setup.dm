datum/preferences
	//The mob should have a gender you want before running this proc. Will run fine without H
	proc/randomize_appearance_for(var/mob/living/carbon/human/H)
		gender = pick(MALE, FEMALE)
		var/datum/species/current_species = all_species[species]

		if(current_species)
			if(current_species.appearance_flags & HAS_SKIN_TONE)
				s_tone = random_skin_tone()
			if(current_species.appearance_flags & HAS_EYE_COLOR)
				randomize_eyes_color()
			if(current_species.appearance_flags & HAS_SKIN_COLOR)
				randomize_skin_color()
			if(current_species.appearance_flags & HAS_UNDERWEAR)
				if(gender == FEMALE)
					underwear = underwear_f[pick(underwear_f)]
				else
					underwear = underwear_m[pick(underwear_m)]
				undershirt = undershirt_t[pick(undershirt_t)]


		var/use_head_species
		var/obj/item/organ/external/head/temp_head = H.get_organ(BP_HEAD)
		if(temp_head)
			use_head_species = temp_head.species.get_bodytype()
		else
			use_head_species = H.species.get_bodytype()

		if(use_head_species)
			h_style = random_hair_style(gender, species)
			f_style = random_facial_hair_style(gender, species)

		randomize_hair_color("hair")
		randomize_hair_color("facial")

		backbag = 2
		age = rand(current_species.min_age, current_species.max_age)
		if(H)
			copy_to(H,1)


	proc/randomize_hair_color(var/target = "hair")
		if(prob (75) && target == "facial") // Chance to inherit hair color
			r_facial = r_hair
			g_facial = g_hair
			b_facial = b_hair
			return

		var/red
		var/green
		var/blue

		var/col = pick ("blonde", "black", "chestnut", "copper", "brown", "wheat", "old", "punk")
		switch(col)
			if("blonde")
				red = 255
				green = 255
				blue = 0
			if("black")
				red = 0
				green = 0
				blue = 0
			if("chestnut")
				red = 153
				green = 102
				blue = 51
			if("copper")
				red = 255
				green = 153
				blue = 0
			if("brown")
				red = 102
				green = 51
				blue = 0
			if("wheat")
				red = 255
				green = 255
				blue = 153
			if("old")
				red = rand (100, 255)
				green = red
				blue = red
			if("punk")
				red = rand (0, 255)
				green = rand (0, 255)
				blue = rand (0, 255)

		red = max(min(red + rand (-25, 25), 255), 0)
		green = max(min(green + rand (-25, 25), 255), 0)
		blue = max(min(blue + rand (-25, 25), 255), 0)

		switch(target)
			if("hair")
				r_hair = red
				g_hair = green
				b_hair = blue
			if("facial")
				r_facial = red
				g_facial = green
				b_facial = blue

	proc/randomize_eyes_color()
		var/red
		var/green
		var/blue

		var/col = pick ("black", "grey", "brown", "chestnut", "blue", "lightblue", "green", "albino")
		switch(col)
			if("black")
				red = 0
				green = 0
				blue = 0
			if("grey")
				red = rand (100, 200)
				green = red
				blue = red
			if("brown")
				red = 102
				green = 51
				blue = 0
			if("chestnut")
				red = 153
				green = 102
				blue = 0
			if("blue")
				red = 51
				green = 102
				blue = 204
			if("lightblue")
				red = 102
				green = 204
				blue = 255
			if("green")
				red = 0
				green = 102
				blue = 0
			if("albino")
				red = rand (200, 255)
				green = rand (0, 150)
				blue = rand (0, 150)

		red = max(min(red + rand (-25, 25), 255), 0)
		green = max(min(green + rand (-25, 25), 255), 0)
		blue = max(min(blue + rand (-25, 25), 255), 0)

		r_eyes = red
		g_eyes = green
		b_eyes = blue

	proc/randomize_skin_color()
		var/red
		var/green
		var/blue

		var/col = pick ("black", "grey", "brown", "chestnut", "blue", "lightblue", "green", "albino")
		switch(col)
			if("black")
				red = 0
				green = 0
				blue = 0
			if("grey")
				red = rand (100, 200)
				green = red
				blue = red
			if("brown")
				red = 102
				green = 51
				blue = 0
			if("chestnut")
				red = 153
				green = 102
				blue = 0
			if("blue")
				red = 51
				green = 102
				blue = 204
			if("lightblue")
				red = 102
				green = 204
				blue = 255
			if("green")
				red = 0
				green = 102
				blue = 0
			if("albino")
				red = rand (200, 255)
				green = rand (0, 150)
				blue = rand (0, 150)

		red = max(min(red + rand (-25, 25), 255), 0)
		green = max(min(green + rand (-25, 25), 255), 0)
		blue = max(min(blue + rand (-25, 25), 255), 0)

		r_skin = red
		g_skin = green
		b_skin = blue


	proc/update_preview_icon()		//seriously. This is horrendous.
		qdel(preview_icon_front)
		qdel(preview_icon_side)
		qdel(preview_icon)

		var/g = "m"
		if(gender == FEMALE)	g = "f"

		var/icon/icobase
		var/datum/species/current_species = all_species[species]

		if(current_species)
			icobase = current_species.icobase
		else
			icobase = 'icons/mob/human_races/r_human.dmi'

		preview_icon = new /icon(icobase, "")
		for(var/name in BP_ALL)
			if(organ_data[name] == "amputated")
				continue
			if(organ_data[name] == "cyborg")
				var/datum/robolimb/R
				if(rlimb_data[name])
					R = get_robolimb_by_name(rlimb_data[name])
				if(!R) R = get_robolimb_by_path(/datum/robolimb)
				if(name in list(BP_TORSO, BP_GROIN, BP_HEAD))
					preview_icon.Blend(icon(R.icon, "[name]_[g]"), ICON_OVERLAY)
				else
					preview_icon.Blend(icon(R.icon, "[name]"), ICON_OVERLAY)
				continue
			var/icon/limb_icon
			if(name in list(BP_TORSO, BP_GROIN, BP_HEAD))
				limb_icon = new /icon(icobase, "[name]_[g]")
			else
				limb_icon = new /icon(icobase, "[name]")
			// Skin color
			if(current_species && (current_species.appearance_flags & HAS_SKIN_COLOR))
				limb_icon.Blend(rgb(r_skin, g_skin, b_skin), ICON_ADD)
			// Skin tone
			if(current_species && (current_species.appearance_flags & HAS_SKIN_TONE))
				if (s_tone >= 0)
					limb_icon.Blend(rgb(s_tone, s_tone, s_tone), ICON_ADD)
				else
					limb_icon.Blend(rgb(-s_tone,  -s_tone,  -s_tone), ICON_SUBTRACT)
			preview_icon.Blend(limb_icon, ICON_OVERLAY)

		//Tail
		if(current_species && (current_species.tail))
			var/icon/temp = new/icon("icon" = 'icons/effects/species.dmi', "icon_state" = "[current_species.tail]_s")
			if(current_species && (current_species.appearance_flags & HAS_SKIN_COLOR))
				temp.Blend(rgb(r_skin, g_skin, b_skin), ICON_ADD)
			if(current_species && (current_species.appearance_flags & HAS_SKIN_TONE))
				if (s_tone >= 0)
					temp.Blend(rgb(s_tone, s_tone, s_tone), ICON_ADD)
				else
					temp.Blend(rgb(-s_tone,  -s_tone,  -s_tone), ICON_SUBTRACT)
			preview_icon.Blend(temp, ICON_OVERLAY)

		// This is absolute garbage but whatever. It will do until this entire file can be rewritten without crashes.
		var/use_eye_icon = "eyes_s"
		var/list/use_eye_data = current_species.has_limbs[BP_HEAD]
		if(islist(use_eye_data))
			var/use_eye_path = use_eye_data["path"]
			var/obj/item/organ/external/head/temp_head = new use_eye_path ()
			if(istype(temp_head))
				use_eye_icon = temp_head.eye_icon
			qdel(temp_head)

		var/icon/eyes_s = new/icon("icon" = 'icons/mob/creatures/human_face.dmi', "icon_state" = use_eye_icon)


		if ((current_species && (current_species.appearance_flags & HAS_EYE_COLOR)))
			eyes_s.Blend(rgb(r_eyes, g_eyes, b_eyes), ICON_ADD)

		var/datum/sprite_accessory/hair_style = hair_styles_list[h_style]
		if(hair_style)
			var/icon/hair_s = new/icon("icon" = hair_style.icon, "icon_state" = "[hair_style.icon_state]_s")
			hair_s.Blend(rgb(r_hair, g_hair, b_hair), ICON_ADD)
			eyes_s.Blend(hair_s, ICON_OVERLAY)

		var/datum/sprite_accessory/facial_hair_style = facial_hair_styles_list[f_style]
		if(facial_hair_style)
			var/icon/facial_s = new/icon("icon" = facial_hair_style.icon, "icon_state" = "[facial_hair_style.icon_state]_s")
			facial_s.Blend(rgb(r_facial, g_facial, b_facial), ICON_ADD)
			eyes_s.Blend(facial_s, ICON_OVERLAY)

		var/icon/underwear_s = null
		if(underwear && current_species.appearance_flags & HAS_UNDERWEAR)
			underwear_s = new/icon("icon" = 'icons/mob/creatures/human.dmi', "icon_state" = underwear)

		var/icon/undershirt_s = null
		if(undershirt && current_species.appearance_flags & HAS_UNDERWEAR)
			undershirt_s = new/icon("icon" = 'icons/mob/creatures/human.dmi', "icon_state" = undershirt)

		// HA HA NO PREVIEW ICONS FOR YOU UNTIL WE CAN BE FUCKED RECODING THIS
		// (or chinsky fixes his rewrite to avoid crashing people)
		//var/icon/clothes_s = null

		if(disabilities & NEARSIGHTED)
			preview_icon.Blend(new /icon('icons/mob/clothing/eyes.dmi', "glasses"), ICON_OVERLAY)

		preview_icon.Blend(eyes_s, ICON_OVERLAY)
		if(underwear_s)
			preview_icon.Blend(underwear_s, ICON_OVERLAY)
		if(undershirt_s)
			preview_icon.Blend(undershirt_s, ICON_OVERLAY)
		//if(clothes_s)
		//	preview_icon.Blend(clothes_s, ICON_OVERLAY)
		preview_icon_front = new(preview_icon, dir = SOUTH)
		preview_icon_side = new(preview_icon, dir = WEST)

		qdel(eyes_s)
		qdel(underwear_s)
		qdel(undershirt_s)
		//qdel(clothes_s)
