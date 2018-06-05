/obj/item/ore
	name = "ore"
	icon_state = "lump"
	icon = 'icons/obj/materials/ore.dmi'
	randpixel = 8
	w_class = 2

/obj/item/ore/Initialize(ml, _mat)
	if(_mat)
		matter = list()
		matter[_mat] = SHEET_MATERIAL_AMOUNT

	for(var/stuff in matter)
		var/material/M = SSmaterials.get_material_by_name(stuff)
		if(M)
			name = M.ore_name
			color = M.icon_colour
			icon_state = M.ore_overlay
			if(M.ore_desc)
				desc = M.ore_desc
			if(icon_state == "dust")
				slot_flags = SLOT_HOLSTER
			break
	..(ml)

// POCKET SAND!
/obj/item/ore/throw_impact(atom/hit_atom)
	..()
	if(icon_state == "dust")
		var/mob/living/carbon/human/H = hit_atom
		if(istype(H) && H.has_eyes() && prob(85))
			H << "<span class='danger'>Some of \the [src] gets in your eyes!</span>"
			H.eye_blind += 5
			H.eye_blurry += 10
			spawn(1)
				if(istype(loc, /turf/)) qdel(src)

// Map definitions.
/obj/item/ore/uranium/New(var/newloc)
	..(newloc, "pitchblende")
/obj/item/ore/iron/New(var/newloc)
	..(newloc, "hematite")
/obj/item/ore/coal/New(var/newloc)
	..(newloc, "graphene")
/obj/item/ore/glass/New(var/newloc)
	..(newloc, "sand")
/obj/item/ore/silver/New(var/newloc)
	..(newloc, "silver")
/obj/item/ore/gold/New(var/newloc)
	..(newloc, "gold")
/obj/item/ore/diamond/New(var/newloc)
	..(newloc, "diamond")
/obj/item/ore/osmium/New(var/newloc)
	..(newloc, "platinum")
/obj/item/ore/hydrogen/New(var/newloc)
	..(newloc, "mhydrogen")
/obj/item/ore/slag/New(var/newloc)
	..(newloc, "waste")
