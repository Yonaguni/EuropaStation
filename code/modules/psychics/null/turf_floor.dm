/turf/simulated/floor/set_flooring(var/decl/flooring/newflooring)
	. = ..(newflooring)
	if(flooring && flooring.is_psi_null())
		LAZYADD(psi_null_atoms, src)
	else
		LAZYREMOVE(psi_null_atoms, src)
		UNSETEMPTY(psi_null_atoms)

/turf/simulated/floor/tiled/nullglass
	name = "nullglass floor"
	icon_state = "nullglass"
	initial_flooring = /decl/flooring/tiling/nullglass
