/obj/effect/gas_overlay
	name = ""
	desc = ""
	mouse_opacity = 2
	icon_state = ""
	icon = 'icons/effects/xgm_overlays.dmi'
	alpha = 0
	layer = GAS_OVERLAY_LAYER
	mouse_opacity = 0
	simulated = 0
	anchored = 0
	density = 0

var/image/ocean_overlay_img
/obj/effect/gas_overlay/ocean
	alpha = GAS_MAX_ALPHA
	color = "#66D1FF"

/obj/effect/gas_overlay/ocean/New()
	..()
	if(!ocean_overlay_img) ocean_overlay_img = image('icons/effects/xgm_overlays.dmi', "ocean")
	overlays |= ocean_overlay_img
