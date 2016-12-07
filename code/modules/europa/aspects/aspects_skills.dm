/decl/aspect/appraiser
	name = ASPECT_APPRAISER
	desc = "You know what things are worth."
	use_icon_state = "kitchen_1"
	category = "Skills"

/decl/aspect/exopilot
	name = ASPECT_EXOSUIT_PILOT
	desc = "You know how to get the best out of an exosuit."
	category = "Skills"

/decl/aspect/exotech
	name = ASPECT_EXOSUIT_TECH
	desc = "You know exosuits inside and out, and know how to put them together."
	category = "Skills"

/decl/aspect/daredevil
	name = ASPECT_DAREDEVIL
	desc = "You always land on your feet."
	category = "Skills"

/decl/aspect/hackerman
	name = ASPECT_HACKER
	desc = "Using an RX modulator, you might be able to conduct a mainframe cell direct and hack the uplink to the download."
	category = "Skills"

/* We need a mullet hairstyle.
/decl/aspect/hackerman/do_post_spawn(var/mob/living/carbon/human/holder)
	if(!istype(holder))
		return
	if(holder.species.name == "Human")
		holder.h_style = "Mullet"
*/
