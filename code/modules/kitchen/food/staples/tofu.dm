/obj/item/weapon/reagent_containers/food/snacks/tofu
	name = "tofu"
	icon = 'icons/obj/kitchen/staples/tofu.dmi'
	icon_state = "tofu"
	desc = "We all love tofu."
	filling_color = "#FFFEE0"
	bitesize = 3

/obj/item/weapon/reagent_containers/food/snacks/tofu/initialize()
	..()
	reagents.add_reagent(REAGENT_ID_NUTRIMENT, 3)

/obj/item/weapon/reagent_containers/food/snacks/tofu/attackby(var/obj/item/thing, var/mob/user)
	if(istype(thing, /obj/item/weapon/reagent_containers/food/snacks/vegetable/hash))

		user.unEquip(thing)
		if(src in user.contents)
			user.unEquip(src)

		var/obj/item/weapon/reagent_containers/food/snacks/tofu/patty/patty = new(get_turf(user))
		var/mob/living/human/H = user
		if(istype(H))
			H.put_in_hands(patty)
		user.visible_message("<span class='notice'>\The [user] shapes \the [thing] and \the [src] into a patty.</span>")
		qdel(thing)
		qdel(src)
		return
	return ..()

/obj/item/weapon/reagent_containers/food/snacks/tofu/patty
	name = "soy patty"
	desc = "Vegetarian!"
	icon_state = "tofupatty"

/obj/item/weapon/reagent_containers/food/snacks/tofu/cookedpatty
	name = "cooked soy patty"
	desc = "Vegetarian!"
	icon_state = "tofupatty"

