var/global/list/limb_icon_cache = list()

/obj/item/organ/external/set_dir()
	return

/obj/item/organ/external/proc/compile_icon()
	overlays.Cut()
	 // This is a kludge, only one icon has more than one generation of children though.
	for(var/obj/item/organ/external/organ in contents)
		if(organ.children && organ.children.len)
			for(var/obj/item/organ/external/child in organ.children)
				overlays += child.get_image()
		overlays += organ.get_image()

/obj/item/organ/external/proc/sync_colour_to_human(var/mob/living/human/human)
	if((status & ORGAN_ROBOT) || (species && human.species && species.name != human.species.name))
		return
	col_skin = human.col_skin
	return 1

/obj/item/organ/external/head/sync_colour_to_human(var/mob/living/human/human)
	..()
	col_facial = human.col_facial
	col_hair = human.col_hair
	var/obj/item/organ/internal/eyes/eyes = owner.internal_organs_by_name[O_EYES]
	if(eyes) eyes.update_colour()

/obj/item/organ/external/head/removed()
	get_image()
	..()

/obj/item/organ/external/proc/get_image()
	var/usegender = "m"
	if(gender == FEMALE)
		usegender = "f"
	var/image/return_icon = image(null)
	icon_state = null
	if(force_icon)
		return_icon = image(force_icon, "[icon_name][gendered_icon ? "_[usegender]" : ""]")
	else
		if(!gendered_icon)
			usegender = null
		if (status & ORGAN_ROBOT)
			return_icon.overlays += image('icons/mob/human_races/cyberlimbs/basic.dmi', "[icon_name][usegender ? "_[usegender]" : ""]")
		else
			return_icon.overlays += image(species.icobase, "[icon_name][usegender ? "_[usegender]" : ""]")
			return_icon.color = col_skin
	overlays.Cut()
	overlays += return_icon
	dir = EAST
	return return_icon

/obj/item/organ/external/head/proc/get_eye_image()
	if(owner && owner.should_have_organ(O_EYES))
		var/obj/item/organ/internal/eyes/eyes = owner.internal_organs_by_name[O_EYES]
		if(eye_icon)
			var/image/eye_base = image('icons/mob/creatures/eyes.dmi', "eyes_base")
			if(eyes)
				var/image/pupils = image('icons/mob/creatures/eyes.dmi', eye_icon)
				pupils.color = eyes.col_eyes
				eye_base.overlays += pupils
			else
				eye_base.color = "#AA0000"
			return eye_base
	return image(null)

/obj/item/organ/external/head/proc/get_head_hair_image()
	if(owner && owner.h_style && !(owner.head && (owner.head.flags_inv & BLOCKHEADHAIR)))
		var/datum/sprite_accessory/hair_style = hair_styles_list[owner.h_style]
		if(hair_style && (species.get_bodytype() in hair_style.species_allowed))
			var/image/I = image("icon" = hair_style.icon, "icon_state" = "[hair_style.icon_state]_s")
			if(hair_style.do_colouration)
				I.color = col_hair
			return I
	return image(null)

/obj/item/organ/external/head/proc/get_facial_hair_image()
	if(owner && owner.f_style && !(owner.head && (owner.head.flags_inv & BLOCKHAIR)))
		var/datum/sprite_accessory/facial_hair_style = facial_hair_styles_list[owner.f_style]
		if(facial_hair_style && facial_hair_style.species_allowed && (species.get_bodytype() in facial_hair_style.species_allowed))
			var/image/I = image("icon" = facial_hair_style.icon, "icon_state" = "[facial_hair_style.icon_state]_s")
			if(facial_hair_style.do_colouration)
				I.color = col_facial
			return I
	return image(null)

/obj/item/organ/external/head/proc/get_lip_image()
	if(owner && owner.lip_style && (species && (species.appearance_flags & HAS_LIPS)))
		return image('icons/mob/creatures/human_face.dmi', "lips_[owner.lip_style]_s")
	return image(null)

/obj/item/organ/external/head/get_image()

	var/image/return_image = ..()
	if(!owner || !owner.species)
		return return_image

	var/list/overlays_to_add = list()
	overlays_to_add += get_lip_image()
	overlays_to_add += get_eye_image()
	overlays_to_add += get_head_hair_image()
	overlays_to_add += get_facial_hair_image()

	return_image.overlays += overlays_to_add
	overlays.Cut()
	overlays += return_image
	return return_image

// new damage icon system
// adjusted to set damage_state to brute/burn code only (without r_name0 as before)
/obj/item/organ/external/update_icon()
	var/n_is = damage_state_text()
	if (n_is != damage_state)
		damage_state = n_is
		return 1
	return 0
