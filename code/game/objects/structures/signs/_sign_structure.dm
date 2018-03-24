/obj/structure/sign
	icon = 'icons/obj/signs.dmi'
	desc = "It's a sign! A sign!"
	anchored = 1
	opacity = 0
	density = 0
	w_class = 3
	layer = MOB_LAYER - 0.1

	var/default_pixel_x = 0
	var/default_pixel_y = 0
	var/dismantle_type = /obj/item/sign
	var/copy_donor = TRUE

/obj/structure/sign/New(var/newloc, var/obj/item/sign/donor)
	if(istype(donor) && copy_donor)
		name = donor.name
		desc = donor.desc
		icon = donor.icon
		icon_state = donor.icon_state
	..(newloc)

/obj/structure/sign/ex_act(severity)
	if(severity == 1)
		qdel(src)
	else
		dismount()

/obj/structure/sign/attackby(var/obj/item/tool as obj, var/mob/user)
	if(tool.isscrewdriver())
		to_chat(user, "<span class='notice'>You unfasten \the [src] with \the [tool].</span>")
		dismount()
	else ..()

/obj/structure/sign/proc/dismount()
	var/obj/item/sign/S = new dismantle_type(get_turf(src))
	if(copy_donor)
		S.name = name
		S.desc = desc
		S.icon = icon
		S.icon_state = icon_state
	qdel(src)
	return S
