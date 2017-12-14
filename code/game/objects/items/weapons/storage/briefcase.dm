/obj/item/storage/briefcase
	name = "briefcase"
	desc = "It's made of AUTHENTIC faux-leather and has a price-tag still attached. Its owner must be a real professional."
	icon_state = "briefcase"
	item_state = "briefcase"
	flags = CONDUCT
	force = 8.0
	throw_speed = 1
	throw_range = 4
	w_class = 5
	max_w_class = 3
	max_storage_space = DEFAULT_BACKPACK_STORAGE

/obj/item/storage/briefcase/doctor
	name = "doctor's bag"
	desc = "Now with additional pockets for whiskey bottles and duct tape."
	icon_state = "docbag"

/obj/item/storage/briefcase/doctor/full/New()
	..()
	new /obj/item/tape_roll(src)
	new /obj/item/reagent_containers/food/drinks/bottle/whiskey(src)
	new /obj/item/scalpel(src)
	new /obj/item/hemostat(src)
	new /obj/item/retractor(src)
	new /obj/item/cautery(src)
	new /obj/item/circular_saw(src)
	new /obj/item/bonegel(src)
	new /obj/item/suture(src)
	make_exact_fit()
