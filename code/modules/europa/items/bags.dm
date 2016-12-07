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
	new /obj/item/FixOVein(src)
	make_exact_fit()
