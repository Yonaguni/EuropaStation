/obj/item/clothing
	name = "clothing"
	siemens_coefficient = 0.9
	var/flash_protection = FLASH_PROTECTION_NONE	         // Sets the item's level of flash protection.
	var/tint = TINT_NONE							         // Sets the item's level of visual impairment tint.

	//Only these species can wear this kit.
	var/list/species_restricted = null

	var/gunshot_residue //Used by forensics.
	var/list/accessories = list()
	var/list/valid_accessory_slots
	var/list/restricted_accessory_slots
	var/list/starting_accessories
	var/blood_overlay_type = "uniformblood"

//Updates the icons of the mob wearing the clothing item, if any.
/obj/item/clothing/proc/update_clothing_icon()
	return

/obj/item/clothing/get_mob_overlay(var/mob/user_mob, var/slot, var/skip_blood)
	var/image/ret = ..()

	if(slot == slot_l_hand_str || slot == slot_r_hand_str)
		return ret

	if(!skip_blood && ishuman(user_mob))
		var/mob/living/carbon/human/user_human = user_mob
		if(blood_DNA)
			var/image/bloodsies = overlay_image(user_human.species.blood_mask, blood_overlay_type, blood_color, RESET_COLOR)
			ret.overlays	+= bloodsies

	if(accessories.len)
		for(var/obj/item/clothing/accessory/A in accessories)
			ret.overlays |= A.get_mob_overlay(user_mob, slot)
	return ret

// Aurora forensics port.
/obj/item/clothing/clean_blood()
	..()
	gunshot_residue = null

/obj/item/clothing/New()
	..()
	if(starting_accessories)
		for(var/T in starting_accessories)
			var/obj/item/clothing/accessory/tie = new T(src)
			src.attach_accessory(null, tie)

//BS12: Species-restricted clothing check.
/obj/item/clothing/mob_can_equip(M as mob, slot)

	//if we can't equip the item anyway, don't bother with species_restricted (cuts down on spam)
	if (!..())
		return 0

	if(species_restricted && istype(M,/mob/living/carbon/human))
		var/exclusive = null
		var/wearable = null
		var/mob/living/carbon/human/H = M

		if("exclude" in species_restricted)
			exclusive = 1

		if(H.species)
			if(exclusive)
				if(!(H.species.get_bodytype(H) in species_restricted))
					wearable = 1
			else
				if(H.species.get_bodytype(H) in species_restricted)
					wearable = 1

			if(!wearable && !(slot in list(slot_l_store, slot_r_store, slot_s_store)))
				H << "<span class='danger'>Your species cannot wear [src].</span>"
				return 0
	return 1

///////////////////////////////////////////////////////////////////////
// Ears: headsets, earmuffs and tiny objects
/obj/item/clothing/ears
	name = "ears"
	w_class = 1.0
	throwforce = 2
	slot_flags = SLOT_EARS
	sprite_sheets = list(BODYTYPE_CORVID = 'icons/mob/species/corvid/ears.dmi')

/obj/item/clothing/ears/update_clothing_icon()
	if (ismob(src.loc))
		var/mob/M = src.loc
		M.update_inv_ears()

/obj/item/clothing/ears/earmuffs
	name = "earmuffs"
	desc = "Protects your hearing from loud noises, and quiet ones as well."
	icon_state = "earmuffs"
	item_state = "earmuffs"
	slot_flags = SLOT_EARS | SLOT_TWOEARS

/obj/item/clothing/ears/earmuffs/headphones
	name = "headphones"
	desc = "It's probably not in accordance with corporate policy to listen to music on the job... but fuck it."
	var/headphones_on = 0
	icon_state = "headphones_off"
	item_state = "headphones"
	slot_flags = SLOT_EARS | SLOT_TWOEARS

/obj/item/clothing/ears/earmuffs/headphones/verb/togglemusic()
	set name = "Toggle Headphone Music"
	set category = "Object"
	set src in usr
	if(!istype(usr, /mob/living)) return
	if(usr.incapacitated()) return

	if(headphones_on)
		icon_state = "headphones_off"
		headphones_on = 0
		usr << "<span class='notice'>You turn the music off.</span>"
	else
		icon_state = "headphones_on"
		headphones_on = 1
		usr << "<span class='notice'>You turn the music on.</span>"

	update_clothing_icon()

