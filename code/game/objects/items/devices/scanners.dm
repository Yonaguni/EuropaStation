/*
CONTAINS:
T-RAY
DETECTIVE SCANNER
HEALTH ANALYZER
GAS ANALYZER
MASS SPECTROMETER
REAGENT SCANNER
*/


/obj/item/healthanalyzer
	name = "health analyzer"
	desc = "A hand-held body scanner able to distinguish vital signs of the subject."
	icon_state = "health"
	item_state = "analyzer"
	flags = CONDUCT
	slot_flags = SLOT_BELT
	throwforce = 3
	w_class = 2.0
	throw_speed = 5
	throw_range = 10
	matter = list(MATERIAL_STEEL = 200)

	var/mode = TRUE

/obj/item/healthanalyzer/do_surgery(mob/living/M, mob/living/user)
	if(user.a_intent != I_HELP) //in case it is ever used as a surgery tool
		return ..()
	health_scan_mob(M, user) //default surgery behaviour is just to scan as usual
	return 1

/obj/item/healthanalyzer/attack(mob/living/M, mob/living/user)
	user.setClickCooldown(DEFAULT_ATTACK_COOLDOWN)
	health_scan_mob(M, user, show_limb_damage = mode)

/obj/item/healthanalyzer/verb/toggle_mode()
	set name = "Switch Verbosity"
	set category = "Object"

	mode = !mode
	if(mode)
		usr << "The scanner now shows specific limb damage."
	else
		usr << "The scanner no longer shows limb damage."


/obj/item/analyzer
	name = "analyzer"
	desc = "A hand-held environmental scanner which reports current gas levels."
	icon_state = "atmos"
	item_state = "analyzer"
	w_class = 2.0
	flags = CONDUCT
	slot_flags = SLOT_BELT
	throwforce = 5
	throw_speed = 4
	throw_range = 20

	matter = list(MATERIAL_STEEL = 30,MATERIAL_GLASS = 20)



/obj/item/analyzer/atmosanalyze(var/mob/user)
	var/air = user.return_air()
	if (!air)
		return

	return atmosanalyzer_scan(src, air, user)

/obj/item/analyzer/attack_self(var/mob/user)

	if (user.stat)
		return
	if (!(istype(usr, /mob/living/carbon/human) || ticker) && ticker.mode.name != "monkey")
		usr << "<span class='warning'>You don't have the dexterity to do this!</span>"
		return

	analyze_gases(src, user)
	return

/obj/item/reagent_scanner
	name = "reagent scanner"
	desc = "A hand-held reagent scanner which identifies chemical agents."
	icon_state = "spectrometer"
	item_state = "analyzer"
	w_class = 2.0
	flags = CONDUCT
	slot_flags = SLOT_BELT
	throwforce = 5
	throw_speed = 4
	throw_range = 20
	matter = list(MATERIAL_STEEL = 30,MATERIAL_GLASS = 20)


	var/details = 0
	var/recent_fail = 0

/obj/item/reagent_scanner/afterattack(obj/O, var/mob/user, proximity)
	if(!proximity)
		return
	if (user.stat)
		return
	if (!(istype(user, /mob/living/carbon/human) || ticker) && ticker.mode.name != "monkey")
		user << "<span class='warning'>You don't have the dexterity to do this!</span>"
		return
	if(!istype(O))
		return

	if(!isnull(O.reagents))
		var/dat = ""
		if(O.reagents.volumes.len > 0)
			var/one_percent = O.reagents.total_volume / 100
			for (var/rid in O.reagents.volumes)
				var/datum/reagent/R = SSchemistry.get_reagent(rid)
				dat += "\n \t <span class='notice'>[R.name][details ? ": [O.reagents.volumes[rid] / one_percent]%" : ""]</span>"
		if(dat)
			user << "<span class='notice'>Chemicals found: [dat]</span>"
		else
			user << "<span class='notice'>No active chemical agents found in [O].</span>"
	else
		user << "<span class='notice'>No significant chemical agents found in [O].</span>"

	return

/obj/item/reagent_scanner/adv
	name = "advanced reagent scanner"
	icon_state = "adv_spectrometer"
	details = 1

/obj/item/price_scanner
	name = "price scanner"
	desc = "Using an up-to-date database of various costs and prices, this device estimates the market price of an item up to 0.001% accuracy."
	icon_state = "price_scanner"
	slot_flags = SLOT_BELT
	w_class = 2.0
	throwforce = 0
	throw_speed = 3
	throw_range = 3
	matter = list(MATERIAL_STEEL = 25, MATERIAL_GLASS = 25)

/obj/item/price_scanner/afterattack(atom/movable/target, var/mob/user, proximity)
	if(!proximity)
		return

	var/value = get_value(target)
	user.visible_message("\The [user] scans \the [target] with \the [src]")
	user.show_message("Price estimation of \the [target]: [value ? value : "N/A"] Thalers")