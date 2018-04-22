var/list/all_robolimbs = list()
var/list/chargen_robolimbs = list()
var/datum/robolimb/basic_robolimb

/proc/populate_robolimb_list()
	basic_robolimb = new()
	for(var/limb_type in typesof(/datum/robolimb))
		var/datum/robolimb/R = new limb_type()
		all_robolimbs[R.company] = R
		if(!R.unavailable_at_chargen)
			chargen_robolimbs[R.company] = R

/datum/robolimb
	var/company = "Unbranded"                                 // Shown when selecting the limb.
	var/desc = "A generic unbranded robotic prosthesis."      // Seen when examining a limb.
	var/icon = 'icons/mob/human_races/cyberlimbs/robotic.dmi' // Icon base to draw from.
	var/unavailable_at_chargen                                // If set, not available at chargen.
	var/unavailable_at_fab                                    // If set, cannot be fabricated.
	var/can_eat
	var/use_eye_icon = "eyes_s"
	var/can_feel_pain
	var/list/species_cannot_use = list(SPECIES_CORVID, SPECIES_OCTOPUS)
	var/list/restricted_to = list()
	var/list/applies_to_part = list() //TODO.

/datum/robolimb/morgan
	company = "Morgan Black"                                 // Shown when selecting the limb.
	desc = "Most authenic faux-wood on the market. The actuators underneath are still metal though."      // Seen when examining a limb.
	icon = 'icons/mob/human_races/cyberlimbs/morgan/morgan_main.dmi' // Icon base to draw from.