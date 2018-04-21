/obj/item/material/set_material(var/new_material)
	. = ..()
	var/atom/holder = loc
	if(material && material.is_psi_null())
		LAZYADD(psi_null_atoms, src)
		if(istype(holder))
			ADD_PSI_NULL_ATOM(holder, src)
	else
		LAZYREMOVE(psi_null_atoms, src)
		if(istype(holder))
			REMOVE_PSI_NULL_ATOM(holder, src)
		UNSETEMPTY(psi_null_atoms)


/obj/item/material/withstand_psi_stress(var/stress)
	. = ..(stress)
	if(health >= 0 && . > 0 && (src in psi_null_atoms))
		health -= .
		. = max(0, -(health))
		check_health(consumed = TRUE)
