/obj/item/gun_component/accessory/chamber/flashlight
	name = "flashlight"
	icon_state = "flashlight"
	weight_mod = 1
	has_alt_interaction = 1

	var/on
	var/brightness_on = 4

/obj/item/gun_component/accessory/chamber/flashlight/do_user_alt_interaction(var/mob/user)
	on = !on
	update_gun_light()
	return 1

/obj/item/gun_component/accessory/chamber/flashlight/Initialize()
	. = ..()
	update_gun_light()

/obj/item/gun_component/accessory/chamber/flashlight/proc/update_gun_light()
	if(on)
		if(holder)
			holder.set_light(brightness_on)
		set_light(brightness_on)
	else
		if(holder)
			holder.kill_light()
		kill_light()
