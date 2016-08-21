/atom/proc/fire_act()
	return

/turf/fire_act()
	ignite()

/atom/movable/fire_act()
	ignite()

/obj/item/weapon/reagent_containers/glass/rag/fire_act()
	. = ..()
	new /obj/effect/decal/cleanable/ash(get_turf(src))
	qdel(src)

/mob/living/human/fire_act() // TODO
	. = ..()

/obj/structure/reagent_dispensers/fueltank/fire_act(datum/gas_mixture/air, temperature, volume)
	. = ..()
	explode()

/obj/effect/spider/fire_act()
	. = ..()
	health -= 5
	healthcheck()

/obj/effect/effect/foam/fire_act() // foam disolves when heated, except metal foams
	. = ..()
	if(!metal)
		flick("[icon_state]-disolve", src)
		spawn(5)
			qdel(src)

/obj/item/latexballon/fire_act(datum/gas_mixture/air, temperature, volume)
	. = ..()
	burst()

/obj/machinery/door/unpowered/simple/fire_act()
	. = ..()
	if(material.combustion_effect())
		take_damage(10)

/obj/machinery/light/fire_act()
	. = ..()
	broken()

/obj/structure/grille/fire_act()
	. = ..()
	if(destroyed)
		return
	health -= 1
	healthcheck()

/obj/structure/window/fire_act()
	. = ..()
	hit(damage_per_fire_tick, 0)

/turf/simulated/floor/fire_act()
	. = ..()
	make_plating()
	burn_tile()

/turf/simulated/wall/fire_act()
	. = ..()
	if(material.combustion_effect())
		take_damage(10)