/obj/item/weapon/reagent_containers/food/snacks/vegetable
	icon = 'icons/obj/kitchen/staples/grown.dmi'
	var/base_grown = "potato"

/obj/item/weapon/reagent_containers/food/snacks/vegetable/initialize()
	..()
	reagents.add_reagent(REAGENT_ID_NUTRIMENT, 4)

/obj/item/weapon/reagent_containers/food/snacks/vegetable/rawsticks
	name = "sticks"
	desc = "Raw fries, not very tasty."
	icon_state = "rawsticks"

/obj/item/weapon/reagent_containers/food/snacks/vegetable/fries
	name = "fries"
	desc = "Chips, if you're Space British."
	icon_state = "fries"

/obj/item/weapon/reagent_containers/food/snacks/vegetable/hash
	name = "diced"
	desc = "Diced-up vegetables."
	icon_state = "hash"

/obj/item/weapon/reagent_containers/food/snacks/vegetable/hash/attackby(var/obj/item/thing, var/mob/user)
	if(istype(thing, /obj/item/weapon/reagent_containers/food/snacks/tofu))

		user.unEquip(thing)
		if(src in user.contents)
			user.unEquip(src)

		var/obj/item/weapon/reagent_containers/food/snacks/tofu/patty/patty = new(get_turf(user))
		var/mob/living/carbon/human/H = user
		if(istype(H))
			H.put_in_hands(patty)
		user.visible_message("<span class='notice'>\The [user] shapes \the [src] and \the [thing] into a patty.</span>")
		qdel(thing)
		qdel(src)
		return
	return ..()

/obj/item/weapon/reagent_containers/food/snacks/vegetable/boiled
	name = "boiled"
	desc = "Boiled vegetables."
	icon_state = "boiled"

/obj/item/weapon/reagent_containers/food/snacks/vegetable/friedhash
	name = "hashbrown"
	desc = "A fried vegetable cake made from "
	icon_state = "rawsticks"
