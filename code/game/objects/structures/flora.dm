/obj/item/log
	name = "wood log"
	desc = "It's great for a snack, and fits on your back!"
	slot_flats = SLOT_BACK
	icon = 'icons/obj/objects.dmi'
	icon_state = "logs"
	w_class = 5

/obj/item/log/attackby(var/obj/item/thing, var/mob/user)
	if(istype(W,/obj/item/weapon/material/hatchet))
		user.show_message("<span class='notice'>You make planks out of \the [src]!</span>", 1)
		new /obj/item/stack/material/wood(get_turf(src), rand(2,5))
		var/mob/M = loc
		if(istype(M))
			M.unEquip(src)
		qdel(src)
		return
	return ..()

/obj/structure/flora
	name = "generic flora"
	anchored = 1

	var/harvest_ticks = 1
	var/harvest_tool
	var/harvest_result
	var/harvest_amount = 1
	var/harvest_message = "harvests from"
	var/harvest_fail_message = "fails to harvest from"

/obj/structure/flora/attackby(var/obj/item/thing, var/mob/user)
	if(harvest_tool && harvest_result)
		if(istype(thing, harvest_tool))
			harvest_ticks--
			if(harvest_ticks>0)
				fail_harvest(user, thing)
				return
			do_harvest(user, thing)
			return
	return ..()

/obj/structure/flora/proc/fail_harvest(var/mob/user, var/obj/item/thing)
	user.visible_message("<span class='notice'>\The [user] [harvest_fail_message] \the [src] with \the [thing].</span>")

/obj/structure/flora/proc/do_harvest(var/mob/user, var/obj/item/thing)
	var/turf/T = get_turf(src)
	var/list/results = list()
	for(var/x = 1 to harvest_amount)
		results += new harvest_result(T)
	user.visible_message("<span class='notice'>\The [user] [harvest_message] \the [src] with \the [thing].</span>")
	return results

//trees
/obj/structure/flora/tree
	name = "tree"
	pixel_x = -16
	density = 1
	layer = 9
	harvest_fail_message = "hacks away at"
	harvest_message = "chops down"
	harvest_ticks = 3
	harvest_amount = 3

/obj/structure/flora/tree/pine
	name = "pine tree"
	icon = 'icons/obj/flora/pinetrees.dmi'
	icon_state = "pine_1"
	harvest_ticks = 5
	harvest_amount = 5

/obj/structure/flora/tree/pine/do_harvest(var/mob/user, var/obj/item/thing)
	var/list/results = ..()
	var/turf/T = get_turf(src)
	if(results.len)
		var/fall_dir = get_dir(user, src)
		for(var/obj/item/debris in results)
			T = get_step(T, fall_dir)
			debris.throw_at(T, 10, rand(5,15))

/obj/structure/flora/tree/pine/New()
	..()
	icon_state = "pine_[rand(1, 3)]"

/obj/structure/flora/tree/pine/xmas
	name = "xmas tree"
	icon = 'icons/obj/flora/pinetrees.dmi'
	icon_state = "pine_c"

/obj/structure/flora/tree/pine/xmas/New()
	..()
	icon_state = "pine_c"

/obj/structure/flora/tree/dead
	icon = 'icons/obj/flora/deadtrees.dmi'
	icon_state = "tree_1"
	harvest_ticks = 4
	harvest_amount = 4

/obj/structure/flora/tree/dead/New()
	..()
	icon_state = "tree_[rand(1, 6)]"

//grass
/obj/structure/flora/grass
	name = "grass"
	icon = 'icons/obj/flora/snowflora.dmi'

/obj/structure/flora/grass/brown
	icon_state = "snowgrass1bb"

/obj/structure/flora/grass/brown/New()
	..()
	icon_state = "snowgrass[rand(1, 3)]bb"


/obj/structure/flora/grass/green
	icon_state = "snowgrass1gb"

/obj/structure/flora/grass/green/New()
	..()
	icon_state = "snowgrass[rand(1, 3)]gb"

/obj/structure/flora/grass/both
	icon_state = "snowgrassall1"

/obj/structure/flora/grass/both/New()
	..()
	icon_state = "snowgrassall[rand(1, 3)]"

