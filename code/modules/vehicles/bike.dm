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
	debris_path = /obj/structure/scrap/vehicle
//	light_type = LIGHT_DIRECTIONAL
	light_power = 5
	light_range = 6

	var/max_move_speed = 3
	var/cur_move_speed = 0
	var/cur_move_dir = 0
	var/moved
	var/protection_percent = 60
	var/land_speed = 1 //if 0 it can't go on turf
	var/space_speed = 0
	var/bike_icon = "bike"
	var/idle_sound = 'sound/misc/bike_idle.ogg'
	var/start_sound = 'sound/misc/bike_start.ogg'
	var/datum/effect/system/ion_trail_follow/ion
	var/kickstand = 1
	var/collision_cooldown

/obj/vehicle/bike/verb/toggle()
	set name = "Toggle Engine"
	set category = "Vehicle"
	set src in view(0)

	if(usr.incapacitated()) return

	if(!on)
		turn_on()
		src.visible_message("\The [src] rumbles to life.", "You hear something rumble deeply.")
		playsound(src.loc, start_sound, 100)
	else
		turn_off()
		src.visible_message("\The [src] putters before turning off.", "You hear something putter slowly.")

/obj/vehicle/bike/verb/kickstand()
	set name = "Toggle Kickstand"
	set category = "Vehicle"
	set src in view(0)

	if(usr.incapacitated()) return

	if(kickstand)
		src.visible_message("<span class='notice'>\The [usr] kicks up \the [src]'s stand.</span>")
		playsound(src.loc, 'sound/misc/bike_stand_up.ogg', 75,1)
	else
		if(istype(src.loc,/turf/space))
			to_chat(usr, "<span class='warning'> You don't think kickstands work in space...</span>")
			return
		src.visible_message("<span class='notice'>\The [usr] kicks down \the [src]'s stand.</span>")
		playsound(src.loc, 'sound/misc/bike_stand_down.ogg', 75,1)

	kickstand = !kickstand
	anchored = (kickstand || on)

/obj/vehicle/bike/load(var/atom/movable/C)
	var/mob/living/M = C
	if(!istype(M))
		return 0
	if(M.buckled || M.restrained() || !Adjacent(M) || !M.Adjacent(src))
		return 0
	return ..(M)

/obj/vehicle/bike/MouseDrop_T(var/atom/movable/C, var/mob/user)
	if(!load(C))
		user << "<span class='warning'> You were unable to load \the [C] onto \the [src].</span>"
		return

/obj/vehicle/bike/attack_hand(var/mob/user)
	if(user == load)
		unload(load)
		user << "You unbuckle yourself from \the [src]"

/obj/vehicle/bike/relaymove(mob/user, direction)
	if(user != load || !on || !istype(user) || user.incapacitated())
		return
	return Move(get_step(src, direction))

/obj/vehicle/bike/Move(var/turf/destination)
	if(kickstand) return
	//these things like space, not turf. Dragging shouldn't weigh you down.
	if(istype(destination,/turf/space))
		if(!space_speed)
			return 0
		move_delay = space_speed
	else
		if(!land_speed)
			return 0
		move_delay = land_speed

	/*
	glide_size = world.icon_size / max(move_delay, world.tick_lag) * world.tick_lag
	var/mob/rider = load
	if(istype(rider))
		rider.glide_size = glide_size
	*/
	moved = ..()
	return moved

/obj/vehicle/bike/turn_on()
	anchored = 1
	update_icon()
	processing_objects |= src
	..()

/obj/vehicle/bike/turn_off()
	anchored = kickstand
	processing_objects -= src
	update_icon()
	..()

/obj/vehicle/bike/Bump(var/atom/thing)

	if(!istype(thing, /atom/movable))
		return

	var/crashed
	var/atom/movable/A = thing

	// Bump things away!
	if(istype(A, /turf))
		var/turf/T = A
		if(T.density)
			if(collision_cooldown)
				return
			crashed = 1
	else if(!A.anchored)
		var/turf/T = get_step(A, dir)
		if(isturf(T))
			A.Move(T)
	else
		if(cur_move_speed > 1)
			if(collision_cooldown)
				return
			A.attack_generic(src, rand(30,50), "slams into")
			crashed = 1

	if(crashed)
		collision_cooldown = 1
		if(prob(50))
			var/mob/living/M = load
			unload(load, dir)
			if(istype(M))
				M << "<span class='danger'>You are hurled off \the [src]!</span>"
				if(!HAS_ASPECT(M, ASPECT_DAREDEVIL))
					M.Weaken(rand(6,10))
				M.throw_at(get_edge_target_turf(src,src.dir),rand(1,2), move_delay)
				spawn(3)
					if(!M.lying)
						M << "<span class='notice'>You land on your feet!</span>"

			src.ex_act(2)

	if(cur_move_speed > 1 && istype(A, /mob/living))
		var/mob/living/M = A
		if(!M.lying)
			if(istype(load, /mob/living))
				var/mob/living/driver = load
				driver << "<span class='danger'>You collide with \the [M]!</span>"
				msg_admin_attack("[driver.name] ([driver.ckey]) hit [M.name] ([M.ckey]) with [src]. [ADMIN_JUMP_LINK(src.x,src.y,src.z)]")
			visible_message("<span class='danger'>\The [src] knocks \the [M] down!</span>")
			RunOver(M)
			M.Weaken(rand(5,10))
			M.throw_at(get_edge_target_turf(src,get_dir(src,M)),rand(1,2), move_delay)

/obj/vehicle/bike/RunOver(var/mob/living/carbon/human/H)
	if(istype(load, /mob/living))
		load << "<span class='danger'>You run \the [H] down!</span>"
		H << "<span class='danger'>\The [load] runs you down!</span>"
	else
		H << "<span class='danger'>\The [src] runs you down!</span>"
	if(istype(H))
		var/list/parts = list(BP_HEAD, BP_CHEST, BP_L_LEG, BP_R_LEG, BP_L_ARM, BP_R_ARM)
		for(var/i = 0, i < rand(1,3), i++)
			H.apply_damage((rand(1,5)), BRUTE, pick(parts))


/obj/vehicle/bike/process()
	if(on)
		if(moved && cur_move_speed < max_move_speed)
			cur_move_speed++
		else if(cur_move_speed > 0)
			cur_move_speed--
		playsound(src.loc, idle_sound, 100)
	else
		cur_move_speed = 0
	moved = 0
	collision_cooldown = 0

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
	processing_objects -= src
	return ..()
