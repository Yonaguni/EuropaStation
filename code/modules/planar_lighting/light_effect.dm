/obj/light
	simulated = 0
	mouse_opacity = 0
	plane = -1
	blend_mode = BLEND_ADD
	icon = 'icons/planar_lighting/overlays_small.dmi'
	icon_state = "light_circle"
	mouse_opacity = 0
	alpha = 150

	var/current_power = 1
	var/atom/movable/holder

/obj/light/New(var/newholder)
	holder = newholder
	..(holder.loc)

/obj/light/Destroy()
	if(holder)
		if(holder.light_obj == src)
			holder.light_obj = null
		holder = null
	return .. ()
