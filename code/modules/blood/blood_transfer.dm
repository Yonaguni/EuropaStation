//Gets blood from mob to the container, preserving all data in it.
/mob/living/carbon/proc/take_blood(var/obj/item/reagent_containers/container, var/amount)
	return //todo

//For humans, blood does not appear from blue, it comes from vessels.
/mob/living/carbon/human/take_blood(var/obj/item/reagent_containers/container, var/amount)
	if(!should_have_organ(BP_HEART))
		return null
	if(vessel.get_reagent_amount(REAGENT_BLOOD) < amount)
		return null
	. = ..()
	vessel.remove_reagent(REAGENT_BLOOD,amount) // Removes blood if human

//Transfers blood from container to vessels
/mob/living/carbon/proc/inject_blood(var/datum/reagent/blood/injected, var/amount)
	return //todo

//Transfers blood from reagents to vessel, respecting blood types compatability.
/mob/living/carbon/human/inject_blood(var/datum/reagent/blood/injected, var/amount)
	return //todo

//Gets human's own blood.
/mob/living/carbon/proc/get_blood(datum/reagents/container)
	return get_blood(container)