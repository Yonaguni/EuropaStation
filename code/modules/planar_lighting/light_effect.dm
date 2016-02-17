/obj/light
	simulated = 0
	mouse_opacity = 0
	plane = LIGHT_PLANE
	blend_mode = BLEND_ADD
	icon = 'icons/planar_lighting/lighting_overlays.dmi'
	icon_state = "soft"
	mouse_opacity = 0
	alpha = 150
	pixel_x = -32
	pixel_y = -32
	var/current_power = 1
	var/atom/movable/holder

/obj/light/New(var/newholder)
	holder = newholder
	..(get_turf(holder))
	set_dir(holder.dir)

/obj/light/Destroy()
	if(holder)
		if(holder.light_obj == src)
			holder.light_obj = null
		holder = null
	return .. ()
