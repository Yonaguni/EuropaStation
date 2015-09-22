// WE REALLY NEED A UNIFIED CACHE SYSTEM.
var/global/list/mecha_image_cache = list()
var/global/list/mecha_weapon_overlays = icon_states('icons/mecha/mecha_weapon_overlays.dmi')

proc/get_mech_image(var/cache_key, var/cache_icon, var/image_colour)
	var/use_key = "[cache_key]-[cache_icon]"
	if(image_colour) use_key += "-[image_colour]"
	if(!mecha_image_cache[use_key])
		var/image/I = image(icon = cache_icon, icon_state = cache_key)
		if(image_colour) I.color = image_colour
		mecha_image_cache[use_key] = I
	return mecha_image_cache[use_key]

proc/get_mech_icon(var/hatch_closed, var/obj/item/arms, var/obj/item/legs, var/obj/item/head, var/obj/item/body)
	var/list/all_images = list()
	if(head) all_images += get_mech_image(head.icon_state, head.icon, head.color)
	if(body) all_images += get_mech_image("[body.icon_state][hatch_closed ? "" : "_open"]", body.icon, body.color)
	if(legs) all_images += get_mech_image(legs.icon_state, legs.icon, legs.color)
	if(arms) all_images += get_mech_image(arms.icon_state, arms.icon, arms.color)
	return all_images

/mob/living/mecha/proc/update_icon(var/update_hardpoints = 1)
	overlays -= body_overlays
	body_overlays = get_mech_icon((hatch_closed||body.open_cabin), arms, legs, head, body)
	if(body.open_cabin)
		if(draw_pilot) body_overlays |= draw_pilot
		body_overlays += get_mech_image("[body.icon_state][hatch_closed ? "" : "_open"]_overlay", body.icon, body.color)
	overlays |= body_overlays
	if(update_hardpoints) update_hardpoint_overlays()

/mob/living/mecha/proc/update_hardpoint_overlays()
	overlays -= hardpoint_overlays
	hardpoint_overlays.Cut()
	for(var/hardpoint in hardpoints)
		var/obj/item/hardpoint_object = hardpoints[hardpoint]
		if(!hardpoint_object) continue
		var/use_icon_state = "[hardpoint_object.icon_state]_[hardpoint]"
		if(use_icon_state in mecha_weapon_overlays)
			hardpoint_overlays += get_mech_image(use_icon_state, 'icons/mecha/mecha_weapon_overlays.dmi')
	overlays |= hardpoint_overlays

/mob/living/mecha/proc/update_pilot_overlay()
	overlays -= draw_pilot
	qdel(draw_pilot)
	if(!pilot) return
	if(pilot.icon_state)
		draw_pilot = image(pilot.icon, pilot.icon_state)
	else
		draw_pilot = image(icon)
	draw_pilot.overlays.Cut()
	draw_pilot.pixel_x = body.pilot_offset_x
	draw_pilot.pixel_y = body.pilot_offset_y
	if(!pilot.icon_state) draw_pilot.overlays += pilot.icon
	draw_pilot.overlays += pilot.overlays
