/obj/item/gun_component/barrel

	name = "barrel"
	component_type = COMPONENT_BARREL
	projectile_type = GUN_TYPE_BALLISTIC
	weapon_type = null
	icon = 'icons/obj/gun_components/barrel.dmi'

	var/decl/weapon_caliber/design_caliber
	var/variable_projectile = 1
	var/override_name
	var/shortened_icon = null
	recoil_mod = 1

/obj/item/gun_component/barrel/proc/modify_shot(var/obj/item/projectile/proj)
	return proj

/obj/item/gun_component/barrel/New(var/newloc, var/weapontype, var/componenttype, var/use_model, var/supplied_caliber)
	if(supplied_caliber)
		design_caliber = supplied_caliber
	design_caliber = get_caliber_from_path(design_caliber)
	..(newloc, weapontype, componenttype, use_model)

/obj/item/gun_component/barrel/update_strings()
	..()
	if(model && model.produced_by.manufacturer_short != "unbranded")
		name = "[model.produced_by.manufacturer_short] [override_name ? override_name : design_caliber.name] [weapon_type] [initial(name)]"
	else
		name = "[override_name ? override_name : design_caliber.name] [weapon_type] [initial(name)]"

/obj/item/gun_component/barrel/proc/get_projectile_type()
	return

/obj/item/gun_component/barrel/attackby(var/obj/item/thing, var/mob/user)
	if(istype(thing, /obj/item/circular_saw) || istype(thing, /obj/item/melee/energy) || thing.iswirecutter())
		if(shortened_icon && icon_state != shortened_icon)
			to_chat(user, "<span class='notice'>You begin to shorten \the [src].</span>")
			if(do_after(user, 30))
				to_chat(user, "<span class='warning'>You shorten \the [src]!</span>")
				icon_state = shortened_icon
				w_class = max(1,w_class-1)
				accepts_accessories = 0
				recoil_mod++
				accuracy_mod--
				weight_mod--
				if(initial(override_name))
					override_name = "shortened [initial(override_name)]"
				else
					override_name = "shortened [design_caliber.name]"
				update_strings()
				return
		else
			to_chat(user, "<span class='warning'>You cannot shorten \the [src] any further!</span>")
	..()