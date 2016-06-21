/obj/item/weapon/reagent_containers/food/snacks/meat/cutlet
	name = "cutlet"
	desc = "A tasty meat slice."
	icon_state = "cutlet"

/obj/item/weapon/reagent_containers/food/snacks/meat/rawcutlet
	name = "raw cutlet"
	desc = "A thin piece of raw meat."
	icon_state = "rawcutlet"

/obj/item/weapon/reagent_containers/food/snacks/meat/rawmeatball
	name = "raw meatball"
	desc = "A raw meatball."
	icon_state = "rawmeatball"

/obj/item/weapon/reagent_containers/food/snacks/meat/rawmeatball/attack_self(var/mob/user)
	user.unEquip(src)
	var/obj/item/weapon/reagent_containers/food/snacks/meat/rawpatty/patty = new(get_turf(user))
	var/mob/living/human/H = user
	if(istype(H))
		H.put_in_hands(patty)
	user.visible_message("<span class='notice'>\The [user] flattens \the [src] into a patty.</span>")
	qdel(src)
	return

/obj/item/weapon/reagent_containers/food/snacks/meat/rawpatty
	name = "raw patty"
	desc = "A raw burger patty."
	icon_state = "rawpatty"

/obj/item/weapon/reagent_containers/food/snacks/meat/meatball
	name = "meatball"
	desc = "A great meal all round."
	icon_state = "meatball"

/obj/item/weapon/reagent_containers/food/snacks/meat/patty
	name = "patty"
	desc = "A cooked burger patty."
	icon_state = "patty"

/obj/item/weapon/reagent_containers/food/snacks/meat/sausage
	name = "sausage"
	desc = "A piece of mixed, long meat."
	icon_state = "sausage"

/obj/item/weapon/reagent_containers/food/snacks/meat/hotdog
	name = "hotdog"
	desc = "Unrelated to dogs, maybe."
	icon_state = "hotdog"

/obj/item/weapon/reagent_containers/food/snacks/meat/organ
	name = "organ"
	desc = "It's good for you."
	icon = 'icons/obj/surgery.dmi'
	icon_state = "appendix"

/obj/item/weapon/reagent_containers/food/snacks/meat/meatsteak
	name = "meat steak"
	desc = "A piece of hot spicy meat."
	icon_state = "meatstake"

/obj/item/weapon/reagent_containers/food/snacks/meat/mince
	name = "mincemeat"
	desc = "It's completely unidentifiable."
	icon_state = "mincemeat"
	slices_to = /obj/item/weapon/reagent_containers/food/snacks/meat/rawmeatball
	slice_count = 3

// Mincemeat is mysteriously unidentifiable.
/obj/item/weapon/reagent_containers/food/snacks/meat/mince/set_source_mob(new_source_mob)
	source_mob = new_source_mob

/obj/item/weapon/reagent_containers/food/snacks/meat/loaf
	name = "meatloaf"
	desc = "Don't ask what it's made of."
	icon_state = "meatloaf"
