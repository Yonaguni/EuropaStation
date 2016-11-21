/obj/item/ore
	name = "rock"
	icon = 'icons/obj/mining.dmi'
	icon_state = "ore2"
	randpixel = 8
	w_class = 2
	var/material

/obj/item/ore/uranium
	name = "pitchblende"
	icon_state = "ore_uranium"

	material = "uranium"

/obj/item/ore/iron
	name = "hematite"
	icon_state = "ore_iron"

	material = "hematite"

/obj/item/ore/coal
	name = "raw carbon"
	icon_state = "ore_coal"

	material = "carbon"

/obj/item/ore/glass
	name = "sand"
	icon_state = "ore_glass"

	material = "sand"
	slot_flags = SLOT_HOLSTER

// POCKET SAND!
/obj/item/ore/glass/throw_impact(atom/hit_atom)
	..()
	var/mob/living/carbon/human/H = hit_atom
	if(istype(H) && H.has_eyes() && prob(85))
		H << "<span class='danger'>Some of \the [src] gets in your eyes!</span>"
		H.eye_blind += 5
		H.eye_blurry += 10
		spawn(1)
			if(istype(loc, /turf/)) qdel(src)

/obj/item/ore/silver
	name = "native silver ore"
	icon_state = "ore_silver"

	material = "silver"

/obj/item/ore/gold
	name = "native gold ore"
	icon_state = "ore_gold"

	material = "gold"

/obj/item/ore/diamond
	name = "diamonds"
	icon_state = "ore_diamond"

	material = "diamond"

/obj/item/ore/osmium
	name = "raw platinum"
	icon_state = "ore_platinum"
	material = "platinum"

/obj/item/ore/hydrogen
	name = "raw hydrogen"
	icon_state = "ore_hydrogen"
	material = "mhydrogen"

/obj/item/ore/slag
	name = "Slag"
	desc = "Someone screwed up..."
	icon_state = "slag"
	material = null
