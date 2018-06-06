var/list/grass_types = list(
	/obj/structure/flora/ausbushes/sparsegrass,
	/obj/structure/flora/ausbushes/fullgrass
	)

var/list/tree_types = list(
	/obj/structure/flora/tree
	)

/turf/simulated/floor/natural
	name = "dirt"
	desc = "Dirty."
	density = 0
	opacity = 0
	icon = 'icons/turf/seafloor.dmi'
	icon_state = "seafloor"
	accept_lattice = 1
	blend_with_neighbors = 1
	outside = 1

	var/grass_prob = 0
	var/tree_prob = 0
	var/diggable = 1

/turf/simulated/floor/natural/ex_act(severity)
	src.ChangeTurf(get_base_turf_by_area(src))

/turf/simulated/floor/natural/is_plating()
	return 1

/turf/simulated/floor/natural/Initialize()
	if(grass_prob && prob(grass_prob))
		var/grass_type = pick(grass_types)
		new grass_type(src)
	if(tree_prob && prob(tree_prob))
		var/tree_type = pick(tree_types)
		new tree_type(src)
	return ..()

/turf/simulated/floor/natural/attackby(obj/item/C, mob/user)
	if(diggable && istype(C,/obj/item/pickaxe))
		var/obj/item/pickaxe/PA = C
		if(PA.dig_sand)
			var/obj/structure/pit/P = locate(/obj/structure/pit) in src
			if(P)
				P.attackby(C, user)
			else
				visible_message("<span class='notice'>\The [user] starts digging \the [src]</span>")
				if(do_after(user, 50))
					user << "<span class='notice'>You dig a deep pit.</span>"
					if(!(locate(/obj/structure/pit) in src))
						new /obj/structure/pit(src)
				else
					user << "<span class='notice'>You stop shoveling.</span>"
	else
		..()

/turf/simulated/floor/natural/light
	name = "light mud"
	icon_state = "mud_light"
	blend_with_neighbors = 2
	grass_prob = 10

/turf/simulated/floor/natural/dark
	name = "dark mud"
	icon_state = "mud_dark"
	blend_with_neighbors = 3
	grass_prob = 15

/turf/simulated/floor/natural/sand
	name = "sand"
	icon_state = "sand"
	blend_with_neighbors = 4
	grass_prob = 5

/turf/simulated/floor/natural/sand/caves
	name = "sand"
	icon_state = "sand"
	blend_with_neighbors = 4
	grass_prob = 0
	diggable = 0

/turf/simulated/floor/natural/dirt
	name = "dark dirt"
	icon_state = "dirt-dark"
	blend_with_neighbors = 5

/turf/simulated/floor/natural/grass
	name = "grass"
	icon_state = "grass"
	blend_with_neighbors = 6
	grass_prob = 40
	tree_prob = 3

/turf/simulated/floor/natural/grass/ex_act(severity)
	uproot()

/turf/simulated/floor/natural/grass/proc/uproot()
	name = "uprooted grass"
	icon_state = "mud_dark"
	grass_prob= 0
	tree_prob = 0
	blend_with_neighbors = 5
	update_icon(1)

/turf/simulated/floor/natural/grass/forest
	name = "thick grass"
	icon_state = "grass-dark"
	grass_prob = 80
	tree_prob = 20
	blend_with_neighbors = 8

/*
/turf/simulated/floor/natural/grass/forest/Initialize()
	. = ..()
	if(prob(3) && !(locate(/obj/landmark/animal_spawn) in src)) // This is a placeholder for a proper deer/prey animal spawn setup.
		new /obj/landmark/animal_spawn/deer(src)                // Accordingly, it will probably be here in ten years.
*/

/turf/simulated/floor/natural/grass/Initialize()
	if(prob(50))
		icon_state += "2"
		blend_with_neighbors++
	return ..()

// It's kinda like a sink!
/turf/simulated/floor/water
	name = "shallow water"
	icon = 'icons/turf/water.dmi'
	icon_state = "seashallow"
	blend_with_neighbors = -1

/turf/simulated/floor/water/attack_hand(var/mob/user)

	var/mob/living/carbon/human/H = user
	if(!istype(H))
		return ..()
	H << "<span class='notice'>You start washing your hands.</span>"
	if(!do_after(H, 40) || !Adjacent(H))
		return
	H.clean_blood()
	H.update_inv_gloves()
	H.visible_message("<span class='notice'>\The [user] washes their hands in \the [src].</span>")

/turf/simulated/floor/water/attackby(var/obj/item/O, var/mob/user)
	var/obj/item/reagent_containers/RG = O
	if(istype(RG) && RG.is_open_container())
		RG.reagents.add_reagent(REAGENT_WATER, min(RG.volume - RG.reagents.total_volume, RG.amount_per_transfer_from_this))
		user.visible_message("<span class='notice'>\The [user] fills \the [RG] from \the [src].</span>")
		playsound(src, 'sound/effects/slosh.ogg', 25, 1)
		return 1

	user << "<span class='notice'>You start washing \the [O].</span>"
	if(!do_after(user, 40) || !Adjacent(user))
		return
	if(user.get_active_hand() != O)
		return

	O.clean_blood()
	user.visible_message("<span class='notice'>\The [user] washes \the [O] in \the [src].</span>")
