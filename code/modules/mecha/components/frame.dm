/obj/structure/mech_frame
	name = "exosuit frame"
	desc = "The frame for am exosuit, apparently."
	icon = 'icons/mecha/mech_parts.dmi'
	icon_state = "backbone"
	density = 1
	pixel_x = -8

	// Holders for the final product.
	var/obj/item/mech_component/manipulators/arms
	var/obj/item/mech_component/propulsion/legs
	var/obj/item/mech_component/sensors/head
	var/obj/item/mech_component/chassis/body
	var/is_wired = 0
	var/is_reinforced = 0
	var/set_name

/obj/structure/mech_frame/update_icon()
	overlays.Cut()
	overlays |= get_mech_icon(null, arms, legs, head, body)
	if(body.open_cabin)
		overlays |= get_mech_image("[body.icon_state]_open_overlay", body.icon)
	anchored = (body && legs) ? 1 : 0
	density =  body ? 1 : 0
	opacity = density

/obj/structure/mech_frame/New()
	..()
	set_dir(SOUTH)
	update_icon()

/obj/structure/mech_frame/set_dir()
	..(SOUTH)

// Ugh ugh ugh (ugh) ugh.
/obj/structure/mech_frame/attackby(var/obj/item/weapon/thing, var/mob/user)

	// Final construction step.
	if(istype(thing, /obj/item/weapon/screwdriver))

		// Check for basic components.
		if(!(arms && legs && head && body))
			user << "<span class='warning'>There are still parts missing from \the [src].</span>"
			return

		// Check for wiring.
		if(is_wired < 2)
			if(is_wired == 1)
				user << "<span class='warning'>The [src]'s wiring has not been adjusted!</span>"
			else
				user << "<span class='warning'>The [src] is not wired!</span>"
			return

		// Check for basing metal internal plating.
		if(is_reinforced < 3)
			if(is_reinforced == 1)
				user << "<span class='warning'>The [src]'s internal reinforcement has not been secured!</span>"
			else if(is_reinforced == 2)
				user << "<span class='warning'>The [src]'s internal reinforcement has not been welded down!</span>"
			else
				user << "<span class='warning'>The [src] has no internal reinforcement!</span>"
			return

		// We're all done. Finalize the mech and pass the frame to the new system.
		var/mob/living/mecha/M = new(get_turf(src), src)
		visible_message("\The [user] finishes off \the [M].")
		qdel(src)
		return

	// Installing wiring.
	else if(istype(thing,/obj/item/stack/cable_coil))

		if(is_wired)
			user << "<span class='warning'>\The [src] has already been wired.</span>"
			return

		var/obj/item/stack/cable_coil/CC = thing
		if(CC.amount < 10)
			user << "<span class='warning'>You need at least ten units of cable to complete the exosuit.</span>"
			return

		user.visible_message("\The [user] begins wiring \the [src]...")

		if(!do_after(user, 30))
			return

		if(!CC || !user || !src || CC.amount < 10 || is_wired)
			return

		CC.use(10)
		user.visible_message("\The [user] installs wiring in \the [src].")
		is_wired = 1
	// Securing wiring.
	else if(istype(thing, /obj/item/weapon/wirecutters))
		if(!is_wired)
			user << "There is no wiring in \the [src] to neaten."
			return
		visible_message("\The [user] [(is_wired == 2) ? "snips some of" : "neatens"] the wiring in \the [src].")
		is_wired = (is_wired == 2) ? 1 : 2
	// Installing metal.
	else if(istype(thing, /obj/item/stack/material))
		var/obj/item/stack/material/M = thing
		if(M.material && M.material.name == "steel")
			if(is_reinforced)
				user << "<span class='warning'>There is already metal reinforcement installed in \the [src].</span>"
				return
			if(M.amount < 15)
				user << "<span class='warning'>You need at least fifteen sheets of steel to reinforce \the [src].</span>"
				return
			visible_message("\The [user] reinforces \the [src] with \the [M].")
			is_reinforced = 1
			M.use(15)
		else
			return ..()
	// Securing metal.
	else if(istype(thing, /obj/item/weapon/wrench))
		if(!is_reinforced)
			user << "<span class='warning'>There is no metal to secure inside \the [src].</span>"
			return
		if(is_reinforced == 3)
			user << "<span class='warning'>\The [src]'s internal reinforcment has been welded in.</span>"
			return
		visible_message("\The [user] [(is_reinforced == 2) ? "unsecures" : "secures"] the metal reinforcement in \the [src].")
		is_reinforced = (is_reinforced == 2) ? 1 : 2
	// Welding metal.
	else if(istype(thing, /obj/item/weapon/weldingtool))
		var/obj/item/weapon/weldingtool/WT = thing
		if(!is_reinforced)
			user << "<span class='warning'>There is no metal to secure inside \the [src].</span>"
			return
		if(is_reinforced == 1)
			user << "<span class='warning'>The reinforcement inside \the [src] has not been secured.</span>"
			return
		if(!WT.isOn())
			user << "<span class='warning'>Turn \the [WT] on, first.</span>"
			return
		if(WT.remove_fuel(1, user))
			visible_message("\The [user] [(is_reinforced == 3) ? "unwelds the reinforcement from" : "welds the reinforcement into"] \the [src].")
			is_reinforced = (is_reinforced == 3) ? 2 : 3
		else
			user << "<span class='warning'>Not enough fuel!</span>"
			return
	// Installing basic components.
	else if(istype(thing,/obj/item/mech_component/manipulators))
		if(arms)
			user << "<span class'warning'>\The [src] already has manipulators installed.</span>"
			return
		arms = thing
		install_component(thing, user)
	else if(istype(thing,/obj/item/mech_component/propulsion))
		if(legs)
			user << "<span class'warning'>\The [src] already has a propulsion system installed.</span>"
			return
		legs = thing
		install_component(thing, user)
	else if(istype(thing,/obj/item/mech_component/sensors))
		if(head)
			user << "<span class'warning'>\The [src] already has a sensor array installed.</span>"
			return
		head = thing
		install_component(thing, user)
	else if(istype(thing,/obj/item/mech_component/chassis))
		if(body)
			user << "<span class'warning'>\The [src] already has an outer chassis installed.</span>"
			return
		body = thing
		install_component(thing, user)
	else
		return ..()
	update_icon()
	return

/obj/structure/mech_frame/proc/install_component(var/obj/item/thing, var/mob/user)
	var/obj/item/mech_component/MC = thing
	if(istype(MC) && !MC.ready_to_install())
		if(user) user << "<span class='warning'>\The [MC] is not ready to install.</span>"
		return
	user.unEquip(thing)
	thing.forceMove(src)
	visible_message("\The [user] installs \the [thing] into \the [src].")
