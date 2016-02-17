/obj/light
	simulated = 0
	mouse_opacity = 0
	plane = LIGHT_PLANE
	blend_mode = BLEND_ADD
	icon = 'icons/planar_lighting/lighting_overlays.dmi'
	icon_state = "soft"
	pixel_x = -32
	pixel_y = -32
	alpha = 0
	invisibility = (SEE_INVISIBLE_NOLIGHTING-1)
	var/current_power = 1
	var/atom/movable/holder

/obj/light/New(var/newholder)
	holder = newholder
	..()

/obj/light/Destroy()
	if(holder)
		moved_event.unregister(holder, src)
		destroyed_event.unregister(holder, src)
		if(holder.light_obj == src)
			holder.light_obj = null
		holder = null
	return .. ()

/obj/light/initialize()
	if(!istype(holder, /atom/movable))
		world << "DEBUG: [src] has holder [holder], is [holder.type]."
		qdel(src)
		return
	follow_holder()
	set_dir(holder.dir)
	moved_event.register(holder, src, /obj/light/proc/follow_holder)
	destroyed_event.register(holder, src, /obj/light/proc/destroy_self)

/obj/light/proc/destroy_self()
	qdel(src)

/obj/light/proc/follow_holder()
	if(istype(holder.loc, /mob))
		loc = get_turf(holder)
		set_dir(holder.loc)
	else
		loc = holder.loc
		set_dir(holder.dir)
