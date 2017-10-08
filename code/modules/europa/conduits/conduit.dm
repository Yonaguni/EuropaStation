// Basic class. Don't actually use this for anything.
var/list/feed_cache = list()

/obj/structure/conduit

	name = "feed conduit"
	icon_state = "matter_feed"
	icon = 'icons/obj/structures/basic_pipeline.dmi'
	anchored = 1
	density = 0
	layer = TURF_LAYER + 0.1

	// Track type and nature of connections.
	var/deconstruct_tool = /obj/item/wrench
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
	var/obj/structure/conduit/connect_upwards
	var/obj/structure/conduit/connect_downwards

    // Used for calculating offset.
	var/conduit_width = 4
	var/conduit_offset = 10

/obj/structure/conduit/examine(var/mob/user)
	. = ..()
	if(.)
		to_chat(user, "<span class='notice'>It has been placed in row [feed_layer+1].</span>")

/obj/structure/conduit/attackby(var/obj/item/W, var/mob/user)
	if(istype(W, deconstruct_tool))
		var/deconstruct_fail = check_deconstruct(W, user)
		if(deconstruct_fail)
			to_chat(user, "<span class='warning'>[deconstruct_fail]</span>")
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
	update_icon()

/obj/structure/conduit/Destroy()

	feed_layer = -1
	feed_type = "deleting"

	var/datum/conduit_network/tmp_network
	if(network)
		tmp_network = network
		network.clear() // nulls this var

	var/list/split_points = list()

	if(connected_to && connected_to.len)
		for(var/obj/structure/conduit/check_feed in connected_to)
			if(check_feed.connected_to[src])
				check_feed.connected_to[src] = null
				check_feed.connected_to -= src
				check_feed.connection_dir &= ~(get_dir(check_feed, src))
				split_points += check_feed
		connected_to = null

	if(connect_upwards)
		if(connect_upwards.connect_downwards == src)
			connect_upwards.connect_downwards = null
			split_points += connect_upwards
		connect_upwards = null

	if(connect_downwards)
		if(connect_downwards.connect_upwards == src)
			connect_downwards.connect_upwards = null
			split_points += connect_downwards
		connect_downwards = null

	var/list/formed_networks = list()
	for(var/obj/structure/conduit/check_feed in split_points)
		formed_networks |= check_feed.build_network()

	if(tmp_network) tmp_network.split_between(formed_networks)

	. = ..()

/obj/structure/conduit/proc/find_connecting_pipe_in_contents(var/turf/checking)
	if(istype(checking) && checking.contents)
		for(var/obj/structure/conduit/check_feed in checking.contents)
			if(connect_to(check_feed))
				return check_feed
	return 0

/obj/structure/conduit/proc/connect_to(var/obj/structure/conduit/check_feed)
	if(!istype(check_feed) || check_feed.feed_type != feed_type || check_feed.feed_layer != feed_layer)
		return 0
	if(!network && check_feed.network)
		check_feed.network.add_conduit(src)
	return 1

/obj/structure/conduit/proc/build_network(var/recursive = 1)
	var/turf/T = get_turf(src)
	if(!T) return

	connected_to = list()
	connection_dir = 0
	connect_upwards = null
	connect_downwards = null

	if(HasBelow(T.z) && T.open_space)
		var/obj/structure/conduit/C = find_connecting_pipe_in_contents(GetBelow(T))
		if(C)
			connect_downwards = C
			C.connect_upwards = src
			C.update_icon()

	if(HasAbove(T.z))
		var/turf/above = GetAbove(T)
		if(above && above.open_space)
			var/obj/structure/conduit/C = find_connecting_pipe_in_contents(above)
			if(C)
				connect_upwards = C
				C.connect_downwards = src
				C.update_icon()

	for(var/check_dir in list(NORTH, SOUTH, EAST, WEST))
		var/obj/structure/conduit/C = find_connecting_pipe_in_contents(get_step(T, check_dir))
		if(C)
			connection_dir |= check_dir
			connected_to[C] = 1
			C.connection_dir |= reverse_dir[check_dir]
			C.connected_to[src] = 1
			C.update_icon()

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
	return network

/obj/structure/conduit/update_icon()

	if(!connected_to || !connected_to.len)
		dir = 0
		icon_state = "[feed_icon]_single"
	else if(connected_to.len == 1 || connection_dir == NORTHEAST || connection_dir == NORTHWEST || connection_dir == SOUTHEAST || connection_dir == SOUTHWEST)
		icon_state = "[feed_icon]"
		dir = connection_dir
	else
		if(connected_to.len == 4)
			dir = 0
			icon_state = "[feed_icon]_full"
		//else if (connected_to.len == 2 && (((connection_dir & NORTH) && (connection_dir & SOUTH)) || ((connection_dir & EAST) && (connection_dir & WEST))
		else if(connected_to.len == 2 && (((connection_dir & (NORTH|SOUTH)) == (NORTH|SOUTH)) || ((connection_dir & (EAST|WEST)) == (EAST|WEST)))) // thanks Lohikar :D
			icon_state = "[feed_icon]_straight"
			if(connection_dir & NORTH)
				dir = NORTH
			else
				dir = EAST
		else
			icon_state = "[feed_icon]_manifold"
			dir = (15 & (~connection_dir)) // Get the solitary unconnected dir.

	layer = min(2.7,initial(layer) + (feed_layer/10))

	overlays = null
	if(connect_upwards)
		overlays += "[feed_icon]_up"

	underlays = null
	if(connect_downwards)
		underlays += "[feed_icon]_down"

	pixel_x = (feed_layer * conduit_width) - conduit_offset
	pixel_y = pixel_x
