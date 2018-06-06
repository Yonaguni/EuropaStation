/turf/simulated/floor
	name = "plating"
	icon = 'icons/turf/flooring/plating.dmi'
	icon_state = "plating"
	permit_ao = TRUE

	// Damage to flooring.
	var/broken
	var/burnt

	// Plating data.
	var/base_name = "plating"
	var/base_desc = "The naked hull."
	var/base_icon = 'icons/turf/flooring/plating.dmi'
	var/base_icon_state = "plating"

	// Flooring data.
	var/flooring_override
	var/initial_flooring
	var/decl/flooring/flooring
	var/mineral = MATERIAL_STEEL

	thermal_conductivity = 0.040
	heat_capacity = 10000
	var/lava = 0

/turf/simulated/floor/is_plating()
	return !flooring

/turf/simulated/floor/Initialize(ml, floortype)
	. = ..(ml)
	if(floortype)
		initial_flooring = floortype
	if(initial_flooring)
		set_flooring(get_flooring_data(initial_flooring), ml)

/turf/simulated/floor/proc/set_flooring(decl/flooring/newflooring, mapload)
	if(flooring)
		make_plating(defer_icon_update = 1)
	flooring = newflooring
	footstep_type = flooring ? flooring.footstep_type : initial(footstep_type)
	if (mapload)
		queue_icon_update(FALSE)
	else
		update_icon(TRUE)

	levelupdate()

//This proc will set floor_type to null and the update_icon() proc will then change the icon_state of the turf
//This proc auto corrects the grass tiles' siding.
/turf/simulated/floor/proc/make_plating(var/place_product, var/defer_icon_update)

	overlays.Cut()
	if(islist(decals))
		decals.Cut()
		decals = null

	name = base_name
	desc = base_desc
	icon = base_icon
	icon_state = base_icon_state

	if(flooring)
		if(flooring.build_type && place_product)
			new flooring.build_type(src)
		flooring = null

	kill_light()
	broken = null
	burnt = null
	flooring_override = null
	levelupdate()

	if(!defer_icon_update)
		update_icon(1)

/turf/simulated/floor/levelupdate()
	for(var/obj/O in src)
		O.hide(O.hides_under_flooring() && src.flooring)
