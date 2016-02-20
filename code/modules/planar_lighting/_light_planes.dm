#define MASTER_PLANE 0
#define DARK_PLANE -10
#define GUI_PLANE    10

// Huge, huge, immense thanks to Nandrew of the BYOND forums for posting their demo of the new
// lighting methods, upon which this is being built! Thread can be found at the following address:
// http://www.byond.com/forum/?post=2033630 (hopefully). ~Zuhayr

/obj/master_plane
	name = "master lighting plane"
	blend_mode = BLEND_MULTIPLY
	appearance_flags = NO_CLIENT_COLOR | PLANE_MASTER
	color = list(null,null,null,"#0000","#000f")  // Completely black.
	mouse_opacity = 0
	plane = MASTER_PLANE
	screen_loc = "CENTER,CENTER"

/obj/dark_plane
	name = "darkness lighting plane"
	blend_mode = BLEND_ADD
	mouse_opacity = 0
	plane = DARK_PLANE // Just below the master plane.
	icon = 'icons/planar_lighting/over_dark.dmi'
	alpha = 30
	screen_loc = "CENTER,CENTER"
	var/first_state_change = 1 // Used by global lighting.

/obj/dark_plane/New()
	..()
	var/matrix/M = matrix()
	M.Scale(world.view*2.2)
	transform = M
