// This is not very good code and could use cleanup and optimization, but
// I am very tired and will probably forget in the morning. C'est la vie. ~Z

#define FIRE_LIT   1
#define FIRE_DEAD -1
#define FIRE_OUT   0

var/list/fire_cache = list()
var/list/fire_sounds = list(
	'sound/ambience/comfyfire.ogg',
	'sound/ambience/comfyfire1.ogg',
	'sound/ambience/comfyfire2.ogg',
	'sound/ambience/comfyfire3.ogg'
	)

/obj/structure/fire_source
	name = "campfire"
	desc = "Did anyone bring any marshmallows?"
	icon = 'icons/obj/europa/structures/fire.dmi'
	icon_state = "campfire"
	anchored = 1
	density = 1

	var/open_flame = 1
	var/datum/effect/effect/system/steam_spread/steam // Used when being quenched.

	var/light_range_high = 5
	var/light_range_mid = 4
	var/light_range_low = 3

	var/light_power_high = 3
	var/light_power_mid = 2
	var/light_power_low = 1

	var/light_colour_high = "#FFDD55"
	var/light_colour_mid =  "#FF9900"
	var/light_colour_low =  "#FF0000"

	var/output_temperature = T0C+50  // The amount that the fire will try to heat up the air.
	var/last_burn_tick = 0           // When did we last burn?
	var/burn_time = 40               // How long between burn ticks?
	var/fuel = 0                     // How much fuel is left?
	var/lit = 0

/obj/structure/fire_source/initialize()
	..()
	if(lit == FIRE_LIT && fuel > 0)
		light()
	update_icon()

	steam = new(name)
	steam.attach(get_turf(src))
	steam.set_up(3, 0, get_turf(src))

/obj/structure/fire_source/hearth
	name = "hearth fire"
	desc = "So cheery!"
	fuel = 100
	burn_time = 80
	lit = FIRE_LIT

/obj/structure/fire_source/hearth/update_icon()
	..()
	if(lit == FIRE_LIT)
		opacity = 1

/obj/structure/fire_source/stove
	name = "stove"
	desc = "Just the thing to warm your hands by."
	icon_state = "stove"
	burn_time = 80
	light_range_high = 3
	light_range_mid = 2
	light_range_low = 1
	light_power_high = 2
	light_power_mid = 1
	light_colour_high = "#FFDD55"
	light_colour_mid =  "#FF6600"
	light_colour_low =  "#FF0000"
	open_flame = 0

/obj/structure/fire_source/fireplace
	name = "fireplace"
	desc = "So cheery!"
	icon_state = "fireplace"
	burn_time = 60
	light_range_high = 3
	light_range_mid = 2
	light_range_low = 1
	open_flame = 0

/obj/structure/fire_source/water_act()
	die()

/obj/structure/fire_source/ex_act()
	die()

/obj/structure/fire_source/proc/die()
	if(lit != FIRE_LIT)
		return
	lit = FIRE_DEAD
	playsound(get_turf(src), 'sound/misc/firehiss.ogg', 75, 1)
	visible_message("<span class='danger'>\The [src] goes out!</span>")
	processing_objects -= src
	update_icon()
	return

/obj/structure/fire_source/proc/light()
	var/datum/gas_mixture/GM = loc.return_air()
	if(!istype(GM) || !GM.gas["oxygen"])
		return
	if(lit == FIRE_LIT)
		return
	if((!fuel || fuel <= 0) && !process_fuel())
		return
	lit = FIRE_LIT
	visible_message("<span class='danger'>\The [src] catches alight!</span>")
	processing_objects |= src
	process()
	return

/obj/structure/fire_source/attack_hand(var/mob/user)
	if(!contents.len)
		return ..()

	var/obj/item/removing = pick(contents)
	removing.forceMove(get_turf(user))
	user.put_in_hands(removing)
	if(lit == FIRE_LIT)
		visible_message("<span class='danger'>\The [user] hastily fishes \the [removing] out of \the [src]!</span>")
		burn(user)
	else
		visible_message("<span class='notice'>\The [user] removes \the [removing] from \the [src].</span>")

