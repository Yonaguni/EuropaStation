//trees
/obj/structure/flora/tree
	name = "tree"
	pixel_x = -16
	density = 1
	layer = 9
	icon = 'icons/obj/flora/trees.dmi'
	icon_state = "generic_tree"

	harvest_fail_message = "hacks away at"
	harvest_message = "chops down"
	harvest_ticks = 3
	harvest_amount = 3
	harvest_tool = /obj/item/weapon/material/hatchet
	harvest_result = /obj/item/log

/obj/structure/flora/tree/New()
	..()
	if(prob(50))
		icon_state = "generic_tree2"

/obj/structure/flora/tree/ex_act(severity)
	switch(severity)
		if(1)
			visible_message("<span class='warning'>\The [src] is broken by the blastwave!</span>")
			qdel(src)
		if(2)
			if(prob(70))
				visible_message("<span class='warning'>\The [src] is knocked over by the blastwave!</span>")
				harvest_amount = rand(1,harvest_amount)
				var/turf/T = get_turf(src)
				for(var/x = 1 to harvest_amount)
					new harvest_result(T)
				qdel(src)

/obj/structure/flora/tree/pine
	name = "pine tree"
	icon_state = "pine_1"
	harvest_ticks = 5
	harvest_amount = 5

/obj/structure/flora/tree/pine/do_harvest(var/mob/user, var/obj/item/thing)
	var/list/results = ..()
	var/turf/T = get_turf(src)
	if(results.len)
		var/fall_dir = get_dir(get_turf(user), T)
		for(var/obj/item/debris in results)
			T = get_step(T, fall_dir)
			debris.throw_at(T, 10, rand(5,15))

/obj/structure/flora/tree/pine/New()
	..()
	icon_state = "pine_[rand(1, 3)]"

/obj/structure/flora/tree/pine/xmas
	name = "xmas tree"
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