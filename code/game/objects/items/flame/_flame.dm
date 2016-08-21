/proc/isflamesource(A)
	if(istype(A, /obj/item/weldingtool))
		var/obj/item/weldingtool/WT = A
		return (WT.isOn())
	else if(istype(A, /obj/item/flame))
		var/obj/item/flame/F = A
		return (F.lit)
	return 0

//For anything that can light stuff on fire
/obj/item/flame
	var/lit = 0
	var/waterproof

/obj/item/flame/proc/light()
	if(lit)
		return 0
	if(!waterproof)
		var/turf/T = get_turf(src)
		if(T && T.is_flooded())
			usr << "<span class='warning'>It's far too wet to light \the [src]!</span>"
			return 0
	lit = 1
	processing_objects |= src
	update_icon()
	return 1

/obj/item/flame/proc/die()
	if(!lit)
		return 0
	processing_objects -= src
	lit = 0
	update_icon()
	return 1

/obj/item/flame/process()
	if(lit)
		ignite_location()
		var/turf/location = get_turf(src)
		if(istype(location))
			if(location.check_fluid_depth(1))
				water_act(location.get_fluid_depth())
		update_icon()
	return lit

