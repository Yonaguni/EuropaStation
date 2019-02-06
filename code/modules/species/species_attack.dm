/datum/unarmed_attack/bite/sharp //eye teeth
	attack_verb = list("bit", "chomped on")
	attack_sound = 'sound/weapons/bite.ogg'
	shredding = 0
	sharp = 1
	edge = 1
	attack_name = "sharp bite"

/datum/unarmed_attack/diona
	attack_verb = list("lashed", "bludgeoned")
	attack_noun = list("tendril")
	eye_attack_text = "a tendril"
	eye_attack_text_victim = "a tendril"
	attack_name = "tendrils"

/datum/unarmed_attack/claws
	attack_verb = list("scratched", "clawed", "slashed")
	attack_noun = list("claws")
	eye_attack_text = "claws"
	eye_attack_text_victim = "sharp claws"
	attack_sound = 'sound/weapons/slice.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	sharp = 1
	edge = 1
	attack_name = "claws"

/datum/unarmed_attack/claws/is_usable(var/mob/living/carbon/human/user, var/mob/living/carbon/human/target, var/zone)
	if(user.gloves)
		var/obj/item/clothing/gloves/gloves = user.gloves
		if(istype(gloves) && !gloves.clipped)
			return 0
		else
			return 1
	else
		return 1

/datum/unarmed_attack/claws/show_attack(var/mob/living/carbon/human/user, var/mob/living/carbon/human/target, var/zone, var/attack_damage)
	var/obj/item/organ/external/affecting = target.get_organ(zone)

	attack_damage = Clamp(attack_damage, 1, 5)

	if(target == user)
		user.visible_message("<span class='danger'>[user] [pick(attack_verb)] \himself in the [affecting.name]!</span>")
		return 0

	switch(zone)
		if(BP_HEAD, BP_MOUTH, BP_EYES)
			// ----- HEAD ----- //
			switch(attack_damage)
				if(1 to 2) user.visible_message("<span class='danger'>[user] scratched [target] across \his cheek!</span>")
				if(3 to 4)
					user.visible_message(pick(
						80; user.visible_message("<span class='danger'>[user] [pick(attack_verb)] [target]'s [pick("face", "neck", affecting.name)]!</span>"),
						20; user.visible_message("<span class='danger'>[user] [pick(attack_verb)] [pick("[target] in the [affecting.name]", "[target] across \his [pick("face", "neck", affecting.name)]")]!</span>"),
						))
				if(5)
					user.visible_message(pick(
						"<span class='danger'>[user] rakes \his [pick(attack_noun)] across [target]'s [pick("face", "neck", affecting.name)]!</span>",
						"<span class='danger'>[user] tears \his [pick(attack_noun)] into [target]'s [pick("face", "neck", affecting.name)]!</span>",
						))
		else
			// ----- BODY ----- //
			switch(attack_damage)
				if(1 to 2)	user.visible_message("<span class='danger'>[user] [pick("scratched", "grazed")] [target]'s [affecting.name]!</span>")
				if(3 to 4)
					user.visible_message(pick(
						80; user.visible_message("<span class='danger'>[user] [pick(attack_verb)] [target]'s [affecting.name]!</span>"),
						20; user.visible_message("<span class='danger'>[user] [pick(attack_verb)] [pick("[target] in the [affecting.name]", "[target] across \his [affecting.name]")]!</span>"),
						))
				if(5)		user.visible_message("<span class='danger'>[user] tears \his [pick(attack_noun)] [pick("deep into", "into", "across")] [target]'s [affecting.name]!</span>")

/datum/unarmed_attack/claws/strong
	attack_verb = list("slashed")
	damage = 5
	shredding = 1
	attack_name = "strong claws"

/datum/unarmed_attack/bite/strong
	attack_verb = list("mauled")
	damage = 8
	shredding = 1
	attack_name = "strong bite"
