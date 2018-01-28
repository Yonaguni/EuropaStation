var/datum/controller/subsystem/processing/psi/SSpsi

/datum/controller/subsystem/processing/psi
	name = "Psychics"
	priority = SS_PRIORITY_PSYCHICS
	flags = SS_POST_FIRE_TIMING | SS_BACKGROUND | SS_NO_INIT
	var/list/powers
	var/list/psychics

/datum/controller/subsystem/processing/psi/New()
	NEW_SS_GLOBAL(SSpsi)
	LAZYINITLIST(psychics)
	processing = psychics
	powers = list()
	for(var/ptype in subtypesof(/decl/psipower))
		var/decl/psipower/power = ptype
		if(initial(power.name))
			power = new power
			LAZYADD(powers[power.faculty], power)
