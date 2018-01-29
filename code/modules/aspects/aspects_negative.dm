/decl/aspect/negative
	name = ASPECT_HAEMOPHILE
	desc = "You're a bleeder."
	use_icon_state = "melee_2"
	aspect_cost = -1
	category = "Maluses"

/decl/aspect/negative/fragile
	name = ASPECT_FRAGILE
	desc = "You are a delicate flower."
	apply_post_species_change = 1

/decl/aspect/negative/fragile/do_post_spawn(var/mob/living/carbon/human/holder)
	if(!istype(holder))
		return
	holder.maxHealth -= (holder.species.total_health * 0.2)

/* Uncomment this when there's actually a negative aspect to it.
/decl/aspect/negative/uncanny
	name = ASPECT_UNCANNY
	desc = "There's something about you that makes people uneasy."
*/

/decl/aspect/negative/paper_skin
	name = ASPECT_PAPER_SKIN
	desc = "You could cut yourself on a plastic spork."
	parent_name = ASPECT_FRAGILE
	apply_post_species_change = 1

/decl/aspect/negative/paper_skin/do_post_spawn(var/mob/living/carbon/human/holder)
	if(!istype(holder))
		return
	for(var/obj/item/organ/external/E in holder.organs)
		E.brute_mod += initial(E.brute_mod)*0.2
		E.burn_mod  += initial(E.burn_mod)*0.2

/decl/aspect/negative/glassbones
	name = ASPECT_GLASS_BONES
	desc = "You break your bones easily."
	apply_post_species_change = 1
	parent_name = ASPECT_FRAGILE

/decl/aspect/negative/glassbones/do_post_spawn(var/mob/living/carbon/human/holder)
	if(!istype(holder))
		return
	for(var/obj/item/organ/external/E in holder.organs)
		E.min_bruised_damage -= initial(E.min_bruised_damage)*0.2
		E.min_broken_damage -=  initial(E.min_broken_damage)*0.2
		E.max_damage -=         initial(E.max_damage)*0.2

/decl/aspect/negative/meaty_hands
	name = ASPECT_MEATY
	desc = "Your hands are freakishly large, and your fingers can't fit through the trigger guard of most guns."

/decl/aspect/negative/epilepsy
	name = ASPECT_EPILEPTIC
	desc = "You are vulnerable to sudden seizures caused by strong stimuli or abuse of alcohol."

/decl/aspect/negative/clumsiness
	name = ASPECT_CLUMSY
	desc = "You are a complete fumble fingers. The simplest actions have a way of smacking you in the face."
	aspect_cost = -2

/decl/aspect/negative/nervous
	name = ASPECT_NERVOUS
	desc = "You stammer. A lot."

/decl/aspect/negative/nearsighted
	name = ASPECT_NEARSIGHTED
	desc = "Jinkies! You just can't see without your glasses."

/decl/aspect/negative/nearsighted/do_post_spawn(var/mob/living/carbon/human/holder)
	if(!istype(holder))
		return
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
	apply_post_species_change = 1

/decl/aspect/negative/deaf/do_post_spawn(var/mob/living/carbon/human/holder)
	if(!istype(holder))
		return
	holder.ear_deaf = 1

/decl/aspect/negative/blind
	name = ASPECT_BLIND
	desc = "You are visually impaired due to a neurological disorder."
	aspect_cost = -2
	parent_name = ASPECT_NEARSIGHTED
	apply_post_species_change = 1

/decl/aspect/negative/blind/do_post_spawn(var/mob/living/carbon/human/holder)
	if(!istype(holder))
		return
	holder.blinded = 1