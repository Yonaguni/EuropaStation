// Dummy item for lathes.
/obj/item/supply_beacon
	name = "supply beacon"
	matter = list(MATERIAL_STEEL = 8000)

/obj/item/supply_beacon/Initialize()
	..()
	new /obj/structure/supply_beacon(get_turf(src))
	return INITIALIZE_HINT_QDEL

// Actual beacon.
/obj/structure/supply_beacon
	name = "supply beacon"
	desc = "A bulky moonshot supply beacon. Insert a cargo chit and deploy to recieve a cargo pod."
	icon = 'icons/obj/supplybeacon.dmi'
	icon_state = "beacon"
	waterproof = 1
	anchored = 0
	density = 1
	layer = MOB_LAYER - 0.1

	var/active = 0
	var/obj/item/cargo_chit/cargo_chit
	var/target_drop_time
	var/drop_delay = 30 SECONDS
	var/expended
	var/drop_type

/obj/structure/supply_beacon/attackby(var/obj/item/W, var/mob/user)

	if(!active)

		if(W.isscrewdriver() && cargo_chit)
			cargo_chit.forceMove(get_turf(src))
			user.visible_message("<span class = 'notice'>\The [user] pops \the [cargo_chit] out of \the [src].</span>")
			cargo_chit = null
			return

		if(istype(W, /obj/item/cargo_chit))
			if(cargo_chit)
				to_chat(user, "<span class='warning'>\The [src] already has a cargo chit inserted.</span>")
				return
			user.drop_from_inventory(W)
			W.forceMove(src)
			cargo_chit = W
			user.visible_message("<span class = 'notice'>\The [user] slots \the [W] into \the [src].</span>")
			return

		if(W.iswrench())
			anchored = !anchored
			user.visible_message("<span class='notice'>\The [user] [anchored ? "secures" : "unsecures"] \the [src].</span>")
			playsound(src.loc, 'sound/items/Ratchet.ogg', 50, 1)
			return

	return ..()

/obj/structure/supply_beacon/attack_hand(var/mob/user)

	if(expended)
		user << "<span class='warning'>\The [src] has used up its charge.</span>"
		return

	if(!cargo_chit)
		user << "<span class='warning'>\The [src] has no cargo chit inserted.</span>"
		return

	if(anchored)
		return active ? deactivate(user) : activate(user)
	else
		user << "<span class='warning'>You need to secure the beacon with a wrench first!</span>"

/obj/structure/supply_beacon/attack_ai(var/mob/user)
	if(user.Adjacent(src))
		attack_hand(user)

/obj/structure/supply_beacon/proc/activate(var/mob/user)
	if(expended)
		return
	set_light(3, 3, "#00CCAA")
	icon_state = "beacon_active"
	active = 1
	START_PROCESSING(SSprocessing, src)
	if(user) user << "<span class='notice'>You activate the beacon. The supply drop will be dispatched soon.</span>"

/obj/structure/supply_beacon/proc/deactivate(var/mob/user, var/permanent)
	if(permanent)
		expended = 1
		icon_state = "beacon_depleted"
	else
		icon_state = "beacon"
	kill_light()
	active = 0
	STOP_PROCESSING(SSprocessing, src)
	target_drop_time = null
	if(user) user << "<span class='notice'>You deactivate the beacon.</span>"

/obj/structure/supply_beacon/Destroy()
	processing_objects -= src
	if(cargo_chit)
		qdel(cargo_chit)
		cargo_chit = null
	. = ..()

/obj/structure/supply_beacon/process()

	if(!cargo_chit)
		deactivate()
		return PROCESS_KILL

	if(!active || expended)
		return PROCESS_KILL

	if(!target_drop_time)
		target_drop_time = world.time + drop_delay
	else if(world.time >= target_drop_time)

		deactivate()

		var/drop_x = max(TRANSITIONEDGE, min(world.maxx-TRANSITIONEDGE, x + rand(-7, 7)))
		var/drop_y = max(TRANSITIONEDGE, min(world.maxy-TRANSITIONEDGE, y + rand(-7 ,7)))
		var/drop_z = z
		var/list/drop_atoms = cargo_chit.purchased_atoms.Copy()

		command_announcement.Announce("Oort Exterior Rapid Fabrication priority supply request #[cargo_chit.order_id] recieved. Shipment dispatched via ballistic supply pod for immediate delivery. Have a nice day.", "Thank You For Your Patronage")
		qdel(cargo_chit)
		cargo_chit = null

		spawn(rand(50,60))
			new /datum/random_map/droppod/supply(null, drop_x, drop_y, drop_z, supplied_drop = "custom", supplied_atoms = drop_atoms)
