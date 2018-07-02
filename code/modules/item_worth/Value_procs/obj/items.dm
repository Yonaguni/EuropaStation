/obj/item/reagent_containers/Value()
	. = ..()
	if(reagents)
		for(var/a in reagents.volumes)
			var/datum/reagent/reg = SSchemistry.get_reagent(a)
			. += reg.value * reagents.volumes[a]
	. = round(.)

/obj/item/stack/Value(var/base)
	return base * amount

/obj/item/stack/material/Value()
	if(!material)
		return ..()
	return material.value * amount

/obj/item/ore/Value()
	var/total = 0
	for(var/_mat in matter)
		var/material/mat = SSmaterials.get_material(_mat)
		if(istype(mat))
			total += (mat.value * matter[_mat])
	return total

/obj/item/material/Value()
	return material.value * worth_multiplier

/obj/item/spacecash/Value()
	return worth