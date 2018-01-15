/datum/presence_power/rune/freedom
	name = "Rune of the Unwinding Serpent"
	description = "A rune that sheds bindings and clears the minds of a distant believer. Requires three or more believers around the rune."

/datum/presence_power/rune/freedom/invoke(var/mob/invoker, var/mob/living/presence/patron, var/atom/target)

	var/mob/living/carbon/prisoner = input("Who do you wish to free from their bonds?") as null|anything in patron.believers

	if(!istype(prisoner) || prisoner == invoker)
		return FALSE

	var/list/casters = list()
	for(var/mob/living/carbon/C in orange(1,target))
		if(patron.believers[C])
			casters += C

	if(casters.len < 3)
		to_chat(invoker, "<span class='warning'>There are not enough participants around the rune to complete the rite.</span>")
		return FALSE

	. = ..()
	if(!.)
		return FALSE

	var/succeeded = FALSE
	if(prisoner.buckled)
		succeeded = TRUE
		prisoner.buckled.unbuckle_mob()
		prisoner.buckled = null

	if(prisoner.handcuffed)
		succeeded = TRUE
		prisoner.drop_from_inventory(prisoner.handcuffed)

	if(prisoner.legcuffed)
		succeeded = TRUE
		prisoner.drop_from_inventory(prisoner.legcuffed)

	if (istype(prisoner.wear_mask, /obj/item/clothing/mask/muzzle))
		succeeded = TRUE
		prisoner.drop_from_inventory(prisoner.wear_mask)

	if(istype(prisoner.loc, /obj/structure/closet))
		var/obj/structure/closet/closet = prisoner.loc
		if(closet.welded)
			succeeded = TRUE
			closet.welded = 0
			closet.update_icon()
		if(istype(closet, /obj/structure/closet/secure_closet))
			var/obj/structure/closet/secure_closet/secure_closet = closet
			if(secure_closet.locked)
				succeeded = TRUE
				secure_closet.locked = FALSE
				secure_closet.update_icon()

	if(succeeded)
		var/dam = ceil(15/min(1,casters.len))
		for(var/thing in casters)
			var/mob/living/carbon/M = thing
			M.take_overall_damage(dam, 0)
		target.visible_message("<span class='danger'>The rune flashes brilliantly, then dissipates into fine dust.</span>")
		return TRUE
