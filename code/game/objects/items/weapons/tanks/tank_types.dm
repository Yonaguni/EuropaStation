/* Types of tanks!
 * Contains:
 *		Oxygen
 *		Anesthetic
 *		Air
 *		Phoron
 *		Emergency Oxygen
 */

/*
 * Oxygen
 */
/obj/item/tank/oxygen
	name = "oxygen tank"
	desc = "A tank of oxygen."
	icon_state = GAS_OXYGEN
	distribute_pressure = ONE_ATMOSPHERE*O2STANDARD


/obj/item/tank/oxygen/New()
	..()
	air_contents.adjust_gas(GAS_OXYGEN, (6*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C))


/obj/item/tank/oxygen/yellow
	desc = "A tank of oxygen, this one is yellow."
	icon_state = "oxygen_f"

/obj/item/tank/oxygen/red
	desc = "A tank of oxygen, this one is red."
	icon_state = "oxygen_fr"


/*
 * Anesthetic
 */
/obj/item/tank/anesthetic
	name = "anesthetic tank"
	desc = "A tank with an N2O/O2 gas mix."
	icon_state = "anesthetic"
	item_state = "an_tank"

/obj/item/tank/anesthetic/New()
	..()

	air_contents.gas[GAS_OXYGEN] = (3*ONE_ATMOSPHERE)*70/(R_IDEAL_GAS_EQUATION*T20C) * O2STANDARD
	air_contents.gas[GAS_SLEEPING] = (3*ONE_ATMOSPHERE)*70/(R_IDEAL_GAS_EQUATION*T20C) * N2STANDARD
	air_contents.update_values()

	return

/*
 * Air
 */
/obj/item/tank/air
	name = "air tank"
	desc = "Mixed anyone?"
	icon_state = "oxygen"

/obj/item/tank/air/New()
	..()

	src.air_contents.adjust_multi(GAS_OXYGEN, (6*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C) * O2STANDARD, GAS_NITROGEN, (6*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C) * N2STANDARD)

	return


/*
 * Phoron
 */
/obj/item/tank/phoron
	name = "fuel tank"
	desc = "Contains dangerous fuel gas. Do not inhale. Warning: extremely flammable."
	icon_state = "phoron"
	gauge_icon = null
	flags = CONDUCT
	slot_flags = null	//they have no straps!


/obj/item/tank/phoron/New()
	..()

	src.air_contents.adjust_gas(GAS_FUEL, (3*ONE_ATMOSPHERE)*70/(R_IDEAL_GAS_EQUATION*T20C))
	return

/obj/item/tank/phoron/attackby(var/obj/item/W, var/mob/user)
	..()

	if (istype(W, /obj/item/flamethrower))
		var/obj/item/flamethrower/F = W
		if ((!F.status)||(F.ptank))	return
		src.master = F
		F.ptank = src
		user.remove_from_mob(src)
		src.loc = F
	return

/*
 * Emergency Oxygen
 */
/obj/item/tank/emergency
	name = "emergency tank"
	icon_state = "emergency"
	gauge_icon = "indicator_emergency"
	gauge_cap = 4
	flags = CONDUCT
	slot_flags = SLOT_BELT
	w_class = 2
	force = 4
	distribute_pressure = ONE_ATMOSPHERE*O2STANDARD
	volume = 2 //Tiny. Real life equivalents only have 21 breaths of oxygen in them. They're EMERGENCY tanks anyway -errorage (dangercon 2011)

/obj/item/tank/emergency/oxygen
	name = "emergency oxygen tank"
	desc = "Used for emergencies. Contains very little oxygen, so try to conserve it until you actually need it."
	icon_state = "emergency"
	gauge_icon = "indicator_emergency"

/obj/item/tank/emergency/oxygen/New()
	..()
	src.air_contents.adjust_gas(GAS_OXYGEN, (3*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C))

/obj/item/tank/emergency/oxygen/engi
	name = "extended-capacity emergency oxygen tank"
	icon_state = "emergency_engi"
	volume = 6

/obj/item/tank/emergency/oxygen/double
	name = "double emergency oxygen tank"
	icon_state = "emergency_double"
	gauge_icon = "indicator_emergency_double"
	volume = 10



/*
 * Nitrogen
 */
/obj/item/tank/nitrogen
	name = "nitrogen tank"
	desc = "A tank of nitrogen."
	icon_state = "oxygen_fr"
	distribute_pressure = ONE_ATMOSPHERE*O2STANDARD


/obj/item/tank/nitrogen/New()
	..()

	src.air_contents.adjust_gas(GAS_NITROGEN, (3*ONE_ATMOSPHERE)*70/(R_IDEAL_GAS_EQUATION*T20C))
	return