///////////////////////////////////////////////////////////////////////
//Glasses
/*
SEE_SELF  // can see self, no matter what
SEE_MOBS  // can see all mobs, no matter what
SEE_OBJS  // can see all objs, no matter what
SEE_TURFS // can see all turfs (and areas), no matter what
SEE_PIXELS// if an object is located on an unlit area, but some of its pixels are
          // in a lit area (via pixel_x, y or smooth movement), can see those pixels
BLIND     // can't see anything
*/
/obj/item/clothing/glasses
	name = "glasses"
	icon = 'icons/obj/clothing/glasses.dmi'
	w_class = 2.0
	body_parts_covered = EYES
	slot_flags = SLOT_EYES
	var/vision_flags = 0
	var/darkness_view = 0//Base human is 2
	var/see_invisible = -1
	sprite_sheets = list(
		BODYTYPE_OCTOPUS = 'icons/mob/species/octopus/eyes.dmi',
		BODYTYPE_CORVID = 'icons/mob/species/corvid/eyes.dmi'
		)

/obj/item/clothing/glasses/get_mob_overlay(mob/user_mob, slot)
	var/image/ret = ..()
	if(item_state_slots && item_state_slots[slot])
		ret.icon_state = item_state_slots[slot]
	else
		ret.icon_state = icon_state
	return ret

/obj/item/clothing/glasses/update_clothing_icon()
	if (ismob(src.loc))
		var/mob/M = src.loc
		M.update_inv_glasses()

///////////////////////////////////////////////////////////////////////
//Gloves
/obj/item/clothing/gloves
	name = "gloves"
	gender = PLURAL //Carn: for grammarically correct text-parsing
	w_class = 2.0
	icon = 'icons/obj/clothing/gloves.dmi'
	siemens_coefficient = 0.75
	var/wired = 0
	var/obj/item/cell/cell = 0
	var/clipped = 0
	body_parts_covered = HANDS
	slot_flags = SLOT_GLOVES
	attack_verb = list("challenged")
	sprite_sheets = list(
		BODYTYPE_CORVID = 'icons/mob/species/corvid/gloves.dmi'
		)
	blood_overlay_type = "bloodyhands"

/obj/item/clothing/gloves/update_clothing_icon()
	if (ismob(src.loc))
		var/mob/M = src.loc
		M.update_inv_gloves()

/obj/item/clothing/gloves/emp_act(severity)
	if(cell)
		//why is this not part of the powercell code?
		cell.charge -= 1000 / severity
		if (cell.charge < 0)
			cell.charge = 0
	..()

// Called just before an attack_hand(), in mob/UnarmedAttack()
/obj/item/clothing/gloves/proc/Touch(var/atom/A, var/proximity)
	return 0 // return 1 to cancel attack_hand()

/obj/item/clothing/gloves/attackby(var/obj/item/W, mob/user)
	if(W.iswirecutter() || istype(W, /obj/item/scalpel))
		if (clipped)
			user << "<span class='notice'>The [src] have already been clipped!</span>"
			update_icon()
			return

		playsound(src.loc, 'sound/items/Wirecutter.ogg', 100, 1)
		user.visible_message("\red [user] cuts the fingertips off of the [src].","\red You cut the fingertips off of the [src].")

		clipped = 1
		name = "modified [name]"
		desc = "[desc]<br>They have had the fingertips cut off of them."
		return

///////////////////////////////////////////////////////////////////////
//Head
/obj/item/clothing/head
	name = "head"
	icon = 'icons/obj/clothing/hats.dmi'
	item_icons = list(
		slot_l_hand_str = 'icons/mob/items/lefthand_hats.dmi',
		slot_r_hand_str = 'icons/mob/items/righthand_hats.dmi',
		)
	body_parts_covered = HEAD
	slot_flags = SLOT_HEAD
	w_class = 2.0

	var/light_overlay = "helmet_light"
	var/light_applied
	var/on = 0

	light_power = 6
	light_range = 5
	light_color = COLOUR_LTEMP_40W_TUNGSTEN

	sprite_sheets = list(
		BODYTYPE_OCTOPUS = 'icons/mob/species/octopus/head.dmi',
		BODYTYPE_CORVID = 'icons/mob/species/corvid/head.dmi'
		)
	blood_overlay_type = "helmetblood"

