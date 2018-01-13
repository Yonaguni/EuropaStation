// the standard tube light fixture
/obj/machinery/light
	name = "light fixture"
	icon = 'icons/obj/lighting.dmi'
	icon_state = "tube"
	desc = "A lighting fixture."
	anchored = 1
	layer = 5  					// They were appearing under mobs which is a little weird - Ostaf
	use_power = 2
	idle_power_usage = 2
	active_power_usage = 20
	power_channel = LIGHT //Lights are calc'd via area so they dont need to be in the machine list

	var/status = LIGHT_OK
	var/flickering = 0
	var/obj/item/light/bulb = /obj/item/light/tube
	var/construct_type = /obj/machinery/light_construct
	var/datum/effect/system/spark_spread/s = new

/obj/machinery/light/update_icon()
	switch(status)
		if(LIGHT_OK)
			use_power = 1
			icon_state = "[initial(icon_state)][use_power]"
		if(LIGHT_EMPTY)
			icon_state = "[initial(icon_state)]-empty"
			use_power = 0
		if(LIGHT_BURNED)
			icon_state = "[initial(icon_state)]-burned"
			use_power = 0
		if(LIGHT_BROKEN)
			icon_state = "[initial(icon_state)]-broken"
			use_power = 0

/obj/machinery/light/set_dir(var/newdir)
	. = ..(newdir)
	pixel_x = (dir & 3) ? 0 : (dir == 4 ? 3 : -3)
	pixel_y = (dir & 3) ? (dir == 1 ? 3 : -3) : 0

// create a new lighting fixture
/obj/machinery/light/New(var/newloc, var/obj/machinery/light_construct/construct = null)
	..(newloc)

	s.set_up(1, 1, src)

	if(construct)
		status = LIGHT_EMPTY
		construct_type = construct.type
		construct.transfer_fingerprints_to(src)
		set_dir(construct.dir)
	else
		if(ispath(bulb))
			update_bulb(new bulb(src))
		if(prob(2))
			break_bulb(1)
		pixel_x = (dir & 3) ? 0 : (dir == 4 ? 3 : -3)
		pixel_y = (dir & 3) ? (dir == 1 ? 3 : -3) : 0

	update(0)

/obj/machinery/light/Destroy()
	kill_light()
	if(bulb)
		qdel(bulb)
		bulb = null
	. = ..()

// update lighting
/obj/machinery/light/proc/update()
	var/last_use_power = use_power
	use_power = powered()
	if(bulb && use_power)
		set_light(light_range, light_power, light_color)
		switch_check()
		if(bulb.rigged)
			log_admin("LOG: Rigged light explosion, last touched by [fingerprintslast]")
			message_admins("LOG: Rigged light explosion, last touched by [fingerprintslast]")
			explode()
		if(last_use_power != use_power)
			switch_check()
	else
		kill_light()
	update_icon()

/obj/machinery/light/proc/switch_check()
	if(!bulb || status != LIGHT_OK)
		return //already busted
	bulb.switchcount++
	if(prob( min(60, bulb.switchcount*bulb.switchcount*0.01) ) )
		status = LIGHT_BURNED
		kill_light()
		update_icon()

/obj/machinery/light/attack_generic(var/mob/user, var/damage)
	if(!damage)
		return
	if(status == LIGHT_EMPTY||status == LIGHT_BROKEN)
		to_chat(user, "<span class='warning'>That object is useless to you.</span>")
		return
	if(!(status == LIGHT_OK||status == LIGHT_BURNED))
		return
	visible_message("<span class='danger'>[user] smashes the light!</span>")
	attack_animation(user)
	break_bulb()
	return 1

