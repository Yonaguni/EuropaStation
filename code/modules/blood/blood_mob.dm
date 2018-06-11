//Blood levels. These are percentages based on the species blood_volume far.
var/const/BLOOD_VOLUME_SAFE =    85
var/const/BLOOD_VOLUME_OKAY =    75
var/const/BLOOD_VOLUME_BAD =     60
var/const/BLOOD_VOLUME_SURVIVE = 40

/mob/living/carbon/human
	var/datum/reagents/vessel // Container for blood and BLOOD ONLY. Do not transfer other chems here.
	var/pale = 0          // Should affect how mob sprite is drawn, but currently doesn't.

//Initializes blood vessels
/mob/living/carbon/human/proc/make_blood()
	if(!vessel)
		vessel = new/datum/reagents(species.blood_volume)
		vessel.my_atom = src
		if(should_have_organ(BP_HEART)) //We want the var for safety but we can do without the actual blood.
			vessel.add_reagent(REAGENT_BLOOD,species.blood_volume)

// Takes care blood loss and regeneration
/mob/living/carbon/human/handle_blood()
	if(in_stasis)
		return

	if(!should_have_organ(BP_HEART))
		return

	var/obj/item/organ/internal/heart/heart = internal_organs_by_name["heart"]
	if(!heart)	//not having a heart is bad for health
		setOxyLoss(max(getOxyLoss(), maxHealth))
		adjustOxyLoss(10)

	//Bleeding out
	var/blood_max = 0
	for(var/obj/item/organ/external/temp in organs)
		if(!(temp.status & ORGAN_BLEEDING) || (temp.robotic >= ORGAN_ROBOT))
			continue
		for(var/datum/wound/W in temp.wounds)
			if(W.bleeding())
				if(temp.applied_pressure)
					if(ishuman(temp.applied_pressure))
						var/mob/living/carbon/human/H = temp.applied_pressure
						H.bloody_hands(src, 0)
					//somehow you can apply pressure to every wound on the organ at the same time
					//you're basically forced to do nothing at all, so let's make it pretty effective
					var/min_eff_damage = max(0, W.damage - 10) / 6 //still want a little bit to drip out, for effect
					blood_max += max(min_eff_damage, W.damage - 30) / 40
				else
					blood_max += W.damage / 40

		if (temp.open)
			blood_max += 2  //Yer stomach is cut open
	drip(blood_max)

//Makes a blood drop, leaking amt units of blood from the mob
/mob/living/carbon/human/proc/drip(var/amt)
	if(HAS_ASPECT(src, ASPECT_HAEMOPHILE))
		amt *= 1.5
	if(remove_blood(amt))
		blood_splatter(src,src)

/mob/living/carbon/human/proc/remove_blood(var/amt)
	if(!should_have_organ(BP_HEART))
		return 0
	if(!amt)
		return 0
	return vessel.remove_reagent(REAGENT_BLOOD, amt * (src.mob_size/MOB_MEDIUM))
