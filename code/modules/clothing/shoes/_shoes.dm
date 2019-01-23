/obj/item/clothing/shoes
	name = "shoes"
	icon = 'icons/obj/clothing/obj_feet.dmi'
	desc = "Comfortable-looking shoes."
	gender = PLURAL //Carn: for grammarically correct text-parsing
	siemens_coefficient = 0.9
	body_parts_covered = FEET
	slot_flags = SLOT_FEET
	icon_state = "black"
	cold_protection = FEET
	min_cold_protection_temperature = SHOE_MIN_COLD_PROTECTION_TEMPERATURE
	heat_protection = FEET
	max_heat_protection_temperature = SHOE_MAX_HEAT_PROTECTION_TEMPERATURE
	permeability_coefficient = 0.50
	force = 2
	species_restricted = list("exclude", SPECIES_NABBER, SPECIES_UNATHI, SPECIES_VOX)
	sprite_sheets = list(
		SPECIES_VOX = 'icons/mob/species/vox/onmob_feet_vox.dmi',
		SPECIES_UNATHI = 'icons/mob/species/unathi/generated/onmob_feet_unathi.dmi',
		)
	blood_overlay_type = "shoeblood"
	var/can_hold_knife
	var/obj/item/holding
	var/overshoes = 0

/obj/item/clothing/shoes/proc/draw_knife()
	set name = "Draw Boot Knife"
	set desc = "Pull out your boot knife."
	set category = "IC"
	set src in usr

	if(usr.stat || usr.restrained() || usr.incapacitated())
		return

	holding.dropInto(loc)

	if(usr.put_in_hands(holding))
		usr.visible_message("<span class='warning'>\The [usr] pulls \the [holding] out of \the [src]!</span>", range = 1)
		holding = null
		playsound(get_turf(src), 'sound/effects/holster/sheathout.ogg', 25)
	else
		to_chat(usr, "<span class='warning'>Your need an empty, unbroken hand to do that.</span>")
		holding.forceMove(src)

	if(!holding)
		verbs -= /obj/item/clothing/shoes/proc/draw_knife

	update_icon()
	return

/obj/item/clothing/shoes/attack_hand(var/mob/living/M)
	if(can_hold_knife && holding && src.loc == M)
		draw_knife()
		return
	..()

/obj/item/clothing/shoes/attackby(var/obj/item/I, var/mob/user)
	if(can_hold_knife && is_type_in_list(I, list(/obj/item/weapon/material/shard, /obj/item/weapon/material/butterfly, /obj/item/weapon/material/kitchen/utensil, /obj/item/weapon/material/hatchet/tacknife)))
		if(holding)
			to_chat(user, "<span class='warning'>\The [src] is already holding \a [holding].</span>")
			return
		if(!user.unEquip(I, src))
			return
		holding = I
		user.visible_message("<span class='notice'>\The [user] shoves \the [I] into \the [src].</span>", range = 1)
		verbs |= /obj/item/clothing/shoes/proc/draw_knife
		update_icon()
	else
		return ..()

/obj/item/clothing/shoes/on_update_icon()
	overlays.Cut()
	if(holding)
		overlays += image(icon, "[icon_state]_knife")
	return ..()

/obj/item/clothing/shoes/proc/handle_movement(var/turf/walking, var/running)
	return

/obj/item/clothing/shoes/update_clothing_icon()
	if (ismob(src.loc))
		var/mob/M = src.loc
		M.update_inv_shoes()