/obj/structure/fire_source/attackby(var/obj/item/thing, var/mob/user)

	// A spot of the old ultraviolence.
	if(istype(thing, /obj/item/weapon/grab) && open_flame)
		var/obj/item/weapon/grab/G = thing
		if(G.state < GRAB_AGGRESSIVE)
			user << "<span class='warning'>You need a better grip!</span>"
			return
		if(G.affecting)
			G.affecting.forceMove(get_turf(src))
			G.affecting.Weaken(5)
			visible_message("<span class='danger'>\The [user] hurls \the [G.affecting] onto \the [src]!</span>")
			burn(G.affecting)
			user.unEquip(G)
			qdel(G)
			return

	if(istype(thing, /obj/item/weapon/reagent_containers))
		var/obj/item/weapon/reagent_containers/RG = thing
		if(RG.is_open_container() && RG.reagents && RG.reagents.total_volume)
			user.visible_message("<span class='danger'>\The [user] pours the contents of \the [thing] into \the [src]!</span>")
			for(var/datum/reagent/R in RG.reagents.reagent_list)

				// Hardcode this for now.
				if(R.id == "water")
					steam.start() // HISSSSSS!

				// This could be better.
				if(R.flammable == 1)       // Fuel.
					fuel += R.volume
				else if(R.flammable == -1) // Quench.
					fuel -= R.volume

			RG.reagents.clear_reagents()
			RG.update_icon()
			if(fuel < 0)
				fuel = 0
			if(fuel == 0)
				die()
			return

	if(isflamesource(thing) && lit != FIRE_LIT)
		visible_message("<span class='notice'>\The [user] attempts to light \the [src] with \the [thing]...</span>")
		light()
		return

	if(accept_fuel(thing, user))
		return

	return ..()

/obj/structure/fire_source/proc/process_fuel()

	if(!contents.len)
		return 0

	for(var/obj/item/thing in contents)

		if(istype(thing, /obj/item/weapon/paper) || \
		 istype(thing, /obj/item/weapon/storage/fancy/egg_box ) || \
		 istype(thing, /obj/item/clothing/suit/cardborg) || \
		 istype(thing, /obj/item/clothing/head/cardborg ) || \
		 istype(thing, /obj/item/pizzabox ) || \
		 istype(thing, /obj/item/trash))
			fuel += rand(1,3)
			qdel(thing)
			return 1

		if(istype(thing, /obj/item/log) || istype(thing, /obj/item/weapon/ore/coal))
			fuel += rand(15,25)
			qdel(thing)
			return 1

		if(istype(thing, /obj/item/stack/material))
			var/obj/item/stack/material/wooden_thing = thing
			if(wooden_thing.material.ignition_point <= (T0C+288)) // Ignition point of wood, materials.dm
				fuel += rand(1,3)
				wooden_thing.use(1)
				return 1

		if(istype(thing, /obj/item/weapon/material))
			var/obj/item/weapon/material/wooden_thing = thing
			if(wooden_thing.material.ignition_point <= (T0C+288))
				fuel += rand(3,5)
				qdel(wooden_thing)
				return 1
	return 0

