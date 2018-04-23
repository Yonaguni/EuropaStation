/decl/aspect/negative
	name = ASPECT_HAEMOPHILE
	desc = "You're a bleeder."
	use_icon_state = "melee_2"
	aspect_cost = -1
	category = "Maluses"
	transfer_with_mind = FALSE

/decl/aspect/negative/fragile
	name = ASPECT_FRAGILE
	desc = "You are a delicate flower."
	aspect_flags = ASPECTS_PHYSICAL

/decl/aspect/negative/fragile/apply(var/mob/living/carbon/human/holder)
	. = ..()
	if(.)
		holder.maxHealth -= (holder.species.total_health * 0.2)

/decl/aspect/negative/paper_skin
	name = ASPECT_PAPER_SKIN
	desc = "You could cut yourself on a plastic spork."
	parent_name = ASPECT_FRAGILE
	aspect_flags = ASPECTS_PHYSICAL

/decl/aspect/negative/paper_skin/apply(var/mob/living/carbon/human/holder)
	. = ..()
	if(.)
		for(var/obj/item/organ/external/E in holder.organs)
			if(E.robotic < ORGAN_ROBOT)
				E.brute_mod += initial(E.brute_mod)*0.2
				E.burn_mod  += initial(E.burn_mod)*0.2

/decl/aspect/negative/glassbones
	name = ASPECT_GLASS_BONES
	desc = "You break your bones easily."
	parent_name = ASPECT_FRAGILE
	aspect_flags = ASPECTS_PHYSICAL

/decl/aspect/negative/glassbones/apply(var/mob/living/carbon/human/holder)
	. = ..()
	if(.)
		for(var/obj/item/organ/external/E in holder.organs)
			if(E.robotic < ORGAN_ROBOT)
				E.min_bruised_damage -= initial(E.min_bruised_damage)*0.2
				E.min_broken_damage -=  initial(E.min_broken_damage)*0.2
				E.max_damage -=         initial(E.max_damage)*0.2

/decl/aspect/negative/meaty_hands
	name = ASPECT_MEATY
	desc = "Your hands are freakishly large, and your fingers can't fit through the trigger guard of most guns."

/decl/aspect/negative/epilepsy
	name = ASPECT_EPILEPTIC
	desc = "You are vulnerable to sudden seizures caused by strong stimuli or abuse of alcohol."
	transfer_with_mind = TRUE

/decl/aspect/negative/clumsiness
	name = ASPECT_CLUMSY
	desc = "You are a complete fumble fingers. The simplest actions have a way of smacking you in the face."
	aspect_cost = -2
	transfer_with_mind = TRUE

/decl/aspect/negative/nervous
	name = ASPECT_NERVOUS
	desc = "You stammer. A lot."
	aspect_flags = ASPECTS_MENTAL
	transfer_with_mind = TRUE

/decl/aspect/negative/nearsighted
	name = ASPECT_NEARSIGHTED
	desc = "Jinkies! You just can't see without your glasses."
	aspect_flags = ASPECTS_EQUIPMENT

/decl/aspect/negative/nearsighted/apply(var/mob/living/carbon/human/holder)
	. = ..()
	if(.)
		holder.equip_to_slot_or_del(new /obj/item/clothing/glasses/regular(holder), slot_glasses)
		if(istype(holder.glasses, /obj/item/clothing/glasses))
			var/obj/item/clothing/glasses/G = holder.glasses
			G.prescription = 1

/decl/aspect/negative/asthmatic
	name = ASPECT_ASTHMATIC
	desc = "You have sensitive lungs and often suffer from coughing fits."

/decl/aspect/negative/deaf
	name = ASPECT_DEAF
	desc = "You are extremely hard of hearing due to a neurological disorder."
	aspect_cost = -2
	aspect_flags = ASPECTS_MENTAL
	transfer_with_mind = TRUE

/decl/aspect/negative/deaf/apply(var/mob/living/carbon/human/holder)
	. = ..()
	if(.)
		holder.ear_deaf = 1

/decl/aspect/negative/blind
	name = ASPECT_BLIND
	desc = "You are visually impaired due to a neurological disorder."
	aspect_cost = -2
	parent_name = ASPECT_NEARSIGHTED
	aspect_flags = ASPECTS_MENTAL
	transfer_with_mind = TRUE

/decl/aspect/negative/blind/apply(var/mob/living/carbon/human/holder)
	. = ..()
	if(.)
		holder.blinded = 1