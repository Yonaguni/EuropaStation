/obj/item/gun_component/accessory/barrel/lens
	name = "multiphase lens"
	has_alt_interaction = TRUE

	var/selected_type = 0
	var/list/additional_types
	var/replacing_caliber

/obj/item/gun_component/accessory/barrel/lens/New()
	var/list/caliber_datums = list()
	for(var/caliber_type in additional_types)
		caliber_datums += get_caliber_from_path(caliber_type)
	additional_types = caliber_datums
	..()

/obj/item/gun_component/accessory/barrel/lens/apply_mod(var/obj/item/gun/composite/gun)
	..()
	replacing_caliber = get_caliber_from_path(initial(holder.barrel.design_caliber))

/obj/item/gun_component/accessory/barrel/lens/removed_from(var/obj/item/gun, var/mob/user)
	holder.barrel.design_caliber = replacing_caliber
	replacing_caliber = null
	. = ..()

/obj/item/gun_component/accessory/barrel/lens/do_user_alt_interaction(var/mob/user)

	if(!LAZYLEN(additional_types))
		return 0

	if(selected_type == LAZYLEN(additional_types))
		selected_type = 0
	else
		selected_type++

	if(selected_type == 0 && (replacing_caliber in additional_types))
		selected_type++

	if(selected_type == 0)
		holder.barrel.design_caliber = replacing_caliber
	else
		holder.barrel.design_caliber = additional_types[selected_type]

	to_chat(user, "<span class='notice'>You switch \the [holder] to its [holder.barrel.design_caliber.mode_name] setting.</span>")
	return 1

/obj/item/gun_component/accessory/barrel/lens/stun_lethal
	additional_types = list(
		/decl/weapon_caliber/laser/shock,
		/decl/weapon_caliber/laser
		)