/obj/structure/fire_source/proc/accept_fuel(var/obj/item/thing, var/mob/user)
	var/accepted_fuel

	if(istype(thing, /obj/item/log) || \
	 istype(thing, /obj/item/weapon/ore/coal) || \
	 istype(thing, /obj/item/weapon/paper) || \
	 istype(thing, /obj/item/weapon/storage/fancy/egg_box ) || \
	 istype(thing, /obj/item/clothing/suit/cardborg) || \
	 istype(thing, /obj/item/clothing/head/cardborg ) || \
	 istype(thing, /obj/item/pizzabox ) || \
	 istype(thing, /obj/item/trash))
		accepted_fuel = 1
	else if(istype(thing, /obj/item/stack/material))
		var/obj/item/stack/material/wooden_thing = thing
		if(wooden_thing.material.ignition_point <= (T0C+288))
			accepted_fuel = 1
	else if(istype(thing, /obj/item/weapon/material))
		var/obj/item/weapon/material/wooden_thing = thing
		if(wooden_thing.material.ignition_point <= (T0C+288))
			accepted_fuel =1
	if(accepted_fuel)
		if(lit == FIRE_LIT)
			user.visible_message("<span class='notice'>\The [user] feeds \the [thing] into \the [src].</span>")
		else
			user.visible_message("<span class='notice'>\The [user] places \the [thing] into \the [src].</span>")
		user.unEquip(thing)
		thing.forceMove(src)
		update_icon()
		return 1
	return 0

/obj/structure/fire_source/Destroy()
	processing_objects -= src
	return ..()

/obj/structure/fire_source/process()
	if(lit == FIRE_LIT)
		playsound(src.loc, pick(fire_sounds), 75, 1)
	if(world.time > (last_burn_tick + burn_time))
		last_burn_tick = world.time
	else
		return
	fuel--
	if(fuel <= 0 && !process_fuel())
		die()
		return
	// Burn anyone sitting in the fire.
	if(lit == FIRE_LIT)
		var/turf/T = get_turf(src)
		if(istype(T))
			var/datum/gas_mixture/GM = T.return_air()
			if(!istype(GM) || !GM.gas["oxygen"])
				die()
				return
			for(var/mob/living/M in T.contents)
				burn(M)
			// Copied from space heaters. Heat up the air on our tile, heat will percolate out.
			if(GM && abs(GM.temperature - output_temperature) > 0.1)
				var/transfer_moles = 0.25 * GM.total_moles
				var/datum/gas_mixture/removed = GM.remove(transfer_moles)
				if(removed)
					var/heat_transfer = removed.get_thermal_energy_change(output_temperature)
					if(heat_transfer > 0) removed.add_thermal_energy(heat_transfer)
				GM.merge(removed)

	update_icon()

/obj/structure/fire_source/update_icon()
	overlays.Cut()
	if((fuel || contents.len) && (lit != FIRE_DEAD))
		var/cache_key = "[name]-[icon_state]_full"
		if(!fire_cache[cache_key])
			fire_cache[cache_key] = image(icon, "[icon_state]_full")
		overlays += fire_cache[cache_key]
	var/need_overlay
	switch(lit)
		if(FIRE_LIT)
			if((fuel > 10) || contents.len)
				need_overlay = "[icon_state]_lit"
				set_light(light_range_high, light_power_high, light_colour_high)
			else if(fuel <= 5)
				need_overlay = "[icon_state]_lit_dying"
				set_light(light_range_mid, light_power_low, light_colour_low)
			else if(fuel <= 10)
				need_overlay = "[icon_state]_lit_low"
				set_light(light_range_low, light_power_mid, light_colour_mid)
		if(FIRE_DEAD)
			var/cache_key = "[name]-[icon_state]_burnt"
			if(!fire_cache[cache_key])
				fire_cache[cache_key] = image(icon, "[icon_state]_burnt")
			overlays += fire_cache[cache_key]
			set_light(0)
		else
			set_light(0)

	if(need_overlay)
		var/cache_key = "[name]-[need_overlay]"
		if(!fire_cache[cache_key])
			fire_cache[cache_key] = image(icon, need_overlay)
		overlays += fire_cache[cache_key]

/obj/structure/fire_source/proc/burn(var/mob/living/victim)
	victim << "<span class='danger'>You are burned by \the [src]!</span>"
	victim.IgniteMob()
	victim.apply_damage(rand(5,15), BURN)
