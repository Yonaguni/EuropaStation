#define ADD_PSI_NULL_ATOM(adding_to, adding) \
	var/atom/psi_holder = adding_to; \
	var/atom/psi_atom = adding; \
	while(istype(psi_holder)) { \
		LAZYADD(psi_holder.psi_null_atoms, psi_atom); \
		psi_atom = psi_holder; \
		psi_holder = psi_holder.loc; \
	}

#define REMOVE_PSI_NULL_ATOM(removing_from, removing) \
	var/atom/psi_holder = removing_from; \
	var/atom/psi_atom = removing; \
	while(istype(psi_holder)) { \
		LAZYREMOVE(psi_holder.psi_null_atoms, psi_atom); \
		UNSETEMPTY(psi_holder.psi_null_atoms); \
		psi_atom = psi_holder; \
		psi_holder = psi_holder.loc; \
	}

/atom
	var/list/psi_null_atoms

/atom/Entered(atom/movable/Obj,atom/OldLoc)
	. = ..()
	if(Obj.is_psi_null())
		if(OldLoc)
			REMOVE_PSI_NULL_ATOM(OldLoc, Obj)
		ADD_PSI_NULL_ATOM(src, Obj)

/atom/proc/is_psi_null(var/stress)
	withstand_psi_stress(stress)
	return LAZYLEN(psi_null_atoms)

/atom/movable/is_psi_null(var/stress)
	var/turf/T = get_turf(src)
	return T ? T.is_psi_null(stress) : ..(stress)

/atom/Destroy()
	if(psi_null_atoms) psi_null_atoms.Cut()
	. = ..()

/atom/proc/withstand_psi_stress(var/stress)
	if(stress <= 0)
		return 0
	for(var/thing in psi_null_atoms)
		var/atom/movable/AM = thing
		if(istype(AM) && AM != src)
			stress = AM.withstand_psi_stress(stress)
			if(stress <= 0)
				break
	return stress