/obj/item/material/set_material(var/new_material)
	. = ..()
	var/atom/holder = loc
	if(disrupts_psionics())
		LAZYADD(psi_null_atoms, src)
		if(istype(holder))
			ADD_PSI_NULL_ATOM(holder, src)
	else
		LAZYREMOVE(psi_null_atoms, src)
		if(istype(holder))
			REMOVE_PSI_NULL_ATOM(holder, src)
		UNSETEMPTY(psi_null_atoms)

/obj/item/material/disrupts_psionics()
	return (material && material.is_psi_null())

/obj/item/material/withstand_psi_stress(var/stress, var/atom/source)
	. = ..(stress, source)
	if(health >= 0 && . > 0 && disrupts_psionics())
		health -= .
		. = max(0, -(health))
		check_health(consumed = TRUE)

/obj/item/material/shard/nullglass/New(var/newloc)
	..(newloc, "nullglass")