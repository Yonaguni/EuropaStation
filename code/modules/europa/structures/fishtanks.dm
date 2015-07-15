var/list/fishtank_cache = list()

/obj/structure/aquarium
	name = "fishtank"
	icon_state = "preview"
	icon = 'icons/obj/europa/structures/fishtanks.dmi'
	anchored = 1
	density = 1
	var/health = 50
	var/deleting
	var/fill_type = "water"
	var/fill_amt = 300
	var/list/connecting = list()
	var/base_state = "single"

/obj/structure/aquarium/return_air()
	var/datum/gas_mixture/GM
	for(var/datum/reagent/A in reagents.reagent_list)
		if(!isnull(gas_data.flags[A.id]))
			if(!GM) GM = new
			GM.adjust_gas(A.id, A.volume)
	return GM ? GM : ..()

/obj/structure/aquarium/New()
	..()
	initial_fill()

/obj/structure/aquarium/proc/initial_fill()
	create_reagents(fill_amt)
	reagents.add_reagent(fill_type, fill_amt)

/obj/structure/aquarium/initialize()
	get_neighbors()
	update_icon()

/obj/structure/aquarium/attack_hand(var/mob/user)
	visible_message("<span class='notice'>\The [user] taps on \the [src].</span>")
	initialize()

/obj/structure/aquarium/attackby(var/obj/item/W, var/mob/user)
	if(W.force >= 5)
		health -= W.force
		visible_message("<span class='danger'>\The [user] strikes \the [src] with \the [W]!</span>")
		playsound(get_turf(src), 'sound/effects/Glasshit.ogg', 75, 1)
		check_health()
	else
		visible_message("<span class='notice'>\The [user] taps \the [src] harmlessly with \the [W].</span>")
	return

/obj/structure/aquarium/proc/check_health()
	//Todo damage overlays.
	if(health <= 0)
		shatter()

/obj/structure/aquarium/proc/shatter(var/silent)
	//Todo leave wreckage based on remaining health.
	deleting = 1
	var/turf/T = get_turf(src)
	playsound(T, "shatter", 70, 1)
	PoolOrNew(/obj/item/weapon/material/shard, T)
	if(!silent)
		if(contents.len || reagents.total_volume)
			visible_message("<span class='danger'>\The [src] shatters, spilling its contents everywhere!</span>")
		else
			visible_message("<span class='danger'>\The [src] shatters!</span>")
	dump_contents()
	if(connecting.len)
		for(var/obj/structure/aquarium/A in connecting)
			if(!A.deleting)
				A.shatter(1)
	connecting.Cut()
	qdel(src)

/obj/structure/aquarium/proc/dump_contents()
	var/datum/gas_mixture/environment = loc.return_air()
	if(!istype(environment))
		return
	for(var/atom/movable/AM in contents)
		if(!AM.simulated)
			continue
		AM.loc = get_turf(src)
	for(var/datum/reagent/A in reagents.reagent_list)
		if(!isnull(gas_data.flags[A.id]))
			environment.adjust_gas(A.id, A.volume)

/obj/structure/aquarium/Destroy()
	deleting = 1
	if(connecting.len)
		for(var/obj/structure/aquarium/A in connecting)
			if(!A.deleting)
				qdel(A)
		connecting.Cut()
	..()

/obj/structure/aquarium/update_icon()

	// Update base state/dir.
	base_state = "single"
	if(connecting.len == 1)
		var/obj/structure/aquarium/A = connecting[1]
		base_state = "dirs"
		dir = get_dir(A, src)
	else if(connecting.len == 2)
		var/list/connect_dirs = list()
		connect_dirs = list(get_dir(src, connecting[1]),get_dir(src, connecting[2]))
		if((NORTH in connect_dirs) && (SOUTH in connect_dirs))
			base_state = "vertical"
		else if((EAST in connect_dirs) && (WEST in connect_dirs))
			base_state = "horizontal"

	// Apply icons.
	overlays.Cut()
	icon_state = "fishtank_[base_state]"
	var/cache_key = "water_[base_state]"
	if(!fishtank_cache[cache_key])
		var/image/I = image(icon, cache_key)
		I.layer = FLY_LAYER-0.1
		fishtank_cache[cache_key] = I
	overlays |= fishtank_cache[cache_key]
	cache_key = "glass_[base_state]"
	if(!fishtank_cache[cache_key])
		var/image/I = image(icon, cache_key)
		I.layer = FLY_LAYER
		fishtank_cache[cache_key] = I
	overlays |= fishtank_cache[cache_key]

	// Update overlays with contents.
	for(var/atom/movable/AM in contents)
		if(!AM.simulated)
			continue
		cache_key = "obj-[AM.icon_state]-[AM.dir]"
		if(AM.color) cache_key += AM.color
		if(!fishtank_cache[cache_key])
			var/image/I = image(AM.icon, AM.icon_state)
			I.dir = AM.dir
			I.color = AM.color
			I.layer = MOB_LAYER
			fishtank_cache[cache_key] = I
		overlays |= fishtank_cache[cache_key]

/obj/structure/aquarium/proc/get_neighbors()
	connecting.Cut()
	for(var/stepdir in cardinal)
		var/obj/structure/aquarium/A = locate() in get_step(get_turf(src),stepdir)
		if(istype(A) && !A.deleting)
			connecting |= A