/obj/item/clothing/head/get_mob_overlay(mob/user_mob, slot)
	var/image/ret = ..()
	var/bodytype = "Default"
	if(ishuman(user_mob))
		var/mob/living/carbon/human/user_human = user_mob
		bodytype = user_human.species.get_bodytype(user_human)
	var/cache_key = "[light_overlay]_[bodytype]"
	if(on && light_overlay_cache[cache_key] && slot == slot_head_str)
		ret.overlays |= light_overlay_cache[cache_key]
	return ret

/obj/item/clothing/head/attack_self(mob/user)
	if(light_power)
		on = !on
		user << "You [on ? "enable" : "disable"] the helmet light."
		update_flashlight(user)
	else
		return ..(user)

/obj/item/clothing/head/proc/update_flashlight(var/mob/user = null)
	if(on && !light_applied)
		set_light()
		light_applied = 1
	else if(!on && light_applied)
		kill_light()
		light_applied = 0
	update_icon(user)
	user.update_action_buttons()

/obj/item/clothing/head/attack_ai(var/mob/user)
	if(!mob_wear_hat(user))
		return ..()

/obj/item/clothing/head/attack_generic(var/mob/user)
	if(!istype(user) || !mob_wear_hat(user))
		return ..()

/obj/item/clothing/head/proc/mob_wear_hat(var/mob/user)
	if(!Adjacent(user))
		return 0
	var/success
	if(istype(user, /mob/living/silicon/robot/drone))
		var/mob/living/silicon/robot/drone/D = user
		if(D.hat)
			success = 2
		else
			D.wear_hat(src)
			success = 1

	if(!success)
		return 0
	else if(success == 2)
		user << "<span class='warning'>You are already wearing a hat.</span>"
	else if(success == 1)
		user << "<span class='notice'>You crawl under \the [src].</span>"
	return 1

/obj/item/clothing/head/update_icon(var/mob/user)

	overlays.Cut()
	var/mob/living/carbon/human/H
	if(istype(user,/mob/living/carbon/human))
		H = user

	if(on)

		// Generate object icon.
		if(!light_overlay_cache["[light_overlay]_icon"])
			light_overlay_cache["[light_overlay]_icon"] = image("icon" = 'icons/obj/light_overlays.dmi', "icon_state" = "[light_overlay]")
		overlays |= light_overlay_cache["[light_overlay]_icon"]

		// Generate and cache the on-mob icon, which is used in update_inv_head().
		var/cache_key = "[light_overlay][H ? "_[H.species.get_bodytype(H)]" : ""]"
		if(!light_overlay_cache[cache_key])
			var/use_icon = 'icons/mob/light_overlays.dmi'
			if(H && sprite_sheets && sprite_sheets[H.species.get_bodytype(H)])
				use_icon = sprite_sheets[H.species.get_bodytype(H)]
			light_overlay_cache[cache_key] = image("icon" = use_icon, "icon_state" = "[light_overlay]")

	if(H)
		H.update_inv_head()

/obj/item/clothing/head/update_clothing_icon()
	if (ismob(src.loc))
		var/mob/M = src.loc
		M.update_inv_head()

///////////////////////////////////////////////////////////////////////
//Mask
/obj/item/clothing/mask
	name = "mask"
	icon = 'icons/obj/clothing/masks.dmi'
	body_parts_covered = HEAD
	slot_flags = SLOT_MASK
	body_parts_covered = FACE|EYES
	sprite_sheets = list(
		BODYTYPE_CORVID = 'icons/mob/species/corvid/masks.dmi'
		)

	var/voicechange = 0
	var/list/say_messages
	var/list/say_verbs
	blood_overlay_type = "maskblood"

/obj/item/clothing/mask/update_clothing_icon()
	if (ismob(src.loc))
		var/mob/M = src.loc
		M.update_inv_wear_mask()

/obj/item/clothing/mask/get_mob_overlay(mob/user_mob, slot)
	var/image/ret = ..()
	if(item_state_slots && item_state_slots[slot])
		ret.icon_state = item_state_slots[slot]
	else
		ret.icon_state = icon_state
	return ret

