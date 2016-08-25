//The mob should have a gender you want before running this proc. Will run fine without H
/datum/preferences/proc/randomize_appearance_for(var/mob/living/human/H)
	gender = pick(MALE, FEMALE)
	var/datum/species/current_species = all_species[species]

	if(current_species)
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
	col_hair = "#FFFFFF" //todo

/datum/preferences/proc/randomize_eyes_color()
	col_eyes = "#FFFFFF" //todo

/datum/preferences/proc/randomize_skin_color()
	col_skin = "#FFFFFF" //todo

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

	preview_icon = icon('icons/effects/effects.dmi', "blank")
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