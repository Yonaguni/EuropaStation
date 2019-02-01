/obj/item/clothing/ears/earring
	name = "stud earrings"
	desc = "An earring of some kind."
	icon_state = "ear_stud"
	gender = PLURAL
	var/material/material = MATERIAL_GLASS

/obj/item/clothing/ears/earring/New(var/newloc, var/new_material)
	..(newloc)
	if(!new_material)
		if(ispath(material))
			new_material = material
		else
			new_material = MATERIAL_GLASS
	material = SSmaterials.get_material_by_name(new_material)
	if(!istype(material))
		qdel(src)
		return
	name = "[material.display_name] [initial(name)]"
	desc = "A set of earrings made from [material.display_name]."
	color = material.icon_colour


/obj/item/clothing/ears/earring/silver
	material = MATERIAL_SILVER

/obj/item/clothing/ears/earring/gold
	material = MATERIAL_GOLD

/obj/item/clothing/ears/earring/dangle
	name = "earrings"
	icon_state = "ear_dangle"

/obj/item/clothing/ears/earring/dangle/silver
	material = MATERIAL_SILVER

/obj/item/clothing/ears/earring/dangle/gold
	material = MATERIAL_GOLD
