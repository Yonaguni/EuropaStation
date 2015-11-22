// Basic class. Don't actually use this for anything.
var/list/feed_cache = list()

/obj/structure/conduit

	name = "feed conduit"
	icon_state = "feed_conduit"
	icon = 'icons/obj/europa/structures/feeds.dmi'
	anchored = 1
	density = 0

	// Track type and nature of connections.
	var/deconstruct_tool = /obj/item/weapon/wrench
	var/deconstruct_path = /obj/item/stack/conduit
	var/deconstruct_time = 20
	var/deconstruct_verb = "removed"
	var/deconstruct_adj = "removing"
	var/deconstruct_sound = 'sound/items/Ratchet.ogg'
	var/feed_type

	var/feed_layer = 0
	var/network_type = /datum/conduit_network
	var/datum/conduit_network/network
	var/list/connections = list()

    // Used for calculating offset.
	var/conduit_width = 4
	var/conduit_offset = 10

/obj/structure/conduit/attackby(var/obj/item/W, var/mob/user)
	if(istype(W, deconstruct_tool))
		var/deconstruct_fail = check_deconstruct(W, user)
		if(deconstruct_fail)
			user << "<span class='warning'>[deconstruct_fail]</span>"
			return
		if(deconstruct_time)
			visible_message("<span class='notice'>\The [user] begins [deconstruct_adj] \the [src].</span>")
			if(do_after(user, deconstruct_time))
				visible_message("<span class='notice'>\The [user] has [deconstruct_verb] \the [src].</span>")
				deconstruct()
		else
			visible_message("<span class='notice'>\The [user] has [deconstruct_verb] \the [src].</span>")
			deconstruct()
	else
		return ..()

/obj/structure/conduit/New(var/newloc, var/build_layer)
	var/turf/T = get_turf(newloc)
	feed_layer = build_layer
	if(T)
		for(var/obj/structure/conduit/C in T.contents)
			if(C == src)
				continue
			if(C.feed_type == src.feed_type && C.feed_layer == src.feed_layer)
				qdel(src)
				return
	..()

// Returns a string if deconstruction fails (due to overpressure or such).
/obj/structure/conduit/proc/check_deconstruct(var/obj/item/thing, var/mob/user)
	return

/obj/structure/conduit/proc/deconstruct()
	var/obj/item/debris = new deconstruct_path(get_turf(src), 1) //This should probably be a stack.
	if(istype(debris))
		debris.color = color
	playsound(get_turf(src), deconstruct_sound, 75, 1)
	qdel(src)

/obj/structure/conduit/initialize()
	build_network()

/obj/structure/conduit/Destroy()
	if(network)
		qdel(network)
		network = null
	feed_layer = -1
	feed_type = "deleting"
	var/turf/T = get_turf(src)
	for(var/check_dir in list(NORTH, SOUTH, EAST, WEST))
		var/turf/check_turf = get_step(T, check_dir)
		if(!check_turf || !check_turf.contents.len)
			continue
		for(var/obj/structure/conduit/check_feed in check_turf.contents)
			if(check_feed.feed_type == src.feed_type && check_feed.feed_layer == src.feed_layer)
				check_feed.connections["[get_dir(check_feed, src)]"] = null
				check_feed.update_icon()

	return ..()

/obj/structure/conduit/proc/build_network(var/recursive = 1)
	color = null
	var/turf/T = get_turf(src)
	if(!T) return

	connections = list()
	for(var/check_dir in list(NORTH, SOUTH, EAST, WEST))
		var/turf/check_turf = get_step(T, check_dir)
		if(!check_turf || !check_turf.contents.len)
			continue
		for(var/obj/structure/conduit/check_feed in check_turf.contents)
			if(check_feed.feed_type == src.feed_type && check_feed.feed_layer == src.feed_layer)
				if(!network && check_feed.network)
					check_feed.network.add_conduit(src)
				connections["[check_dir]"] = check_feed
				check_feed.connections["[get_dir(check_feed, src)]"] = src
				check_feed.update_icon()
				break

	if(connections.len)
		for(var/check_dir in connections)
			var/obj/structure/conduit/F = connections[check_dir]
			if(network)
				if(F.network)
					if(network == F.network)
						continue
					network.merge(F.network)
				else
					network.add_conduit(F)
					if(recursive) F.build_network()
			else
				if(F.network)
					F.network.add_conduit(src)
				else
					var/datum/conduit_network/CN = new network_type
					CN.add_conduit(src)
					CN.add_conduit(F)
					if(recursive) F.build_network()
	if(!network)
		var/datum/conduit_network/CN = new network_type
		CN.add_conduit(src)

	update_icon()

/obj/structure/conduit/update_icon()

	layer = initial(layer) + (feed_layer/10)
	overlays.Cut()
	for(var/con_dir in connections)
		if(connections[con_dir])
			var/cache_key = "[feed_type]_[con_dir]_[feed_layer]"
			if(!feed_cache[cache_key])
				var/image/I = image(icon, "[feed_type]_con_[con_dir]")
				I.layer = src.layer-0.1
				feed_cache[cache_key] = I
			overlays += feed_cache[cache_key]

	pixel_x = (feed_layer * conduit_width) - conduit_offset
	pixel_y = pixel_x
