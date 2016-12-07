/obj/item/storage/box/colonist_seeds
	name = "box of seeds"
	desc = "A grubby cardboard box with 'seeds' written on it in marker."

/obj/item/storage/box/colonist_seeds/New()
	..()
	new /obj/item/seeds/potatoseed(src)
	new /obj/item/seeds/potatoseed(src)
	new /obj/item/seeds/wheatseed(src)
	new /obj/item/seeds/wheatseed(src)
	new /obj/item/seeds/tomatoseed(src)
	new /obj/item/seeds/tomatoseed(src)
	new /obj/item/seeds/random(src)
	new /obj/item/seeds/random(src)
	make_exact_fit()
