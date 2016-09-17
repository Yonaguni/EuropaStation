/obj/structure/conduit/matter
	name = "matter feed"
	desc = "A reinforced pipeline for transporting materials."
	icon = 'icons/obj/structures/conduits/matter_feed.dmi'
	icon_state = "matter_feed_single"
	color = "#999999"

	feed_type = "matter_feed"
	feed_icon = "matter_feed"
	network_type = /datum/conduit_network/matter_feed
	deconstruct_path = /obj/item/stack/conduit/matter

/obj/structure/conduit/matter/initialize()
	..()
	if(!network)
		return
	var/datum/conduit_network/matter_feed/feed_network = network
	var/turf/T = get_turf(src)
	for(var/obj/structure/conduit_storage/S in T.contents)
		feed_network.connected_storage |= S
