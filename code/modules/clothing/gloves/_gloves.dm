/obj/item/clothing/gloves
	name = "gloves"
	gender = PLURAL //Carn: for grammarically correct text-parsing
	w_class = ITEM_SIZE_SMALL
	item_state = "lgloves"
	icon_state = "white"
	icon = 'icons/obj/clothing/obj_hands.dmi'
	siemens_coefficient = 0.75
	body_parts_covered = HANDS
	slot_flags = SLOT_GLOVES
	attack_verb = list("challenged")
	species_restricted = list("exclude",SPECIES_NABBER, SPECIES_UNATHI,SPECIES_VOX)
	sprite_sheets = list(
		SPECIES_VOX = 'icons/mob/species/vox/onmob_hands_vox.dmi',
		SPECIES_NABBER = 'icons/mob/species/nabber/onmob_hands_gas.dmi',
		SPECIES_UNATHI = 'icons/mob/species/unathi/generated/onmob_hands_unathi.dmi',
		)
	blood_overlay_type = "bloodyhands"
	var/wired = 0
	var/obj/item/weapon/cell/cell = 0
	var/clipped = 0
	var/obj/item/clothing/ring/ring = null		//Covered ring
	var/mob/living/carbon/human/wearer = null	//Used for covered rings when dropping

/obj/item/clothing/gloves/Initialize()
	if(item_flags & ITEM_FLAG_PREMODIFIED)
		cut_fingertops()
	. = ..()

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

/obj/item/clothing/gloves/get_fibers()
	return "material from a pair of [name]."

// Called just before an attack_hand(), in mob/UnarmedAttack()
/obj/item/clothing/gloves/proc/Touch(var/atom/A, var/proximity)
	return 0 // return 1 to cancel attack_hand()

/obj/item/clothing/gloves/attackby(obj/item/weapon/W, mob/user)
	if(istype(W, /obj/item/weapon/wirecutters) || istype(W, /obj/item/weapon/scalpel))
		if (clipped)
			to_chat(user, "<span class='notice'>\The [src] have already been modified!</span>")
			update_icon()
			return

		playsound(src.loc, 'sound/items/Wirecutter.ogg', 100, 1)
		user.visible_message("<span class='warning'>\The [user] modifies \the [src] with \the [W].</span>","<span class='warning'>You modify \the [src] with \the [W].</span>")

		cut_fingertops() // apply change, so relevant xenos can wear these
		return

// Applies "clipped" and removes relevant restricted species from the list,
// making them wearable by the specified species, does nothing if already cut
/obj/item/clothing/gloves/proc/cut_fingertops()
	if (clipped)
		return

	clipped = 1
	name = "modified [name]"
	desc = "[desc]<br>They have been modified to accommodate a different shape."
	if("exclude" in species_restricted)
		species_restricted -= SPECIES_UNATHI
	return

/obj/item/clothing/gloves/mob_can_equip(mob/user)
	var/mob/living/carbon/human/H = user

	if(istype(H.gloves, /obj/item/clothing/ring))
		ring = H.gloves
		if(!ring.undergloves)
			to_chat(user, "You are unable to wear \the [src] as \the [H.gloves] are in the way.")
			ring = null
			return 0
		if(!H.unEquip(ring, src))//Remove the ring (or other under-glove item in the hand slot?) so you can put on the gloves.
			ring = null
			return 0

	if(!..())
		if(ring) //Put the ring back on if the check fails.
			if(H.equip_to_slot_if_possible(ring, slot_gloves))
				src.ring = null
		return 0

	if (ring)
		to_chat(user, "You slip \the [src] on over \the [ring].")
	wearer = H //TODO clean this when magboots are cleaned
	return 1

/obj/item/clothing/gloves/dropped()
	..()
	if(!wearer)
		return

	var/mob/living/carbon/human/H = wearer
	if(ring && istype(H))
		if(!H.equip_to_slot_if_possible(ring, slot_gloves))
			ring.dropInto(loc)
		src.ring = null
	wearer = null