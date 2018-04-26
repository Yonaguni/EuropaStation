/obj/item/implant/psi_control
	name = "psi dampener implant"
	desc = "A safety implant for registered psi-operants."

	var/overload = 0
	var/max_overload = 100
	var/psi_mode = PSI_IMPLANT_AUTOMATIC

/obj/item/implant/psi_control/islegal()
	return TRUE

/obj/item/implant/psi_control/New()
	..()
	psi_dampeners += src

/obj/item/implant/psi_control/Destroy()
	psi_dampeners -= src
	. = ..()

/obj/item/implant/psi_control/emp_act()
	. = ..()
	update_functionality()

/obj/item/implant/psi_control/meltdown()
	. = ..()
	update_functionality()

/obj/item/implant/psi_control/disrupts_psionics()
	var/use_psi_mode = get_psi_mode()
	return (!malfunction && (use_psi_mode == PSI_IMPLANT_SHOCK || use_psi_mode == PSI_IMPLANT_WARN))

/obj/item/implant/psi_control/removed()
	var/mob/living/M = imp_in
	if((src in psi_null_atoms) && istype(M) && M.psi)
		to_chat(M, "<span class='notice'>You feel the chilly shackles around your psionic faculties fade away.</span>")
	if(istype(imp_in, /atom))
		REMOVE_PSI_NULL_ATOM(imp_in, src)
	. = ..()

/obj/item/implant/psi_control/proc/update_functionality(var/silent)
	var/mob/living/M = imp_in
	if(get_psi_mode() == PSI_IMPLANT_DISABLED || malfunction)
		if(src in psi_null_atoms)
			if(implanted && !silent && istype(M) && M.psi)
				to_chat(M, "<span class='notice'>You feel the chilly shackles around your psionic faculties fade away.</span>")
			LAZYREMOVE(psi_null_atoms, src)
			if(istype(loc, /atom))
				REMOVE_PSI_NULL_ATOM(loc, src)
	else
		if(!(src in psi_null_atoms))
			if(implanted && !silent && istype(M) && M.psi)
				to_chat(M, "<span class='notice'>Bands of hollow ice close themselves around your psionic faculties.</span>")
			LAZYADD(psi_null_atoms, src)
			if(istype(loc, /atom))
				ADD_PSI_NULL_ATOM(loc, src)

/obj/item/implant/psi_control/meltdown()
	if(!malfunction)
		overload = 100
		if(imp_in)
			for(var/thing in psi_monitors)
				var/obj/machinery/psi_monitor/monitor = thing
				monitor.report_failure(src)
	. = ..()

/obj/item/implant/psi_control/proc/get_psi_mode()
	if(psi_mode == PSI_IMPLANT_AUTOMATIC)
		switch(security_level)
			if(SEC_LEVEL_GREEN)
				return PSI_IMPLANT_WARN
			if(SEC_LEVEL_BLUE)
				return PSI_IMPLANT_LOG
			else
				return PSI_IMPLANT_DISABLED
	return psi_mode

/obj/item/implant/psi_control/withstand_psi_stress(var/stress, var/atom/source)

	var/use_psi_mode = get_psi_mode()

	if(malfunction || use_psi_mode == PSI_IMPLANT_DISABLED)
		return stress

	. = 0

	if(stress > 0)

		// If we're disrupting psionic attempts at the moment, we might overload.
		if(disrupts_psionics())
			var/overload_amount = Floor(stress/10)
			if(overload_amount > 0)
				overload += overload_amount
				if(overload >= 100)
					if(imp_in)
						to_chat(imp_in, "<span class='danger'>Your psi dampener overloads violently!</span>")
					meltdown()
					update_functionality()
					return
				if(imp_in)
					if(overload >= 75 && overload < 100)
						to_chat(imp_in, "<span class='danger'>Your psi dampener is searing hot!</span>")
					else if(overload >= 50 && overload < 75)
						to_chat(imp_in, "<span class='warning'>Your psi dampener is uncomfortably hot...</span>")
					else if(overload >= 25 && overload < 50)
						to_chat(imp_in, "<span class='warning'>You feel your psi dampener heating up...</span>")

		// If all we're doing is logging the incident then just pass back stress without changing it.
		if(source && source == imp_in && implanted)
			for(var/thing in psi_monitors)
				var/obj/machinery/psi_monitor/monitor = thing
				monitor.report_violation(src, stress)
			if(use_psi_mode == PSI_IMPLANT_LOG)
				return stress
			else if(use_psi_mode == PSI_IMPLANT_SHOCK)
				to_chat(imp_in, "<span class='danger'>Your psi dampener punishes you with a violent neural shock!</span>")
				imp_in.flash_eyes()
				imp_in.Weaken(5)
				if(isliving(imp_in))
					var/mob/living/M = imp_in
					if(M.psi) M.psi.stunned(5)
			else if(use_psi_mode == PSI_IMPLANT_WARN)
				to_chat(imp_in, "<span class='warning'>Your psi dampener primly informs you it has reported this violation.</span>")
