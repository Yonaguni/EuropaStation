/decl/aspect/pharmacist
	name = ASPECT_PHARMACIST
	desc = "You know you way around a medication store."
	category = "Skills"
	aspect_flags = ASPECTS_MENTAL

/decl/aspect/appraiser
	name = ASPECT_APPRAISER
	desc = "You know what things are worth."
	use_icon_state = "kitchen_1"
	category = "Skills"
	aspect_flags = ASPECTS_MENTAL

/decl/aspect/exopilot
	name = ASPECT_EXOSUIT_PILOT
	desc = "You know how to get the best out of an exosuit."
	category = "Skills"
	aspect_flags = ASPECTS_MENTAL

/decl/aspect/exotech
	name = ASPECT_EXOSUIT_TECH
	desc = "You know exosuits inside and out, and know how to put them together."
	category = "Skills"
	aspect_flags = ASPECTS_MENTAL

/decl/aspect/daredevil
	name = ASPECT_DAREDEVIL
	desc = "You always land on your feet."
	category = "Skills"
	aspect_flags = ASPECTS_MENTAL

/decl/aspect/hackerman
	name = ASPECT_HACKER
	desc = "Using an RX modulator, you might be able to conduct a mainframe cell direct and hack the uplink to the download."
	category = "Skills"
	aspect_cost = 2
	aspect_flags = ASPECTS_MENTAL

// Temporary mullet stand-in located.
/decl/aspect/hackerman/apply(var/mob/living/carbon/human/holder)
	. = ..()
	if(.)
		if(holder.species.get_bodytype(holder) == BODYTYPE_HUMAN)
			holder.h_style = "Long Hair Alt 2"
		holder.equip_to_slot_if_possible(new /obj/item/clothing/gloves/insulated/hackerman(get_turf(holder)), slot_gloves)
		holder.put_in_hands(new /obj/item/multitool(get_turf(holder)))
