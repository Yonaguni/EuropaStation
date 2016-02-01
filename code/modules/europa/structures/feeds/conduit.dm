// Basic class. Don't actually use this for anything.
var/list/feed_cache = list()

/obj/structure/conduit

	name = "feed conduit"
	icon_state = "matter_feed"
	icon = 'icons/obj/europa/structures/conduits/matter_feed.dmi'
	anchored = 1
	density = 0
	layer = 2.5

	// Track type and nature of connections.
	var/deconstruct_tool = /obj/item/weapon/wrench
	var/deconstruct_path = /obj/item/stack/conduit
	var/deconstruct_time = 20
	var/deconstruct_verb = "removed"
	var/deconstruct_adj = "removing"
	var/deconstruct_sound = 'sound/items/Ratchet.ogg'

	var/feed_icon
	var/feed_type
	var/feed_layer = 0
	var/network_type = /datum/conduit_network
	var/datum/conduit_network/network

	var/list/connected_to = list()
	var/connection_dir = 0

    // Used for calculating offset.
	var/conduit_width = 4
	var/conduit_offset = 10

/obj/structure/conduit/examine()
	..()
	usr << "<span class='notice'>It has been placed in row [feed_layer+1].</span>"

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
	if(build_layer)
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
	spawn(1)
		update_icon()

/obj/structure/conduit/Destroy()
	if(network)
		qdel(network)
		network = null
	for(var/turf/check_turf in orange(src,1))
		if(!check_turf || !check_turf.contents.len)
			continue
		for(var/obj/structure/conduit/check_feed in check_turf.contents)
			if(!(src in check_feed.connected_to))
				continue
			if(check_feed.feed_layer == src.feed_layer)
				check_feed.connected_to -= src
				check_feed.connection_dir &= ~(get_dir(check_feed, src))
				spawn(1)
					check_feed.update_icon()
	feed_layer = -1
	feed_type = "deleting"
	return ..()

/obj/structure/conduit/proc/build_network(var/recursive = 1)
	var/turf/T = get_turf(src)
	if(!T) return

	connected_to = list()
	connection_dir = 0

	for(var/check_dir in list(NORTH, SOUTH, EAST, WEST))
		var/turf/check_turf = get_step(T, check_dir)
		if(!check_turf || !check_turf.contents.len)
			continue
		for(var/obj/structure/conduit/check_feed in check_turf.contents)
			if(check_feed.feed_type == src.feed_type && check_feed.feed_layer == src.feed_layer)
				if(!network && check_feed.network)
					check_feed.network.add_conduit(src)
				connected_to |= check_feed
				connection_dir |= get_dir(src, check_feed)
				check_feed.connected_to |= src
				check_feed.connection_dir |= get_dir(check_feed, src)
				check_feed.update_icon()
				break

	if(connected_to.len)
		for(var/obj/structure/conduit/F in connected_to)
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

	if(!connected_to || !connected_to.len)
		dir = 0
		icon_state = "[feed_icon]_single"
	else if(connected_to.len == 1 || (connection_dir == NORTHEAST || connection_dir == NORTHWEST || connection_dir == SOUTHEAST || connection_dir == SOUTHWEST))
		icon_state = "[feed_icon]"
		dir = connection_dir
	else
		if(connected_to.len == 4)
			dir = 0
			icon_state = "[feed_icon]_full"
		else if(connected_to.len == 2 && (((connection_dir & NORTH) && (connection_dir & SOUTH)) || ((connection_dir & EAST) && (connection_dir & WEST))))
			icon_state = "[feed_icon]_straight"
			if(connection_dir & NORTH)
				dir = NORTH
			else
				dir = EAST
		else
			icon_state = "[feed_icon]_manifold"
			dir = (15 & (~connection_dir)) // Get the solitary unconnected dir.

	layer = min(2.7,initial(layer) + (feed_layer/10))
	pixel_x = (feed_layer * conduit_width) - conduit_offset
	pixel_y = pixel_x