// examine verb
/obj/machinery/light/examine(mob/user)
	. = ..(user, 1)
	switch(status)
		if(LIGHT_OK)
			to_chat(user, "<span class='notice'>It is switched [use_power ? "on" : "off"].</span>")
		if(LIGHT_EMPTY)
			to_chat(user, "<span class='notice'>The [get_fitting_name()] has been removed.</span>")
		if(LIGHT_BURNED)
			to_chat(user, "<span class='notice'>The [get_fitting_name()] is burnt out.</span>")
		if(LIGHT_BROKEN)
			to_chat(user, "<span class='notice'>The [get_fitting_name()] has been smashed.</span>")

/obj/machinery/light/proc/get_fitting_name()
	return initial(bulb.name)

/obj/machinery/light/proc/insert_bulb(var/obj/item/light/L)
	update_bulb(L)
	use_power = powered()
	update()

/obj/machinery/light/proc/remove_bulb()
	bulb.forceMove(get_turf(src))
	. = bulb
	bulb = null
	update()

/obj/machinery/light/attackby(obj/item/W, mob/user)

	//Light replacer code
	if(istype(W, /obj/item/lightreplacer))
		var/obj/item/lightreplacer/LR = W
		if(isliving(user))
			var/mob/living/U = user
			LR.ReplaceLight(src, U)
			return

	// attempt to insert light
	if(istype(W, /obj/item/light))
		if(status != LIGHT_EMPTY)
			to_chat(user, "<span class = 'warning'>There is a [get_fitting_name()] already inserted.</span>")
			return
		if(!istype(W, initial(bulb)))
			to_chat(user, "<span class = 'warning'>This type of light requires a [get_fitting_name()].</span>")
			return

		to_chat(user, "You insert [W].")
		user.drop_from_inventory(W)
		W.forceMove(src)
		update_bulb(W)
		add_fingerprint(user)

	else if(status != LIGHT_BROKEN && status != LIGHT_EMPTY)
		if(prob(1+W.force * 5))
			user.visible_message("<span class='danger'>\The [user] smashes the light with \the [W]!</span>")
			if(use_power && (W.flags & CONDUCT) && prob(12))
				electrocute_mob(user, get_area(src), src, 0.3)
			break_bulb()
		else
			user.visible_message("<span class='danger'>\The [user] hits the light with \the [W]</span>!")

	// attempt to stick weapon into light socket
	else if(status == LIGHT_EMPTY)
		if(W.isscrewdriver()) //If it's a screwdriver open it.
			playsound(src.loc, 'sound/items/Screwdriver.ogg', 75, 1)
			user.visible_message("<span class='notice'>\The [user] opens the casing of \the [src].</span>")
			new construct_type(loc, dir, src)
			qdel(src)
			return

		to_chat(user, "<span class='danger'>You stick \the [W] into the light socket!</span>")
		if(powered() && (W.flags & CONDUCT))
			s.set_up(3, 1, src)
			s.start()
			if(prob(75))
				electrocute_mob(user, get_area(src), src, rand(0.7,1.0))

/obj/machinery/light/proc/update_bulb(var/obj/item/light/lbulb)
	if(!bulb)
		bulb = lbulb
		light_range = bulb.brightness_range
		light_power = bulb.brightness_power
		light_color = bulb.brightness_color
		active_power_usage = ((light_range * light_power) * LIGHTING_POWER_FACTOR)
	else
		light_range = 0
		light_power = 0
		active_power_usage = 0

// returns whether this light has power
// true if area has power and lightswitch is on
/obj/machinery/light/powered()
	var/area/A = get_area(src)
	return A && A.lightswitch && ..(power_channel)

/obj/machinery/light/proc/flicker(var/amount = rand(10, 20))
	set waitfor = 0
	if(!flickering)
		flickering = 1
		if(use_power && status == LIGHT_OK)
			for(var/i = 0; i < amount; i++)
				if(status != LIGHT_OK)
					break
				use_power = !use_power
				update(0)
				sleep(rand(5, 15))
				use_power = (status == LIGHT_OK)
				update(0)
			flickering = 0

// ai attack - make lights flicker, because why not

