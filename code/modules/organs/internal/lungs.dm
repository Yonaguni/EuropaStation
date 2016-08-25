/obj/item/organ/internal/lungs
	name = "lungs"
	icon_state = "lungs"
	gender = PLURAL
	organ_tag = O_LUNGS
	parent_organ = BP_CHEST

	var/breath_type
	var/poison_type
	var/exhale_type

	var/min_breath_pressure

	var/safe_exhaled_max = 10
	var/safe_toxins_max = 0.2
	var/SA_para_min = 1
	var/SA_sleep_min = 5

/obj/item/organ/lungs/proc/breathes_water()
	return 0

/obj/item/organ/internal/lungs/New()
	. = ..()
	min_breath_pressure = species.breath_pressure
	breath_type = species.breath_type ? species.breath_type : REAGENT_ID_OXYGEN
	poison_type = species.poison_type ? species.poison_type : REAGENT_ID_FUEL
	exhale_type = species.exhale_type ? species.exhale_type : 0

/obj/item/organ/internal/lungs/process()
	..()

	if(!owner)
		return

	if (germ_level > INFECTION_LEVEL_ONE)
		if(prob(5))
			owner.emote("cough")		//respitory tract infection

	if(is_bruised())
		if(prob(2))
			spawn owner.emote("me", 1, "coughs up blood!")
			owner.drip(10)
		if(prob(4))
			spawn owner.emote("me", 1, "gasps for air!")
			owner.losebreath += 15
