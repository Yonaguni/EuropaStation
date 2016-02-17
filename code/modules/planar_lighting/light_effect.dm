/obj/light
	simulated = 0
	mouse_opacity = 0
	plane = LIGHT_PLANE
	blend_mode = BLEND_ADD
	icon = 'icons/planar_lighting/lighting_overlays.dmi'
	icon_state = "soft"
	pixel_x = -32
	pixel_y = -32
	var/current_power = 1
	var/atom/movable/holder

/obj/light/New(var/newholder)
	holder = newholder
	..(get_turf(holder))
	set_dir(holder.dir)
	moved_event.register(holder, src, /obj/light/proc/follow_holder)
	destroyed_event.register(holder, src, /obj/light/proc/destroy_self)

/obj/light/proc/destroy_self()
	qdel(src)

/obj/light/proc/follow_holder()
	sleep(-1)
	if(istype(holder.loc, /mob))
		loc = get_turf(holder)
		set_dir(holder.loc)
	else
		loc = holder.loc
		set_dir(holder.dir)

/obj/light/Destroy()
	if(holder)
		moved_event.unregister(holder, src)
		destroyed_event.unregister(holder, src)
		if(holder.light_obj == src)
			holder.light_obj = null
		holder = null
	return .. ()
