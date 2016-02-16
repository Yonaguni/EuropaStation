/obj/item/jewelry
	name = "jewelry"
	desc = "Some jewelry."
	var/material/material
	var/value_mod = 1

/obj/item/jewelry/proc/get_value()
	return (value_mod * material.sell_amt)

/obj/item/jewelry/examine()
	..()
	var/mob/user = usr
	if(istype(user) && user.has_aspect(ASPECT_APPRAISER) && ((src in usr) || src.Adjacent(usr)))
		user << "<span class='notice'>It looks like it would be worth [get_value()] credits.</span>"

/obj/item/jewelry/New(var/newloc, var/newmaterial)
	if(!newmaterial)
		newmaterial = /material/gold
	material = get_material_by_path(newmaterial)
	..(newloc)

/obj/item/jewelry/initialize()
	..()
	name = "[material.display_name] [initial(name)]"
	update_icon()