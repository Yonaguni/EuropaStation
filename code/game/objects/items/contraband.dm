//Let's get some REAL contraband stuff in here. Because come on, getting brigged for LIPSTICK is no fun.
//Illicit drugs~
/obj/item/reagent_containers/glass/beaker/vial/random
	flags = 0
	var/list/random_volumes = list(list(REAGENT_WATER = 15) = 1, list(REAGENT_CLEANER = 15) = 1)

/obj/item/reagent_containers/glass/beaker/vial/random/toxin
	random_volumes = list(
		list(REAGENT_LSD = 10, REAGENT_GLINT = 20)	= 3,
		list(REAGENT_CARPOTOXIN = 15)							= 2,
		list(REAGENT_IMPEDREZENE = 15)						= 2,
		list(REAGENT_BYPHODINE = 10)						= 1)

/obj/item/reagent_containers/glass/beaker/vial/random/New()
	..()
	if(is_open_container())
		flags ^= OPENCONTAINER

	var/list/picked_reagents = pickweight(random_volumes)
	for(var/reagent in picked_reagents)
		reagents.add_reagent(reagent, picked_reagents[reagent])

	var/list/names = new
	for(var/rid in reagents.volumes)
		var/datum/reagent/R = SSchemistry.get_reagent(rid)
		names += R.name

	desc = "Contains [english_list(names)]."
	update_icon()
