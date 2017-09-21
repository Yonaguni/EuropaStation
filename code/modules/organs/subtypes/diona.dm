/proc/spawn_diona_nymph(var/turf/target)
	if(!istype(target))
		return 0

	//This is a terrible hack and I should be ashamed.
	var/datum/seed/diona = SSplants.seeds["diona"]
	if(!diona)
		return 0

	spawn(1) // So it has time to be thrown about by the gib() proc.
		var/mob/living/carbon/alien/diona/D = new(target)
		var/datum/ghosttrap/plant/P = get_ghost_trap("living plant")
		P.request_player(D, "A diona nymph has split off from its gestalt. ")
		spawn(60)
			if(D)
				if(!D.ckey || !D.client)
					D.death()
		return 1

/obj/item/organ/internal/alien/strata
	name = "neural strata"
	parent_organ = BP_CHEST
	organ_tag = "neural strata"

/obj/item/organ/internal/alien/bladder
	name = "gas bladder"
	parent_organ = BP_HEAD
	organ_tag = "gas bladder"

/obj/item/organ/internal/alien/polyp
	name = "polyp segment"
	parent_organ = BP_GROIN
	organ_tag = "polyp segment"

/obj/item/organ/internal/alien/ligament
	name = "anchoring ligament"
	parent_organ = BP_GROIN
	organ_tag = "anchoring ligament"

/obj/item/organ/internal/alien/node
	name = "receptor node"
	parent_organ = BP_HEAD

/obj/item/organ/internal/alien/nutrients
	name = BP_NUTRIENT
	parent_organ = BP_CHEST

// These are different to the standard diona organs as they have a purpose in other
// species (absorbing radiation and light respectively)
/obj/item/organ/internal/alien/nutrients
	name = BP_NUTRIENT
	organ_tag = BP_NUTRIENT
	icon = 'icons/mob/alien.dmi'
	icon_state = "claw"

/obj/item/organ/internal/alien/nutrients/removed(var/mob/user)
	return ..(user, 1)

/obj/item/organ/internal/alien/node
	name = "response node"
	parent_organ = BP_HEAD
	organ_tag = "response node"
	icon = 'icons/mob/alien.dmi'
	icon_state = "claw"

/obj/item/organ/internal/alien/node/removed()
	return
