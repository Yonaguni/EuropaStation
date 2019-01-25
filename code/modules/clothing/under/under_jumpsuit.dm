/obj/item/clothing/under/jumpsuit
	name = "jumpsuit"
	icon_state = "jumpsuit"
	under_type = PARTIAL_UNIFORM_OVER

	var/has_sensor = SUIT_HAS_SENSORS // For the crew computer 2 = unable to change mode
	var/sensor_mode = 0               // 1 = Report living/dead, 2 = Report detailed damages, 3 = Report location
	var/rolled_down = -1               // 0 = unrolled, 1 = rolled, -1 = cannot be toggled
	var/stripe_colour

/obj/item/clothing/under/jumpsuit/get_mob_overlay(mob/user_mob, slot)
	var/image/ret = ..()
	if(stripe_colour)
		var/image/I = image(ret.icon, "[ret.icon_state]_stripe")
		I.plane = ret.plane
		I.layer = ret.layer
		I.color = stripe_colour
		I.appearance_flags |= RESET_COLOR
		ret.add_overlay(I)
	return ret

/obj/item/clothing/under/jumpsuit/Initialize()
	update_rolldown_status()
	. = ..()

/obj/item/clothing/under/jumpsuit/proc/update_rolldown_status()
	if(rolled_down == -1 && ("[initial(icon_state)]_d" in icon_states(icon)))
		rolled_down = 0
	else
		rolled_down = -1

/obj/item/clothing/under/jumpsuit/on_update_icon()
	..()
	if(rolled_down == 1)
		icon_state = "[initial(icon_state)]_d"
		body_parts_covered &= LOWER_TORSO|LEGS|FEET
		item_state_slots[slot_w_uniform_str] = "[initial(icon_state)]_d"
	else
		icon_state = "[initial(icon_state)]"
		body_parts_covered = initial(body_parts_covered)
		item_state_slots[slot_w_uniform_str] = "[initial(icon_state)]"

	if(stripe_colour)
		var/image/I = image(icon, "[icon_state]_stripe")
		I.color = stripe_colour
		I.appearance_flags |= RESET_COLOR
		overlays += I

/obj/item/clothing/under/jumpsuit/New()
	sensor_mode = pick(0,1,2,3)
	..()

/obj/item/clothing/under/jumpsuit/verb/rollsuit(var/mob/user)
	set name = "Roll Down Jumpsuit"
	set category = "Object"
	set src in usr

	if(!user)
		user = usr

	if(!istype(user, /mob/living) || user.incapacitated())
		return

	if(rolled_down == -1)
		to_chat(user, SPAN_WARNING("You cannot roll down \the [src]!"))
		return

	rolled_down = !rolled_down
	update_icon()

/obj/item/clothing/under/jumpsuit/verb/toggle()
	set name = "Toggle Suit Sensors"
	set category = "Object"
	set src in usr
	set_sensors(usr)
	..()

/obj/item/clothing/under/jumpsuit/examine(mob/user)
	..(user)
	switch(src.sensor_mode)
		if(0)
			to_chat(user, "Its sensors appear to be disabled.")
		if(1)
			to_chat(user, "Its binary life sensors appear to be enabled.")
		if(2)
			to_chat(user, "Its vital tracker appears to be enabled.")
		if(3)
			to_chat(user, "Its vital tracker and tracking beacon appear to be enabled.")

/obj/item/clothing/under/jumpsuit/has_sensors_somewhere()
	return has_sensor

/obj/item/clothing/under/jumpsuit/set_sensors(var/mob/user)
	var/mob/M = user
	if (isobserver(M)) return
	if (user.incapacitated()) return
	if(has_sensor >= SUIT_LOCKED_SENSORS)
		user << "The controls are locked."
		return 0
	if(has_sensor <= SUIT_NO_SENSORS)
		user << "This suit does not have any sensors."
		return 0

	var/list/modes = list("Off", "Binary sensors", "Vitals tracker", "Tracking beacon")
	var/switchMode = input("Select a sensor mode:", "Suit Sensor Mode", modes[sensor_mode + 1]) in modes
	if(get_dist(user, src) > 1)
		user << "You have moved too far away."
		return
	sensor_mode = modes.Find(switchMode) - 1

	if (src.loc == user)
		switch(sensor_mode)
			if(0)
				user.visible_message("[user] adjusts the tracking sensor on \his [src.name].", "You disable your suit's remote sensing equipment.")
			if(1)
				user.visible_message("[user] adjusts the tracking sensor on \his [src.name].", "Your suit will now report whether you are live or dead.")
			if(2)
				user.visible_message("[user] adjusts the tracking sensor on \his [src.name].", "Your suit will now report your vital lifesigns.")
			if(3)
				user.visible_message("[user] adjusts the tracking sensor on \his [src.name].", "Your suit will now report your vital lifesigns as well as your coordinate position.")

	else if (ismob(src.loc))
		if(sensor_mode == 0)
			user.visible_message("<span class='warning'>[user] disables [src.loc]'s remote sensing equipment.</span>", "You disable [src.loc]'s remote sensing equipment.")
		else
			user.visible_message("[user] adjusts the tracking sensor on [src.loc]'s [src.name].", "You adjust [src.loc]'s sensors.")
	else
		user.visible_message("[user] adjusts the tracking sensor on [src]", "You adjust the sensor on [src].")

/obj/item/clothing/under/jumpsuit/emp_act(var/severity)
	..()
	var/new_mode
	switch(severity)
		if(1)
			new_mode = pick(75;SUIT_SENSOR_OFF, 15;SUIT_SENSOR_BINARY, 10;SUIT_SENSOR_VITAL)
		if(2)
			new_mode = pick(50;SUIT_SENSOR_OFF, 25;SUIT_SENSOR_BINARY, 20;SUIT_SENSOR_VITAL, 5;SUIT_SENSOR_TRACKING)
		else
			new_mode = pick(25;SUIT_SENSOR_OFF, 35;SUIT_SENSOR_BINARY, 30;SUIT_SENSOR_VITAL, 10;SUIT_SENSOR_TRACKING)

	sensor_mode = new_mode

POPULATE_COLOURED_VARIANTS_OF(/obj/item/clothing/under/jumpsuit, "jumpsuit")