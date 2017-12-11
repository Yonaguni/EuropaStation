/proc/isflamesource(var/obj/item/A)
	if(A.iswelder())
		var/obj/item/weldingtool/WT = A
		return (WT.isOn())
	else if(istype(A, /obj/item/flame))
		var/obj/item/flame/F = A
		return (F.lit)
	else if(istype(A, /obj/item/assembly/igniter))
		return 1
	return 0

//For anything that can light stuff on fire
/obj/item/flame
	attack_verb = list("burnt", "singed")
	w_class = 1
	light_range = 3
	light_power = CANDLE_LUM
	light_color = "#E09D37"

	var/lit = 0
	var/fuel = 5
	var/trash
	var/one_use = TRUE

/obj/item/flame/Destroy()
	processing_objects.Remove(src)
	. = ..()

/obj/item/flame/proc/use_fuel()
	fuel--
	if(fuel <= 0)
		burn_out()
	else
		update_icon()

/obj/item/flame/process()

	if(!lit || !loc) return

	if(isliving(loc))
		var/mob/living/M = loc
		M.IgniteMob()

	use_fuel()

	var/turf/location = get_turf(src)
	if(istype(location))
		location.hotspot_expose(700, 5)
		var/depth = location.get_fluid_depth()
		if((istype(loc, /mob) && depth >= FLUID_SHALLOW) || \
		 (istype(loc, /turf) && depth >= 3) || \
		 depth >= FLUID_OVER_MOB_HEAD)
			extinguish()

/obj/item/flame/attack_self(var/mob/user)
	if(lit)
		extinguish(user)
	return ..()

/obj/item/flame/proc/burn_out()
	if(ispath(trash))
		new trash(get_turf(src))
	var/mob/M = loc
	if(istype(M))
		M.drop_from_inventory(src)
	qdel(src)

/obj/item/flame/dropped(var/mob/user)
	. = ..()
	if(lit)
		var/turf/location = src.loc
		if(istype(location))
			location.hotspot_expose(700, 5)
			var/depth = location.get_fluid_depth()
			if((istype(loc, /mob) && depth >= FLUID_SHALLOW) || \
			 (istype(loc, /turf) && depth >= 3) || \
			 depth >= FLUID_OVER_MOB_HEAD)
				extinguish()

/obj/item/flame/attackby(var/obj/item/W, var/mob/user)
	if(isflamesource(W))
		light()
	else
		return ..()

/obj/item/flame/proc/light(var/flavour_text)
	if(!lit && fuel)
		var/turf/T = get_turf(src)
		if(istype(T) && T.get_fluid_depth() >= FLUID_SHALLOW)
			to_chat(usr, "<span class='warning'>You cannot light \the [src] in such a wet environment.</span>")
			return
		lit = TRUE
		if(!flavour_text) flavour_text = "\The [usr] lights \the [src]."
		flavour_text = "<span class='notice'>[flavour_text]</span>"
		visible_message(flavour_text)
		set_light()
		processing_objects.Add(src)
		update_icon()

/obj/item/flame/proc/extinguish(var/mob/user)
	if(lit)
		if(one_use)
			burn_out()
		else
			lit = FALSE
			kill_light()
			update_icon()
