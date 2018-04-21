/datum/chemical_reaction/nullglass
	name = "nullglass"
	id = "nullglass"
	result = null
	required_reagents = list("blood" = 15, "crystalagent" = 1)
	result_amount = 1

/datum/chemical_reaction/nullglass/on_reaction(var/datum/reagents/holder, var/created_volume)
	var/location = get_turf(holder.my_atom)
	for(var/i = 1, i <= created_volume, i++)
		new /obj/item/soulstone(location)

/datum/reagent/crystal
	name = "Crystallizing Agent"
	id = "crystalagent"
	taste_description = "sharpness"
	reagent_state = LIQUID
	color = "#13BC5E"

/datum/reagent/crystal/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(prob(5))
			var/obj/item/organ/external/E = pick(H.organs)
			if(E && !E.is_stump() && !E.robotic && E.organ_tag != BP_CHEST && E.organ_tag != BP_GROIN)
				H << "<span class='danger'>Your [E.name] is being lacerated from within!</span>"
				if(H.can_feel_pain())
					H.emote("scream")
				for(var/i = 1 to rand(3,5))
					new /obj/item/material/shard(get_turf(E), "nullglass")
				E.droplimb(0, DROPLIMB_BLUNT)
				return
	M << "<span class='danger'>Your flesh is being lacerated from within!</span>"
	M.adjustBruteLoss(rand(3,6))
	if(prob(10))
		new /obj/item/material/shard(get_turf(M), "nullglass")
