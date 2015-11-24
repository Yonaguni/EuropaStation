var/network_count = 0

/datum/conduit_network
	var/name = "conduit network"
	var/list/conduits = list()

/datum/conduit_network/New()
	name += " #[++network_count]"

/datum/conduit_network/proc/add_conduit(var/obj/structure/conduit/new_feed)
	if(new_feed.network)
		return
	conduits |= new_feed
	new_feed.network = src

/datum/conduit_network/Destroy()
	for(var/obj/structure/conduit/conduit in conduits)
		conduit.network = null
	conduits.Cut()
	return ..()

/datum/conduit_network/proc/merge(var/datum/conduit_network/merging)
	for(var/obj/structure/conduit/conduit in merging.conduits)
		conduit.network = null
		add_conduit(conduit)
	merging.conduits.Cut()
	qdel(merging)
