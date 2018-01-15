/obj/effect/decal/cleanable/sigil
	name = "sigil"
	var/mob/living/presence/sanctified_to
	var/datum/presence_power/effect

/obj/effect/decal/cleanable/sigil/Destroy()
	sanctified_to = null
	effect = null
	. = ..()

/obj/effect/decal/cleanable/sigil/New(var/newloc, var/mob/living/presence/_owner, var/datum/presence_power/_effect)
	..()
	effect = _effect
	sanctified_to = _owner
	update_from_presence()

/obj/effect/decal/cleanable/sigil/proc/update_from_presence()
	return

/obj/effect/decal/cleanable/sigil/attackby(var/obj/item/thing, var/mob/user)
	if(istype(thing, /obj/item/convergence/rod) && user.mind && godtouched.is_antagonist(user.mind, sanctified_to))
		var/obj/item/convergence/rod/activator = thing
		if(activator.sanctified_to == sanctified_to)
			if(!activator.charged())
				to_chat(user, "<span class='warning'>[sanctified_to.presence.sigil_activation_failure_message]</span>")
				return
			activator.spend_charge()
			if(effect.invoke(user, sanctified_to, get_turf(src)))
				if(effect.sigil_del_after_use)
					qdel(src)
			else
				visible_message("<span class='warning'>\The [src] pulses eerily, then falls dark.</span>")
			return
	. = ..()

/obj/effect/decal/cleanable/sigil/examine(mob/user)
	..(user)
	if(effect && godtouched.is_antagonist(user, sanctified_to))
		to_chat(user, "<span class='notice'>You recognise this as a </span><span class='danger'>[effect.name]</span><span class='notice'>.</span>")
