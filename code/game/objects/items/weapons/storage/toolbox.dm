/obj/item/storage/toolbox
	name = "toolbox"
	desc = "Danger. Very robust."
	icon = 'icons/obj/storage.dmi'
	icon_state = "red"
	item_state = "toolbox_red"
	flags = CONDUCT
	force = 5
	throwforce = 10
	throw_speed = 1
	throw_range = 7
	w_class = 4
	max_w_class = 3
	max_storage_space = DEFAULT_LARGEBOX_STORAGE //enough to hold all starting contents

	attack_verb = list("robusted")

/obj/item/storage/toolbox/emergency
	name = "emergency toolbox"
	icon_state = "red"
	item_state = "toolbox_red"

/obj/item/storage/toolbox/emergency/New()
	..()
	new /obj/item/crowbar/red(src)
	new /obj/item/extinguisher/mini(src)
	if(prob(50))
		new /obj/item/flashlight(src)
	else
		new /obj/item/flashlight/flare(src)
	new /obj/item/radio(src)

/obj/item/storage/toolbox/mechanical
	name = "mechanical toolbox"
	icon_state = "blue"
	item_state = "toolbox_blue"

/obj/item/storage/toolbox/mechanical/New()
	..()
	new /obj/item/screwdriver(src)
	new /obj/item/wrench(src)
	new /obj/item/weldingtool(src)
	new /obj/item/crowbar(src)
	new /obj/item/analyzer(src)
	new /obj/item/wirecutters(src)

/obj/item/storage/toolbox/electrical
	name = "electrical toolbox"
	icon_state = "yellow"
	item_state = "toolbox_yellow"

/obj/item/storage/toolbox/electrical/New()
	..()
	new /obj/item/screwdriver(src)
	new /obj/item/wirecutters(src)
	new /obj/item/t_scanner(src)
	new /obj/item/crowbar(src)
	new /obj/item/stack/cable_coil/random(src,30)
	new /obj/item/stack/cable_coil/random(src,30)
	if(prob(5))
		new /obj/item/clothing/gloves/insulated(src)
	else
		new /obj/item/stack/cable_coil/random(src,30)

/obj/item/storage/toolbox/syndicate
	name = "black and red toolbox"
	icon_state = "syndicate"
	item_state = "toolbox_syndi"

	force = 7.0

/obj/item/storage/toolbox/syndicate/New()
	..()
	new /obj/item/clothing/gloves/insulated(src)
	new /obj/item/screwdriver(src)
	new /obj/item/wrench(src)
	new /obj/item/weldingtool(src)
	new /obj/item/crowbar(src)
	new /obj/item/wirecutters(src)
	new /obj/item/multitool(src)

