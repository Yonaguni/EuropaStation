//Shoes
/obj/item/clothing/shoes
	name = "shoes"
	icon = 'icons/obj/clothing/shoes.dmi'
	icon_state = "white"
	desc = "Comfortable-looking shoes."
	gender = PLURAL //Carn: for grammarically correct text-parsing
	siemens_coefficient = 0.9
	body_parts_covered = FEET
	slot_flags = SLOT_FEET

	var/can_hold_knife
	var/obj/item/holding

	permeability_coefficient = 0.50
	force = 2
	var/overshoes = 0
	sprite_sheets = list(
		BODYTYPE_CORVID = 'icons/mob/species/corvid/shoes.dmi'
		)
	blood_overlay_type = "shoeblood"

/obj/item/clothing/shoes/New()
	..()
	slowdown_per_slot[slot_shoes] = SHOES_SLOWDOWN

/obj/item/clothing/shoes/proc/draw_knife()
	set name = "Draw Boot Knife"
	set desc = "Pull out your boot knife."
	set category = "IC"
	set src in usr

	if(usr.stat || usr.restrained() || usr.incapacitated())
		return

	holding.forceMove(get_turf(usr))

	if(usr.put_in_hands(holding))
		usr.visible_message("<span class='danger'>\The [usr] pulls a knife out of their boot!</span>")
		holding = null
	else
		usr << "<span class='warning'>Your need an empty, unbroken hand to do that.</span>"
		holding.forceMove(src)

	if(!holding)
		verbs -= /obj/item/clothing/shoes/proc/draw_knife

	update_icon()
	return


/obj/item/clothing/shoes/attackby(var/obj/item/I, var/mob/user)
	if(can_hold_knife && is_type_in_list(I, list(/obj/item/material/shard, /obj/item/material/butterfly, /obj/item/material/kitchen/utensil, /obj/item/material/hatchet/tacknife)))
		if(holding)
			user << "<span class='warning'>\The [src] is already holding \a [holding].</span>"
			return
		user.unEquip(I)
		I.forceMove(src)
		holding = I
		user.visible_message("<span class='notice'>\The [user] shoves \the [I] into \the [src].</span>")
		verbs |= /obj/item/clothing/shoes/proc/draw_knife
		update_icon()
	else
		return ..()

/obj/item/clothing/shoes/update_icon()
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