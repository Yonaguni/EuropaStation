// Huge, huge, immense thanks to Nandrew of the BYOND forums for posting their demo of the new
// lighting methods, upon which this is being built! Thread can be found at the following address:
// http://www.byond.com/forum/?post=2033630 (hopefully). ~Zuhayr

/image/master_plane
	blend_mode = BLEND_MULTIPLY
	appearance_flags = NO_CLIENT_COLOR | PLANE_MASTER
	color = list(null,null,null,"#0000","#000f")  // Completely black.
	mouse_opacity = 0
	plane = 0

/image/darkness_plane
	blend_mode = BLEND_ADD
	mouse_opacity = 0
	plane = -1 // Just below the master plane.
	icon = 'icons/planar_lighting/over_dark.dmi'
	alpha = 20

/image/darkness_plane/New()
	..()
	// Scale it to cover the entire screen.
	var/matrix/M = matrix()
	M.Scale(world.view*2.2)
	transform = M
