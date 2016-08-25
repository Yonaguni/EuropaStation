/obj/item/storage/box/bloodpacks
	name = "blood packs bags"
	desc = "This box contains blood packs."
	icon_state = "sterile"
	initialize()
		..()
		new /obj/item/reagent_containers/blood/empty(src)
		new /obj/item/reagent_containers/blood/empty(src)
		new /obj/item/reagent_containers/blood/empty(src)
		new /obj/item/reagent_containers/blood/empty(src)
		new /obj/item/reagent_containers/blood/empty(src)
		new /obj/item/reagent_containers/blood/empty(src)
		new /obj/item/reagent_containers/blood/empty(src)

/obj/item/reagent_containers/blood
	name = "BloodPack"
	desc = "Contains blood used for transfusion."
	icon = 'icons/obj/bloodpack.dmi'
	icon_state = "empty"
	volume = 200

	var/b_type = null

	initialize()
		..()
		if(b_type != null)
			name = "BloodPack [b_type]"
			reagents.add_reagent(REAGENT_ID_BLOOD, 200, list("donor"=null,"viruses"=null,"blood_traces"=null,"b_type"=b_type,"resistances"=null,"trace_chem"=null))
			update_icon()

	on_reagent_change()
		update_icon()

	update_icon()
		var/percent = round((reagents.total_volume / volume) * 100)
		switch(percent)
			if(0 to 9)			icon_state = "empty"
			if(10 to 50) 		icon_state = "half"
			if(51 to INFINITY)	icon_state = "full"

/obj/item/reagent_containers/blood/APlus
	b_type = "A+"

/obj/item/reagent_containers/blood/AMinus
	b_type = "A-"

/obj/item/reagent_containers/blood/BPlus
	b_type = "B+"

/obj/item/reagent_containers/blood/BMinus
	b_type = "B-"

/obj/item/reagent_containers/blood/OPlus
	b_type = "O+"

/obj/item/reagent_containers/blood/OMinus
	b_type = "O-"

/obj/item/reagent_containers/blood/empty
	name = "Empty BloodPack"
	desc = "Seems pretty useless... Maybe if there were a way to fill it?"
	icon_state = "empty"