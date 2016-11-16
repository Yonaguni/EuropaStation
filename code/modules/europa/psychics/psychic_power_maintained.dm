/datum/maintained_power
	var/mob/living/owner
	var/datum/psychic_power/power

/datum/maintained_power/proc/fail(var/skip_cancel)
	if(owner && owner.mind && power)
		owner << "<span class='notice'>The power of [power.name] fades away...</span>"
		owner.mind.maintaining_powers -= src
		if(!skip_cancel)
			power.cancelled(owner)
		qdel(src)

/datum/maintained_power/Destroy()
	owner = null
	power = null
	fail()
	. = ..()

/datum/maintained_power/New(var/mob/living/_owner, var/datum/psychic_power/_power)
	power = _power
	owner = _owner
	owner.mind.maintaining_powers += src
	. = ..()