//bushes
/obj/structure/flora/bush
	name = "bush"
	icon = 'icons/obj/flora/snowflora.dmi'
	icon_state = "snowbush1"

/obj/structure/flora/bush/New()
	..()
	icon_state = "snowbush[rand(1, 6)]"

/obj/structure/flora/pottedplant
	name = "potted plant"
	icon = 'icons/obj/plants.dmi'
	icon_state = "plant-26"

//newbushes

/obj/structure/flora/ausbushes
	name = "bush"
	icon = 'icons/obj/flora/ausflora.dmi'
	icon_state = "firstbush_1"

/obj/structure/flora/ausbushes/New()
	..()
	icon_state = "firstbush_[rand(1, 4)]"

/obj/structure/flora/ausbushes/reedbush
	icon_state = "reedbush_1"

/obj/structure/flora/ausbushes/reedbush/New()
	..()
	icon_state = "reedbush_[rand(1, 4)]"

/obj/structure/flora/ausbushes/leafybush
	icon_state = "leafybush_1"

/obj/structure/flora/ausbushes/leafybush/New()
	..()
	icon_state = "leafybush_[rand(1, 3)]"

/obj/structure/flora/ausbushes/palebush
	icon_state = "palebush_1"

/obj/structure/flora/ausbushes/palebush/New()
	..()
	icon_state = "palebush_[rand(1, 4)]"

/obj/structure/flora/ausbushes/stalkybush
	icon_state = "stalkybush_1"

/obj/structure/flora/ausbushes/stalkybush/New()
	..()
	icon_state = "stalkybush_[rand(1, 3)]"

/obj/structure/flora/ausbushes/grassybush
	icon_state = "grassybush_1"

/obj/structure/flora/ausbushes/grassybush/New()
	..()
	icon_state = "grassybush_[rand(1, 4)]"

/obj/structure/flora/ausbushes/fernybush
	icon_state = "fernybush_1"

/obj/structure/flora/ausbushes/fernybush/New()
	..()
	icon_state = "fernybush_[rand(1, 3)]"

/obj/structure/flora/ausbushes/sunnybush
	icon_state = "sunnybush_1"

/obj/structure/flora/ausbushes/sunnybush/New()
	..()
	icon_state = "sunnybush_[rand(1, 3)]"

/obj/structure/flora/ausbushes/genericbush
	icon_state = "genericbush_1"

/obj/structure/flora/ausbushes/genericbush/New()
	..()
	icon_state = "genericbush_[rand(1, 4)]"

/obj/structure/flora/ausbushes/pointybush
	icon_state = "pointybush_1"

/obj/structure/flora/ausbushes/pointybush/New()
	..()
	icon_state = "pointybush_[rand(1, 4)]"

/obj/structure/flora/ausbushes/lavendergrass
	icon_state = "lavendergrass_1"

/obj/structure/flora/ausbushes/lavendergrass/New()
	..()
	icon_state = "lavendergrass_[rand(1, 4)]"

/obj/structure/flora/ausbushes/ywflowers
	icon_state = "ywflowers_1"

/obj/structure/flora/ausbushes/ywflowers/New()
	..()
	icon_state = "ywflowers_[rand(1, 3)]"

/obj/structure/flora/ausbushes/brflowers
	icon_state = "brflowers_1"

/obj/structure/flora/ausbushes/brflowers/New()
	..()
	icon_state = "brflowers_[rand(1, 3)]"

/obj/structure/flora/ausbushes/ppflowers
	icon_state = "ppflowers_1"

/obj/structure/flora/ausbushes/ppflowers/New()
	..()
	icon_state = "ppflowers_[rand(1, 4)]"

/obj/structure/flora/ausbushes/sparsegrass
	icon_state = "sparsegrass_1"

/obj/structure/flora/ausbushes/sparsegrass/New()
	..()
	icon_state = "sparsegrass_[rand(1, 3)]"

/obj/structure/flora/ausbushes/fullgrass
	icon_state = "fullgrass_1"

/obj/structure/flora/ausbushes/fullgrass/New()
	..()
	icon_state = "fullgrass_[rand(1, 3)]"
