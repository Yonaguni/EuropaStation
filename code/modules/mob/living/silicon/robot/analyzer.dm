//
//Robotic Component Analyser, basically a health analyser for robots
//
/obj/item/robotanalyzer
	name = "robot analyzer"
	icon_state = "robotanalyzer"
	item_state = "analyzer"
	desc = "A hand-held scanner able to diagnose robotic injuries."
	flags = CONDUCT
	slot_flags = SLOT_BELT
	throwforce = 3
	w_class = 2.0
	throw_speed = 5
	throw_range = 10

	matter = list(MATERIAL_STEEL = 500, MATERIAL_GLASS = 200)
	var/mode = 1;

/obj/item/robotanalyzer/attack(var/mob/living/M, var/mob/living/user)

	var/scan_type
	if(istype(M, /mob/living/silicon/robot))
		scan_type = "robot"
	else if(istype(M, /mob/living/carbon/human))
		scan_type = "prosthetics"
	else
		user << "\red You can't analyze non-robotic things!"
		return

	user.visible_message("<span class='notice'>\The [user] has analyzed [M]'s components.</span>","<span class='notice'>You have analyzed [M]'s components.</span>")
	switch(scan_type)
		if("robot")
			var/BU = M.getFireLoss() > 50 	? 	"<b>[M.getFireLoss()]</b>" 		: M.getFireLoss()
			var/BR = M.getBruteLoss() > 50 	? 	"<b>[M.getBruteLoss()]</b>" 	: M.getBruteLoss()
			user.show_message("\blue Analyzing Results for [M]:\n\t Overall Status: [M.stat > 1 ? "fully disabled" : "[M.health - M.halloss]% functional"]")
			user.show_message("\t Key: <font color='#FFA500'>Electronics</font>/<font color='red'>Brute</font>", 1)
			user.show_message("\t Damage Specifics: <font color='#FFA500'>[BU]</font> - <font color='red'>[BR]</font>")
			if(M.tod && M.stat == DEAD)
				user.show_message("\blue Time of Disable: [M.tod]")
			var/mob/living/silicon/robot/H = M
			var/list/damaged = H.get_damaged_components(1,1,1)
			user.show_message("\blue Localized Damage:",1)
			if(length(damaged)>0)
				for(var/datum/robot_component/org in damaged)
					user.show_message(text("\blue \t []: [][] - [] - [] - []",	\
					capitalize(org.name),					\
					(org.installed == -1)	?	"<font color='red'><b>DESTROYED</b></font> "							:"",\
					(org.electronics_damage > 0)	?	"<font color='#FFA500'>[org.electronics_damage]</font>"	:0,	\
					(org.brute_damage > 0)	?	"<font color='red'>[org.brute_damage]</font>"							:0,		\
					(org.toggled)	?	"Toggled ON"	:	"<font color='red'>Toggled OFF</font>",\
					(org.powered)	?	"Power ON"		:	"<font color='red'>Power OFF</font>"),1)
			else
				user.show_message("\blue \t Components are OK.",1)
			if(H.emagged && prob(5))
				user.show_message("\red \t ERROR: INTERNAL SYSTEMS COMPROMISED",1)
			user.show_message("\blue Operating Temperature: [M.bodytemperature-T0C]&deg;C ([M.bodytemperature*1.8-459.67]&deg;F)", 1)

		if("prosthetics")

			var/mob/living/carbon/human/H = M
			user << "<span class='notice'>Analyzing Results for \the [H]:</span>"
			if(H.isSynthetic())
				user << "System instability: <font color='green'>[H.getToxLoss()]</font>"
			user << "Key: <font color='#FFA500'>Electronics</font>/<font color='red'>Brute</font>"
			user << "<span class='notice'>External prosthetics:</span>"
			var/organ_found
			if(H.internal_organs.len)
				for(var/obj/item/organ/external/E in H.organs)
					if(!(E.robotic >= ORGAN_ROBOT))
						continue
					organ_found = 1
					user << "[E.name]: <font color='red'>[E.brute_dam]</font> <font color='#FFA500'>[E.burn_dam]</font>"
			if(!organ_found)
				user << "No prosthetics located."
			user << "<hr>"
			user << "<span class='notice'>Internal prosthetics:</span>"
			organ_found = null
			if(H.internal_organs.len)
				for(var/obj/item/organ/O in H.internal_organs)
					if(!(O.robotic >= ORGAN_ROBOT))
						continue
					organ_found = 1
					user << "[O.name]: <font color='red'>[O.damage]</font>"
			if(!organ_found)
				user << "No prosthetics located."

	src.add_fingerprint(user)
	return
