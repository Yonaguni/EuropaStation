/obj/item/flashlight
	name = "flashlight"
	desc = "A hand-held light."
	icon = 'icons/obj/machines/lights.dmi'
	icon_state = "flashlight"
	item_state = "flashlight"
	w_class = 2
	flags = CONDUCT
	slot_flags = SLOT_BELT
	matter = list(DEFAULT_WALL_MATERIAL = 50,"glass" = 20)
	light_type = LIGHT_DIRECTIONAL
	light_power = 5
	light_range = 6
	action_button_name = "Toggle Flashlight"
	var/on = 0

/obj/item/flashlight/mech
	light_power = 6
	light_range = 8

/obj/item/flashlight/initialize()
	..()
	update_icon()

/obj/item/flashlight/update_icon()
	if(on)
		icon_state = "[initial(icon_state)]-on"
		set_light()
	else
		icon_state = "[initial(icon_state)]"
		kill_light()

/obj/item/flashlight/attack_self(mob/user)

	if(!isturf(user.loc) && !istype(user, /mob/living/heavy_vehicle) && !istype(user.loc, /mob/living/heavy_vehicle))
		user << "You cannot turn the light on while in this [user.loc]." //To prevent some lighting anomalities.
		return 0

	on = !on
	update_icon()
	user.update_action_buttons()
	return 1

/obj/item/flashlight/afterattack(var/atom/A, var/mob/user, proximity, params)
	if(light_type == LIGHT_DIRECTIONAL && light_obj)
		var/turf/origin = get_turf(light_obj)
		var/turf/target = get_turf(A)
		if(istype(origin) && istype(target))
			spawn(1)
				light_obj.point_angle = -(round(Atan2(origin.x-target.x,origin.y-target.y)))
				light_obj.update_transform()
				light_obj.cast_light()
			user.visible_message("<span class='notice'>\The [user] points \the [src] at \the [A].</span>")
			return
	return ..()

/obj/item/flashlight/attack(mob/living/M as mob, mob/living/user as mob)
	add_fingerprint(user)
	if(on && user.zone_sel.selecting == O_EYES)

		if((CLUMSY in user.mutations) && prob(50))	//too dumb to use flashlight properly
			return ..()	//just hit them in the head

		var/mob/living/human/H = M	//mob has protective eyewear
		if(istype(H))
			for(var/obj/item/clothing/C in list(H.head,H.wear_mask,H.glasses))
				if(istype(C) && (C.body_parts_covered & EYES))
					user << "<span class='warning'>You're going to need to remove [C.name] first.</span>"
					return

			var/obj/item/organ/vision
			if(H.species.vision_organ)
				vision = H.internal_organs_by_name[H.species.vision_organ]
			if(!vision)
				user << "<span class='warning'>You can't find any [H.species.vision_organ ? H.species.vision_organ : "eyes"] on [H]!</span>"

			user.visible_message("<span class='notice'>\The [user] directs [src] to [M]'s eyes.</span>", \
							 	 "<span class='notice'>You direct [src] to [M]'s eyes.</span>")
			if(H == user)	//can't look into your own eyes buster
				if(M.stat == DEAD || M.blinded)	//mob is dead or fully blind
					user << "<span class='warning'>\The [M]'s pupils do not react to the light!</span>"
					return
				if(XRAY in M.mutations)
					user << "<span class='notice'>\The [M] pupils give an eerie glow!</span>"
				if(vision.damage)
					user << "<span class='warning'>There's visible damage to [M]'s [vision.name]!</span>"
				else if(M.eye_blurry)
					user << "<span class='notice'>\The [M]'s pupils react slower than normally.</span>"
				if(M.getBrainLoss() > 15 || M.has_brain_worms())
					user << "<span class='notice'>There's visible lag between left and right pupils' reactions.</span>"

				var/list/pinpoint = list(REAGENT_ID_MORPHINE=1)
				var/list/dilating = list()
				if(M.reagents.has_any_reagent(pinpoint) || H.ingested.has_any_reagent(pinpoint))
					user << "<span class='notice'>\The [M]'s pupils are already pinpoint and cannot narrow any more.</span>"
				else if(M.reagents.has_any_reagent(dilating) || H.ingested.has_any_reagent(dilating))
					user << "<span class='notice'>\The [M]'s pupils narrow slightly, but are still very dilated.</span>"
				else
					user << "<span class='notice'>\The [M]'s pupils narrow.</span>"

			user.setClickCooldown(DEFAULT_ATTACK_COOLDOWN) //can be used offensively
			M.flash_eyes()
	else
		return ..()
