/obj/machinery/autolathe/robotics
	name = "robotics fabricator"
	base_icon = "robotics"
	icon_state = "robotics"
	lathe_type = LATHE_TYPE_ROBOTICS
	stored_material =  list("steel" = 0, "glass" = 0, "gold" = 0, "plastic" = 0, "osmium" = 0)
	storage_capacity = list("steel" = 0, "glass" = 0, "gold" = 0, "plastic" = 0, "osmium" = 0)

/obj/machinery/autolathe/robotics/RefreshParts()
	..()
	for(var/mat_type in storage_capacity)
		storage_capacity[mat_type] = storage_capacity[mat_type] * 2

/obj/machinery/autolathe/circuit
	name = "circuit imprinter"
	base_icon = "circuit"
	icon_state = "circuit"
	lathe_type = LATHE_TYPE_CIRCUIT
	stored_material =  list("glass" = 0, "gold" = 0)
	storage_capacity = list("glass" = 0, "gold" = 0)

/obj/machinery/autolathe/advanced
	name = "device fabricator"
	base_icon = "advlathe"
	icon_state = "advlathe"
	lathe_type = LATHE_TYPE_ADVANCED
	stored_material =  list("steel" = 0, "glass" = 0, "gold" = 0, "silver" = 0, "plastic" = 0, "osmium" = 0, "uranium" = 0, "diamond" = 0)
	storage_capacity = list("steel" = 0, "glass" = 0, "gold" = 0, "silver" = 0, "plastic" = 0, "osmium" = 0, "uranium" = 0, "diamond" = 0)

/obj/machinery/autolathe/heavy
	name = "heavy fabricator"
	icon = 'icons/obj/machines/heavy_lathe.dmi'
	base_icon = "h_lathe"
	icon_state = "h_lathe"
	pixel_x = -16
	lathe_type = LATHE_TYPE_HEAVY
	stored_material =  list("steel" = 0, "plastic" = 0, "osmium" = 0)
	storage_capacity = list("steel" = 0, "plastic" = 0, "osmium" = 0)

// Heavy fabs need a LOT of materials.
/obj/machinery/autolathe/heavy/RefreshParts()
	..()
	for(var/mat_type in storage_capacity)
		storage_capacity[mat_type] = storage_capacity[mat_type] * 10
