var/list/bike_cache = list()

/obj/vehicle/bike
	name = "motorbike"
	desc = "Wheelies! Head trauma! Woo! "
	icon = 'icons/obj/bike.dmi'
	icon_state = "bike_off"
	dir = SOUTH

	load_item_visible = 1
	mob_offset_y = 5
	health = 100
	maxhealth = 100
	pixel_x = -16
	pixel_y = -16
	fire_dam_coeff = 0.6
	brute_dam_coeff = 0.5

	var/max_move_speed = 3
	var/cur_move_speed = 0
	var/moved

	var/protection_percent = 60

	var/land_speed = 1 //if 0 it can't go on turf
	var/space_speed = 0
	var/bike_icon = "bike"

	var/idle_sound = 'sound/misc/bike_idle.ogg'
	var/start_sound = 'sound/misc/bike_start.ogg'

	// These are terrible but unless someone wants to find me
	// better sounds or a better system for giving movement
	// feedback to the player, they will have to do. ~Z
	var/global/list/move_sounds = list(
		'sound/misc/bike_idle.ogg',
		'sound/misc/bike_idle_2.ogg',
		'sound/misc/bike_idle_2.ogg',
		'sound/misc/bike_idle_3.ogg',
		'sound/misc/bike_idle_3.ogg'
		)

	var/datum/effect/effect/system/ion_trail_follow/ion
	var/kickstand = 1

/obj/vehicle/bike/initialize()
	..()
	ion = new /datum/effect/effect/system/ion_trail_follow()
	ion.set_up(src)
	turn_off() // Disables ion, updates icon.

/obj/vehicle/bike/verb/toggle()
	set name = "Toggle Engine"
	set category = "Vehicle"
	set src in view(0)

	if(usr.incapacitated()) return

	if(!on)
		turn_on()
		src.visible_message("\The [src] rumbles to life.", "You hear something rumble deeply.")
		playsound(src.loc, start_sound, 75)
	else
		turn_off()
		src.visible_message("\The [src] putters before turning off.", "You hear something putter slowly.")

/obj/vehicle/bike/verb/kickstand()
	set name = "Toggle Kickstand"
	set category = "Vehicle"
	set src in view(0)

	if(usr.incapacitated()) return

	if(kickstand)
		src.visible_message("You put up \the [src]'s kickstand.")
		playsound(src.loc, 'sound/misc/bike_stand_up.ogg', 75,1)
	else
		if(istype(src.loc,/turf/space))
			usr << "<span class='warning'> You don't think kickstands work in space...</span>"
			return
		src.visible_message("You put down \the [src]'s kickstand.")
		playsound(src.loc, 'sound/misc/bike_stand_down.ogg', 75,1)
		if(pulledby)
			pulledby.stop_pulling()

	kickstand = !kickstand
	anchored = (kickstand || on)

/obj/vehicle/bike/load(var/atom/movable/C)
	var/mob/living/M = C
	if(!istype(C)) return 0
	if(M.buckled || M.restrained() || !Adjacent(M) || !M.Adjacent(src))
		return 0
	return ..(M)

/obj/vehicle/bike/MouseDrop_T(var/atom/movable/C, mob/user as mob)
	if(!load(C))
		user << "<span class='warning'> You were unable to load \the [C] onto \the [src].</span>"
		return

/obj/vehicle/bike/attack_hand(var/mob/user as mob)
	if(user == load)
		unload(load)
		user << "You unbuckle yourself from \the [src]"

/obj/vehicle/bike/relaymove(mob/user, direction)
	if(user != load || !on)
		return
	return Move(get_step(src, direction))

/obj/vehicle/bike/Move(var/turf/destination)
	if(kickstand) return
	//these things like space, not turf. Dragging shouldn't weigh you down.
	if(istype(destination,/turf/space) || pulledby)
		if(!space_speed)
			return 0
		move_delay = space_speed
	else
		if(!land_speed)
			return 0
		move_delay = land_speed
	moved = ..()
	return moved

/obj/vehicle/bike/turn_on()
	ion.start()
	anchored = 1
	update_icon()
	processing_objects |= src
	if(pulledby)
		pulledby.stop_pulling()
	..()

/obj/vehicle/bike/turn_off()
	ion.stop()
	anchored = kickstand
	processing_objects -= src
	update_icon()
	..()

/obj/vehicle/bike/process()
	if(on)
		if(moved && cur_move_speed < max_move_speed)
			cur_move_speed++
		else if(cur_move_speed > 0)
			cur_move_speed--
		if(cur_move_speed)
			playsound(src.loc, move_sounds[cur_move_speed], 75)
		else
			playsound(src.loc, idle_sound, 75)

	else
		cur_move_speed = 0
	moved = 0

/obj/vehicle/bike/bullet_act(var/obj/item/projectile/Proj)
	if(buckled_mob && prob(protection_percent))
		buckled_mob.bullet_act(Proj)
		return
	..()

/obj/vehicle/bike/update_icon()
	overlays.Cut()

	// Update base.
	icon_state = "[bike_icon]_[on ? "on" : "off"]"

	// Update over-driver image.
	if(!bike_cache[icon_state])
		bike_cache[icon_state] = image(icon, "[icon_state]_overlay", MOB_LAYER+0.5)
	overlays += bike_cache[icon_state]

	// Update wheel image.
	var/cache_key = "[bike_icon]_wheels"
	if(!bike_cache[cache_key])
		bike_cache[cache_key] = image(icon, cache_key)
	underlays += bike_cache[cache_key]
	..()

/obj/vehicle/bike/Destroy()
	qdel(ion)
	processing_objects -= src
	return ..()