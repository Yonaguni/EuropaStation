/obj/item/weapon/reagent_containers/food/snacks/ingredient_mix/bread
	name = "dough"
	desc = "A piece of dough."
	slices_to = /obj/item/weapon/reagent_containers/food/snacks/ingredient_mix/bun
	slice_count = 5

/obj/item/weapon/reagent_containers/food/snacks/ingredient_mix/bread/attack_self(var/mob/user)
	user.unEquip(src)
	var/obj/item/weapon/reagent_containers/food/snacks/raw_pretzel/pretzel = new(get_turf(user))
	var/mob/living/human/H = user
	if(istype(H))
		H.put_in_hands(pretzel)
	user.visible_message("<span class='notice'>\The [user] rolls \the [src] out and weaves it into a pretzel.</span>")
	qdel(src)
	return

/obj/item/weapon/reagent_containers/food/snacks/ingredient_mix/bread/attackby(var/obj/item/thing, var/mob/user)
	if(istype(thing, /obj/item/weapon/material/kitchen/rollingpin))
		user.unEquip(src)
		var/obj/item/weapon/reagent_containers/food/snacks/ingredient_mix/flat/flatbread = new(get_turf(user))
		var/mob/living/human/H = user
		if(istype(H))
			H.put_in_hands(flatbread)
		for(var/obj/item/other_thing in contents)
			other_thing.forceMove(flatbread)
		flatbread.update_from_contents()
		user.visible_message("<span class='notice'>\The [user] rolls \the [src] out flat.</span>")
		qdel(src)
	else
		return ..()
/obj/item/weapon/reagent_containers/food/snacks/ingredient_mix/bun
	name = "small dough"
	desc = "A small piece of dough."

/obj/item/weapon/reagent_containers/food/snacks/ingredient_mix/flat
	name = "flat dough"
	desc = "Some flattened dough."
	icon_state = "flat dough"
	slices_to = /obj/item/weapon/reagent_containers/food/snacks/ingredient_mix/slice
	slice_count = 3

/obj/item/weapon/reagent_containers/food/snacks/ingredient_mix/slice
	name = "dough slice"
	desc = "A building block of an impressive dish."
	icon_state = "doughslice"
