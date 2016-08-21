/obj/item/device/kit
	icon_state = "modkit"
	icon = 'icons/obj/device.dmi'
	var/new_name = "mech"    //What is the variant called?
	var/new_desc = "A mech." //How is the new mech described?
	var/new_icon = "ripley"  //What base icon will the new mech use?
	var/new_icon_file
	var/uses = 1        // Uses before the kit deletes itself.

/obj/item/device/kit/examine()
	..()
	usr << "It has [uses] [uses>1?"uses":"use"] left."

/obj/item/device/kit/proc/use(var/amt, var/mob/user)
	uses -= amt
	playsound(get_turf(user), 'sound/items/Screwdriver.ogg', 50, 1)
	if(uses<1)
		user.drop_item()
		qdel(src)

// Root hardsuit kit defines.
// Icons for modified hardsuits need to be in the proper .dmis because suit cyclers may cock them up.
/obj/item/device/kit/suit
	name = "voidsuit modification kit"
	desc = "A kit for modifying a voidsuit."
	uses = 2
	var/new_light_overlay
	var/new_mob_icon_file

/obj/item/device/kit/paint
	name = "mecha customisation kit"
	desc = "A kit containing all the needed tools and parts to repaint a mech."

/obj/item/device/kit/paint/examine()
	..()
	usr << "This kit will add the [new_name] decal to a vehicle."
