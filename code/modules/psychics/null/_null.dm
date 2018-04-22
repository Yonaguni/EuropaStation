/atom
	var/list/psi_null_atoms

/atom/Entered(atom/movable/Obj,atom/OldLoc)
	. = ..()
	if(LAZYLEN(Obj.psi_null_atoms))
		if(OldLoc)
			REMOVE_PSI_NULL_ATOM(OldLoc, Obj)
		ADD_PSI_NULL_ATOM(src, Obj)

/atom/proc/disrupts_psionics()
	for(var/thing in psi_null_atoms)
		if(thing != src)
			var/atom/A = thing
			if(A.disrupts_psionics())
				return TRUE
	return FALSE

/atom/proc/do_psionics_check(var/stress, var/atom/source)
	withstand_psi_stress(stress, source)
	return disrupts_psionics()

/atom/movable/do_psionics_check(var/stress, var/atom/source)
	var/turf/T = get_turf(src)
	return (T ? T.do_psionics_check(stress, source) : ..(stress, source))

/atom/Destroy()
	if(psi_null_atoms) psi_null_atoms.Cut()
	. = ..()

/atom/proc/withstand_psi_stress(var/stress, var/atom/source)
	if(stress <= 0)
		return 0
	for(var/thing in psi_null_atoms)
		var/atom/movable/AM = thing
		if(istype(AM) && AM != src)
			stress = AM.withstand_psi_stress(stress, source)
			if(stress <= 0)
				break
	return stress
