/obj/machinery
	name = "machinery"
	icon = 'icons/obj/machines/machines.dmi'
	w_class = 10

	var/global/gl_uid = 1

	var/stat = 0
	var/emagged = 0
	var/uid

	// Construction variables.
	var/list/component_parts = null //list of all the parts used to build it, if made from certain kinds of frames.
	var/list/build_components = list()
	var/dismantle_sound = 'sound/items/Crowbar.ogg'
	var/panel_open = 0
	var/waterproof = 1 //How does water affect the machine? 1 = no effect, 0 = slow efect, -1 = instant death

/obj/machinery/New(l, d=0, var/skip_components)
	..(l)
	if(d)
		set_dir(d)
	if(!machinery_sort_required && ticker)
		dd_insertObjectList(machines, src)
	else
		machines += src
		machinery_sort_required = 1

	if(!skip_components)
		component_parts = list()
		for(var/component in build_components)
			component_parts += new component(src)

/obj/machinery/Destroy()
	machines -= src
	component_parts.Cut()
	for(var/atom/A in contents)
		qdel(A)
	return ..()

/obj/machinery/process()//If you dont use process or power why are you here
	if(!(use_power || idle_power_usage || active_power_usage))
		return PROCESS_KILL
	if(loc && istype(loc, /turf))
		var/turf/T = loc
		var/datum/gas_mixture/fluid/environment = T.return_fluids()
		if(environment)
			var/depth = environment.total_moles
			if(depth)
				water_act(depth)
	return

/obj/machinery/emp_act(severity)
	if(use_power && stat == 0)
		use_power(7500/severity)
		var/obj/effect/overlay/pulse2 = PoolOrNew(/obj/effect/overlay, src.loc)
		pulse2.icon = 'icons/effects/effects.dmi'
		pulse2.icon_state = "empdisable"
		pulse2.name = "emp sparks"
		pulse2.anchored = 1
		pulse2.set_dir(pick(cardinal))
		spawn(10)
			qdel(pulse2)
	pulsed()
	..(severity)

/obj/machinery/ex_act(severity)
	if(prob(100-((severity-1)*25)))
		qdel(src)

/proc/is_operable(var/obj/machinery/M, var/mob/user)
	return istype(M) && M.operable()

/obj/machinery/proc/operable(var/additional_flags = 0)
	return !inoperable(additional_flags)

/obj/machinery/proc/inoperable(var/additional_flags = 0)
	return (stat & (NOPOWER|BROKEN|additional_flags))

/obj/machinery/CanUseTopic(var/mob/user)
	if(stat & BROKEN)
		return UI_CLOSE

	if(!interact_offline && (stat & NOPOWER))
		return UI_CLOSE

	return ..()

/obj/machinery/CouldUseTopic(var/mob/user)
	..()
	user.set_machine(src)

/obj/machinery/CouldNotUseTopic(var/mob/user)
	user.unset_machine()

/obj/machinery/proc/RefreshParts() //Placeholder proc for machines that are built using frames.
	return

/obj/machinery/proc/assign_uid()
	uid = gl_uid
	gl_uid++

/obj/machinery/proc/state(var/msg)
	for(var/mob/O in hearers(src, null))
		O.show_message("\icon[src] <span class = 'notice'>[msg]</span>", 2)

/obj/machinery/proc/ping(text=null)
	if (!text)
		text = "\The [src] pings."

	state(text, "blue")
	playsound(src.loc, 'sound/machines/ping.ogg', 50, 0)

/obj/machinery/proc/shock(mob/user, prb)
	if(inoperable())
		return 0
	if(!prob(prb))
		return 0
	var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread
	s.set_up(5, 1, src)
	s.start()
	if(electrocute_mob(user, get_area(src), src, 0.7) && user.stunned)
		return 1
	return 0

/obj/machinery/attackby(var/obj/item/O, var/mob/user)
	if(istype(O, /obj/item/device/multitool))
		select_data_network()
		return 1
	else if(default_deconstruction_screwdriver(user, O))
		updateUsrDialog()
		return 1
	else if(default_deconstruction_crowbar(user, O))
		return 1
	else if(default_part_replacement(user, O))
		return 1
	else
		return 0

/obj/machinery/attack_hand(mob/user as mob)
	if(inoperable(MAINT))
		return 1
	if(user.lying || user.stat)
		return 1
	if (!user.IsAdvancedToolUser(1))
		user << "<span class='warning'>You don't have the dexterity to do this!</span>"
		return 1
	if(console_interface_only)
		var/mob/living/human/H = user
		if(!istype(H) || !istype(H.wear_id, /obj/item/device/wrist_computer))
			user << "<span class='warning'>\The [src] can only be activated via terminal.</span>"
			return
	user.set_machine(src)
	interact(user)
	src.add_fingerprint(user)

	return ..()