/obj/item/clothing/mask/proc/filter_air(datum/gas_mixture/air)
	return

///////////////////////////////////////////////////////////////////////
//Suit
/obj/item/clothing/suit
	icon = 'icons/obj/clothing/suits.dmi'
	name = "suit"
	var/fire_resist = T0C+100
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS|LEGS
	allowed = list(/obj/item/tank/emergency)
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	slot_flags = SLOT_OCLOTHING
	blood_overlay_type = "suit"
	siemens_coefficient = 0.9
	w_class = 3

	sprite_sheets = list(
		BODYTYPE_OCTOPUS = 'icons/mob/species/octopus/suit.dmi',
		BODYTYPE_CORVID = 'icons/mob/species/corvid/suit.dmi'
		)

/obj/item/clothing/suit/update_clothing_icon()
	if (ismob(src.loc))
		var/mob/M = src.loc
		M.update_inv_wear_suit()

/obj/item/clothing/suit/get_mob_overlay(mob/user_mob, slot)
	var/image/ret = ..()
	if(item_state_slots && item_state_slots[slot])
		ret.icon_state = item_state_slots[slot]
	else
		ret.icon_state = icon_state
	return ret

/obj/item/clothing/suit/proc/get_collar()
	var/icon/C = new('icons/mob/collar.dmi')
	if(icon_state in C.IconStates())
		return image(C, icon_state)

/obj/item/clothing
	var/global/list/armour_to_descriptive_term = list(
		"melee" = "blunt force",
		"bullet" = "ballistics",
		"melee" = "blunt force",
		"laser" = "lasers",
		"energy" = "energy",
		"bomb" = "explosions",
		"bio" = "biohazards",
		"rad" = "radiation"
		)

// Clothing examine stuff.
/obj/item/clothing/examine(var/mob/user)
	. = ..()
	if(. && user)
		var/list/armor_strings = list()
		for(var/armor_type in armour_to_descriptive_term)
			var/descriptive_attack_type = armour_to_descriptive_term[armor_type]
			if(armor[armor_type])
				switch(armor[armor_type])
					if(1 to 20)
						armor_strings += "It barely protects against [descriptive_attack_type]."
					if(21 to 30)
						armor_strings += "It provides a very small defense against [descriptive_attack_type]."
					if(31 to 40)
						armor_strings += "It offers a small amount of protection against [descriptive_attack_type]."
					if(41 to 50)
						armor_strings += "It offers a moderate defense against [descriptive_attack_type]."
					if(51 to 60)
						armor_strings += "It provides a strong defense against [descriptive_attack_type]."
					if(61 to 70)
						armor_strings += "It is very strong against [descriptive_attack_type]."
					if(71 to 80)
						armor_strings += "This gives a very robust defense against [descriptive_attack_type]."
					if(81 to 99)
						armor_strings += "Wearing this would make you nigh-invulerable against [descriptive_attack_type]."
					if(100)
						armor_strings += "You would be immune to [descriptive_attack_type] if you wore this."

		if(flags & AIRTIGHT)
			armor_strings += "It is airtight."

		if(flags & STOPPRESSUREDAMAGE)
			armor_strings += "Wearing this will protect you from dangerous pressure gradients."

		if(flags & THICKMATERIAL)
			armor_strings += "The material is exceptionally thick."

		if(max_heat_protection_temperature == FIRESUIT_MAX_HEAT_PROTECTION_TEMPERATURE)
			armor_strings += "It provides very good protection against fire and heat."

		if(min_cold_protection_temperature == SPACE_SUIT_MIN_COLD_PROTECTION_TEMPERATURE)
			armor_strings += "It provides very good protection against very cold temperatures."

		var/list/covers = list()
		var/list/slots = list()
		for(var/name in string_part_flags)
			if(body_parts_covered & string_part_flags[name])
				covers += name
		for(var/name in string_slot_flags)
			if(slot_flags & string_slot_flags[name])
				slots += name

		if(covers.len)
			armor_strings += "It covers the [english_list(covers)]."

		if(slots.len)
			armor_strings += "It can be worn on your [english_list(slots)]."

		to_chat(user, jointext(armor_strings, "<br>"))
