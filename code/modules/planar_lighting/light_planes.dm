/obj/render_plane/master_plane
	name = "master lighting plane"
	blend_mode = BLEND_MULTIPLY
	icon = null
	appearance_flags = NO_CLIENT_COLOR | PLANE_MASTER | RESET_TRANSFORM | RESET_COLOR | RESET_ALPHA
	color = list(null,null,null,"#0000","#000f")  // Completely black.
//	mouse_opacity = 0
	screen_loc = "CENTER"
	plane = MASTER_PLANE

/obj/render_plane/dark_plane
	name = "darkness lighting plane"
	blend_mode = BLEND_ADD
	mouse_opacity = 0
	plane = DARK_PLANE // Just below the master plane.
	icon = 'icons/planar_lighting/over_dark.dmi'
//	color = list(null,null,null,"#0000","#000f")
	alpha = 25
	appearance_flags = RESET_TRANSFORM | RESET_COLOR | RESET_ALPHA
	screen_loc = "CENTER"
	var/first_state_change = 1 // Used by global lighting.

/obj/render_plane/gui_plane
	name = "gui plane"
	blend_mode = BLEND_OVERLAY
	plane = GUI_PLANE
//	icon = 'icons/planar_lighting/over_dark.dmi'
//	color = list(null,null,null,"#0000","#000f")
//	alpha = 25
	appearance_flags = PLANE_MASTER | RESET_TRANSFORM | RESET_COLOR | RESET_ALPHA
	screen_loc = "CENTER"
	var/first_state_change = 1 // Used by global lighting.


/obj/render_plane/New(mob/M)
	..()
	if(istype(M) && M.client)
		M.client.screen |= src
/*	var/matrix/M = matrix()
	M.Scale(world.view*2.2)
	transform = M
*/
/obj/render_plane/dark_plane/New(mob/M)
	..(M)
	var/matrix/Mat = matrix()
	Mat.Scale(world.view*2.2)
	transform = Mat

/obj/render_plane/darkmask
	blend_mode = BLEND_SUBTRACT
	mouse_opacity = 0
	plane = DARK_PLANE
	icon = 'icons/planar_lighting/over_dark.dmi'
	appearance_flags = KEEP_TOGETHER
