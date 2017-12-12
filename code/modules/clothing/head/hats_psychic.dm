//Psi-boosting item (antag only)
/obj/item/clothing/head/helmet/space/paramount
	name = "cerebro-energetic enhancer"
	desc = "A matte-black, eyeless cerebro-energetic enhancement helmet. Rather unsettling to look at."
	action_button_name = "Install Boosters"
	icon_state = "cerebro"

	item_state_slots = list(
		slot_l_hand_str = "helmet",
		slot_r_hand_str = "helmet"
		)

	var/list/boosted_faculties = list()
	var/static/list/boostable_faculties = list(
		"Coercion" =      PSYCHIC_COERCION,
		"Psychokinesis" = PSYCHIC_PSYCHOKINESIS,
		"Biokinesis" =    PSYCHIC_REDACTION,
		"Creativity" =    PSYCHIC_CREATIVITY
		)

	var/boosted_rank = 5
	var/unboosted_rank = 3
	var/max_boosted_faculties = 3
	var/boosted_psipower = 120

/obj/item/clothing/head/helmet/space/paramount/lesser
	name = "psi-amp"
	desc = "A crown-of-thorns cerebro-energetic enhancer. Kind of looks like a tiara having sex with an industrial robot."
	icon_state = "amp"
	flags_inv = 0
	body_parts_covered = 0

	max_boosted_faculties = 1
	boosted_rank = 3
	unboosted_rank = 1
	boosted_psipower = 50

/obj/item/clothing/head/helmet/space/paramount/New()
	..()
	verbs += /obj/item/clothing/head/helmet/space/paramount/proc/integrate

/obj/item/clothing/head/helmet/space/paramount/attack_self(var/mob/user)

	if(!canremove)
		return ..()

	if(boosted_faculties.len >= max_boosted_faculties)
		integrate()
		return

	var/choice = input("Select a brainboard to install.","CE Rig") as null|anything in boostable_faculties
	if(!choice || !boostable_faculties[choice] || (boostable_faculties[choice] in boosted_faculties))
		return

	boosted_faculties += boostable_faculties[choice]
	var/slots_left = max_boosted_faculties-boosted_faculties.len
	user << "<span class='notice'>You install the [choice] brainboard in \the [src]. There [slots_left!=1 ? "are" : "is"] [slots_left] slot\s left.</span>"

/obj/item/clothing/head/helmet/space/paramount/proc/integrate()

	set name = "Integrate CE Rig"
	set desc = "Enhance your brainpower."
	set category = "Abilities"
	set src in usr

	if(!canremove || !usr.mind)
		return

	if(boosted_faculties.len < max_boosted_faculties)
		usr << "<span class='notice'>You still have [max_boosted_faculties-boosted_faculties.len] facult[boosted_faculties.len == 1 ? "y" : "ies"] to select. Use \the [src] in-hand to select them.</span>"
		return

	var/mob/living/carbon/human/H = loc
	if(!istype(H) || H.head != src)
		usr << "<span class='warning'>\The [src] must be worn on your head in order to be activated.</span>"
		return

	canremove = FALSE
	verbs -= /obj/item/clothing/head/helmet/space/paramount/proc/integrate
	action_button_name = null
	H.update_action_buttons()

	H << "<span class='warning'>You feel a series of sharp pinpricks as \the [src] anaesthetises your scalp before drilling down into your brain...</span>"
	playsound(H, 'sound/weapons/circsawhit.ogg', 50, 1, -1)

	sleep(80)

	for(var/thing in H.mind.psychic_faculties)
		qdel(H.mind.psychic_faculties[thing])
	H.mind.psychic_faculties.Cut()
	for(var/pname in all_psychic_faculties)
		var/datum/psychic_power_assay/assay = new(H.mind, all_psychic_faculties[pname])
		H.mind.psychic_faculties[assay.associated_faculty.name] = assay
		assay.set_rank((pname in boosted_faculties) ? boosted_rank : unboosted_rank)
		sleep(25)

	H.mind.max_psychic_power = boosted_psipower
	H.mind.psychic_power = H.mind.max_psychic_power

	H << "<span class='notice'>\The [src] chimes quietly as it finishes boosting your brain.</span>"
	set_light(1, 1, "#880000")
