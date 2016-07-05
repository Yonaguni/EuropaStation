//The mob should have a gender you want before running this proc. Will run fine without H
/datum/preferences/proc/randomize_appearance_for(var/mob/living/human/H)
	gender = pick(MALE, FEMALE)
	var/datum/species/current_species = all_species[species]

	if(current_species)
		if(current_species.appearance_flags & HAS_SKIN_TONE)
			s_tone = random_skin_tone()
		if(current_species.appearance_flags & HAS_SKIN_COLOR)
			r_skin = rand (0,255)
			g_skin = rand (0,255)
			b_skin = rand (0,255)
		if(current_species.appearance_flags & HAS_EYE_COLOR)
			randomize_eyes_color()
		if(current_species.appearance_flags & HAS_SKIN_COLOR)
			randomize_skin_color()
		if(current_species.appearance_flags & HAS_UNDERWEAR)
			if(gender == FEMALE)
				underwear = underwear_f[pick(underwear_f)]
			else
				underwear = underwear_m[pick(underwear_m)]

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

	backbag = rand(1,4)
	age = rand(current_species.min_age, current_species.max_age)
	b_type = RANDOM_BLOOD_TYPE
	if(H)
		copy_to(H,1)


/datum/preferences/proc/randomize_hair_color(var/target = "hair")
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

/datum/preferences/proc/randomize_eyes_color()
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

/datum/preferences/proc/randomize_skin_color()
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

/datum/preferences/proc/dress_preview_mob(var/mob/living/human/mannequin)
	copy_to(mannequin)

	if(!dress_mob)
		return

	var/datum/job/previewJob
	for(var/jobtitle in job_preferences)
		if(job_preferences[jobtitle] == JOB_HIGH)
			previewJob = job_master.GetJob(jobtitle)
			break

	if(!previewJob)
		previewJob = job_master.GetJob(using_map.default_title)

	if(previewJob)
		job_master.EquipRank(mannequin, previewJob.title, FALSE, TRUE, use_client=client)
		mannequin.update_icons()

/datum/preferences/proc/update_preview_icon()
	var/mob/living/human/dummy/mannequin/mannequin = get_mannequin(client_ckey)

	// So they don't initialize before roundstart.
	for(var/atom/movable/AM in mannequin)
		all_movable_atoms -= AM
	mannequin.delete_inventory(TRUE)
	dress_preview_mob(mannequin)

	preview_icon = icon('icons/effects/effects.dmi', "nothing")
	preview_icon.Scale(48+32, 16+32)

	mannequin.dir = NORTH
	var/icon/stamp = getFlatIcon(mannequin)
	preview_icon.Blend(stamp, ICON_OVERLAY, 25, 17)

	mannequin.dir = WEST
	stamp = getFlatIcon(mannequin)
	preview_icon.Blend(stamp, ICON_OVERLAY, 1, 9)

	mannequin.dir = SOUTH
	stamp = getFlatIcon(mannequin)
	preview_icon.Blend(stamp, ICON_OVERLAY, 49, 1)

	preview_icon.Scale(preview_icon.Width() * 2, preview_icon.Height() * 2) // Scaling here to prevent blurring in the browser.