/obj/machinery/hydroponics/soil
	name = "soil"
	icon_state = "soil"
	density = 0
	use_power = 0
	mechanical = 0
	tray_light = 0

/obj/machinery/hydroponics/soil/attackby(var/obj/item/O as obj, var/mob/user as mob)
	if(istype(O,/obj/item/weapon/tank))
		return
	else
		..()

/obj/machinery/hydroponics/soil/New()
	..()
	verbs -= /obj/machinery/hydroponics/verb/close_lid_verb
	verbs -= /obj/machinery/hydroponics/verb/remove_label
	verbs -= /obj/machinery/hydroponics/verb/setlight

/obj/machinery/hydroponics/soil/CanPass()
	return 1

/obj/machinery/hydroponics/soil/farm
	name = "furrowed earth"
	desc = "Hopefully the dust crop will be good this year."
	icon_state = "furrow"

// Holder for vine plants.
// Icons for plants are generated as overlays, so setting it to invisible wouldn't work.
// Hence using a blank icon.
/obj/machinery/hydroponics/soil/invisible
	name = "plant"
	icon = 'icons/obj/seeds.dmi'
	icon_state = "blank"

/obj/machinery/hydroponics/soil/invisible/New(var/newloc,var/datum/seed/newseed)
	..()
	seed = newseed
	dead = 0
	age = 1
	health = seed.get_trait(TRAIT_ENDURANCE)
	lastcycle = world.time
	pixel_y = rand(-5,5)
	check_health()

/obj/machinery/hydroponics/soil/invisible/remove_dead()
	..()
	qdel(src)

/obj/machinery/hydroponics/soil/invisible/harvest()
	..()
	if(!seed) // Repeat harvests are a thing.
		qdel(src)

/obj/machinery/hydroponics/soil/invisible/die()
	qdel(src)

/obj/machinery/hydroponics/soil/invisible/process()
	if(!seed)
		qdel(src)
		return
	else if(name=="plant")
		name = seed.display_name
	..()

/obj/machinery/hydroponics/soil/invisible/Destroy()
	// Check if we're masking a decal that needs to be visible again.
	for(var/obj/effect/plant/plant in get_turf(src))
		if(plant.invisibility == INVISIBILITY_MAXIMUM)
			plant.invisibility = initial(plant.invisibility)
	..()
