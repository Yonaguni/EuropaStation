/mob/living/proc/handle_breathing()
	if(!air_master)
		return
	if(life_tick%2==0 || failed_last_breath || (health < config.health_threshold_crit)) //First, resolve location and get a breath
		breathe()

/mob/living/proc/breathe(var/datum/gas_mixture/use_breath)
	var/datum/gas_mixture/breath = null
	if(use_breath)
		breath = use_breath
	else
		breath = get_breath_from_environment()
	handle_breath(breath)
	handle_post_breath(breath)

/mob/living/proc/get_breath_from_environment(var/volume_needed=BREATH_VOLUME)

	if(handle_drowning())
		return null

	var/datum/gas_mixture/breath = null
	var/datum/gas_mixture/environment

	if(loc)
		environment = loc.return_air_for_internal_lifeform()

	if(environment)
		breath = environment.remove_volume(volume_needed)
		handle_chemical_smoke(environment) //handle chemical smoke while we're at it

	if(breath && breath.total_moles)
		//handle mask filtering
		if(istype(wear_mask, /obj/item/clothing/mask) && breath)
			var/obj/item/clothing/mask/M = wear_mask
			var/datum/gas_mixture/filtered = M.filter_air(breath)
			loc.assume_air(filtered)
		return breath
	return null

/mob/living/proc/handle_breath(datum/gas_mixture/breath)
	return

/mob/living/proc/handle_post_breath(datum/gas_mixture/breath)
	if(breath)
		loc.assume_air(breath) //by default, exhale

//Handle possble chem smoke effect
/mob/living/proc/handle_chemical_smoke(var/datum/gas_mixture/environment)
	for(var/obj/effect/effect/smoke/chem/smoke in view(1, src))
		if(smoke.reagents.total_volume)
			smoke.reagents.trans_to_mob(src, 5, CHEM_INGEST, copy = 1)
			smoke.reagents.trans_to_mob(src, 5, CHEM_BLOOD, copy = 1)
			// I dunno, maybe the reagents enter the blood stream through the lungs?
			break // If they breathe in the nasty stuff once, no need to continue checking
