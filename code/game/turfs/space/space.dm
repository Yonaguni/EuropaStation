/turf/space
	icon = 'icons/turf/space.dmi'
	name = "\proper space"
	icon_state = "0"
	luminosity = 1
	accept_lattice = 1
	open_space = 1
	light_power = 1
	light_range = 2

/turf/space/New()
	if(!istype(src, /turf/space/transit))
		icon_state = "[((x + y) ^ ~(x * y) + z) % 25]"
	update_starlight()
	..()

/turf/space/is_space()
	return 1

// override for space turfs, since they should never hide anything
/turf/space/levelupdate()
	for(var/obj/O in src)
		O.hide(0)

/turf/space/proc/update_starlight()
	if(!config.starlight)
		return
	if(locate(/turf/simulated) in orange(src,1))
		set_light()
	else
		kill_light()

/turf/space/Entered(atom/movable/A as mob|obj)
	..()
	if ((!(A) || src != A.loc))
		return
	inertial_drift(A)
	if(ticker && ticker.mode && (A.x <= TRANSITIONEDGE || A.x >= (world.maxx - TRANSITIONEDGE + 1) || A.y <= TRANSITIONEDGE || A.y >= (world.maxy - TRANSITIONEDGE + 1)))
		A.touch_map_edge()

/turf/space/ChangeTurf(var/turf/N, var/tell_universe=1, var/force_lighting_update = 0)
	return ..(N, tell_universe, 1)