/obj/machinery/light/attack_ai(mob/user)
	flicker(1)

// attack with hand - remove tube/bulb
// if hands aren't protected and the light is on, burn the player
/obj/machinery/light/attack_hand(mob/user)

	add_fingerprint(user)

	if(status == LIGHT_EMPTY)
		to_chat(user, "There is no [get_fitting_name()] in this light.")
		return

	if(istype(user,/mob/living/carbon/human))
		var/mob/living/carbon/human/H = user
		if(H.species.can_shred(H))
			user.visible_message("<span class='danger'>\The [user] smashes the light!</span>")
			break_bulb()
			return

	// make it burn hands if not wearing fire-insulated gloves
	if(use_power)
		var/prot = 0
		var/mob/living/carbon/human/H = user

		if(istype(H))
			if(H.getSpeciesOrSynthTemp(HEAT_LEVEL_1) > LIGHT_BULB_TEMPERATURE)
				prot = 1
			else if(H.gloves)
				var/obj/item/clothing/gloves/G = H.gloves
				if(G.max_heat_protection_temperature)
					if(G.max_heat_protection_temperature > LIGHT_BULB_TEMPERATURE)
						prot = 1
		else
			prot = 1

		if(prot > 0 || (COLD_RESISTANCE in user.mutations))
			to_chat(user, "<span class='notice'>You remove the [get_fitting_name()].</span>")
		else if(TK in user.mutations)
			to_chat(user, "<span class='notice'>You telekinetically remove the light [get_fitting_name()].</span>")
		else
			to_chat(user, "<span class='warning'>You try to remove the light [get_fitting_name()], but it's too hot and you don't want to burn your hand.</span>")
			return				// if burned, don't remove the light
	else
		to_chat(user, "<span class='notice'>You remove the light [get_fitting_name()].</span>")

	user.put_in_active_hand(remove_bulb())

/obj/machinery/light/attack_tk(mob/user)
	if(status == LIGHT_EMPTY)
		to_chat(user, "<span class='warning'>There is no [get_fitting_name()] in this light.</span>")
		return
	to_chat(user, "<span class='notice'>You telekinetically remove the light [get_fitting_name()].</span>")
	remove_bulb()

// ghost attack - make lights flicker like an AI, but even spookier!
/obj/machinery/light/attack_ghost(mob/user)
	if(round_is_spooky())
		flicker(rand(2,5))
	else return ..()

// break the light and make sparks if was on
/obj/machinery/light/proc/break_bulb(var/skip_sound_and_sparks = 0)
	if(status == LIGHT_EMPTY)
		return
	if(!skip_sound_and_sparks)
		if(status == LIGHT_OK || status == LIGHT_BURNED)
			playsound(src.loc, 'sound/effects/Glasshit.ogg', 75, 1)
		if(use_power)
			s.start()
	status = LIGHT_BROKEN
	update()

/obj/machinery/light/proc/fix()
	if(status != LIGHT_OK)
		status = LIGHT_OK
		use_power = 1
		update()

// explosion effect
// destroy the whole light fixture or just shatter it
/obj/machinery/light/ex_act(severity)
	switch(severity)
		if(1)
			qdel(src)
		if(2)
			if(prob(75)) break_bulb()
		if(3)
			if(prob(50)) break_bulb()

// called when area power state changes
/obj/machinery/light/power_change()
	set waitfor = 0
	sleep(10)
	use_power = (powered() && status == LIGHT_OK)
	update()

/obj/machinery/light/fire_act(datum/gas_mixture/air, exposed_temperature, exposed_volume)
	if(prob(max(0, exposed_temperature - 673)))   //0% at <400C, 100% at >500C
		break_bulb()

// explode the light
/obj/machinery/light/proc/explode()
	set waitfor = 0
	var/turf/T = get_turf(src.loc)
	break_bulb()
	sleep(2)
	explosion(T, 0, 0, 2, 2)
	sleep(1)
	qdel(src)
