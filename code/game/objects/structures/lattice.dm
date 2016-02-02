/obj/structure/lattice
	name = "lattice"
	desc = "A lightweight support lattice."
	icon = 'icons/obj/structures.dmi'
	icon_state = "latticefull"
	density = 0
	anchored = 1
	layer = 2.3
	w_class = 3

/obj/structure/lattice/New(var/newloc)
	var/turf/T = newloc
	if(!istype(T) || !T.accept_lattice)
		qdel(src)
		return

	..()

	for(var/obj/structure/lattice/lattice in newloc)
		if(lattice == src) continue
		qdel(lattice)

	icon = 'icons/obj/smoothlattice.dmi'
	update_icon()
	update_neighbors()

/obj/structure/lattice/proc/update_neighbors()
	for(var/dir in cardinal)
		var/obj/structure/lattice/L = locate() in get_step(src, dir)
		if(L) L.update_icon()

/obj/structure/lattice/Destroy()
	update_neighbors()
	return ..()

/obj/structure/lattice/ex_act(severity)
	switch(severity)
		if(1, 2)
			qdel(src)
			return
	return

/obj/structure/lattice/attackby(obj/item/C as obj, mob/user as mob)
	if (istype(C, /obj/item/stack/tile/floor))
		var/turf/T = get_turf(src)
		T.attackby(C, user) //BubbleWrap - hand this off to the underlying turf instead
		return
	if (istype(C, /obj/item/weapon/weldingtool))
		var/obj/item/weapon/weldingtool/WT = C
		if(WT.remove_fuel(0, user))
			user << "<span class='notice'>Slicing lattice joints ...</span>"
		PoolOrNew(/obj/item/stack/rods, src.loc)
		qdel(src)
	return

/obj/structure/lattice/update_icon()
	overlays = list()
	var/dir_sum = 0
	for (var/direction in cardinal)
		if(locate(/obj/structure/lattice, get_step(src, direction)))
			dir_sum += direction
		else
			if(!(istype(get_step(src, direction), /turf/space)))
				dir_sum += direction
	if(dir_sum)
		icon_state = "lattice[dir_sum]"
	else
		icon_state = "latticeblank"
	return
