/obj/machinery/autolathe/robotics
	name = "robotics fabricator"
	base_icon = "robotics"
	icon_state = "robotics"
	lathe_type = LATHE_TYPE_ROBOTICS
	stored_material =  list(MATERIAL_STEEL = 0, MATERIAL_GLASS = 0, MATERIAL_GOLD = 0, MATERIAL_PLASTIC = 0, MATERIAL_OSMIUM = 0)
	storage_capacity = list(MATERIAL_STEEL = 0, MATERIAL_GLASS = 0, MATERIAL_GOLD = 0, MATERIAL_PLASTIC = 0, MATERIAL_OSMIUM = 0)
	build_time = 60

/obj/machinery/autolathe/robotics/RefreshParts()
	..()
	for(var/mat_type in storage_capacity)
		storage_capacity[mat_type] = storage_capacity[mat_type] * 2

/obj/machinery/autolathe/circuit
	name = "circuit imprinter"
	base_icon = "circuit"
	icon_state = "circuit"
	lathe_type = LATHE_TYPE_CIRCUIT
	stored_material =  list(MATERIAL_GLASS = 0, MATERIAL_GOLD = 0)
	storage_capacity = list(MATERIAL_GLASS = 0, MATERIAL_GOLD = 0)
	build_time = 45

/obj/machinery/autolathe/advanced
	name = "device fabricator"
	base_icon = "advlathe"
	icon_state = "advlathe"
	lathe_type = LATHE_TYPE_ADVANCED
	stored_material =  list(MATERIAL_STEEL = 0, MATERIAL_GLASS = 0, MATERIAL_GOLD = 0, MATERIAL_SILVER = 0, MATERIAL_PLASTIC = 0, MATERIAL_OSMIUM = 0, MATERIAL_URANIUM = 0, MATERIAL_DIAMOND = 0)
	storage_capacity = list(MATERIAL_STEEL = 0, MATERIAL_GLASS = 0, MATERIAL_GOLD = 0, MATERIAL_SILVER = 0, MATERIAL_PLASTIC = 0, MATERIAL_OSMIUM = 0, MATERIAL_URANIUM = 0, MATERIAL_DIAMOND = 0)
	build_time = 35

/obj/machinery/autolathe/heavy
	name = "heavy fabricator"
	icon = 'icons/obj/machines/heavy_lathe.dmi'
	base_icon = "h_lathe"
	icon_state = "h_lathe"
	pixel_x = -16
	lathe_type = LATHE_TYPE_HEAVY
	stored_material =  list(MATERIAL_STEEL = 0, MATERIAL_PLASTIC = 0, MATERIAL_OSMIUM = 0)
	storage_capacity = list(MATERIAL_STEEL = 0, MATERIAL_PLASTIC = 0, MATERIAL_OSMIUM = 0)
	build_time = 75

// Heavy fabs need a LOT of materials.
/obj/machinery/autolathe/heavy/RefreshParts()
	..()
	for(var/mat_type in storage_capacity)
		storage_capacity[mat_type] = storage_capacity[mat_type] * 10

/obj/machinery/autolathe/ammo
	name = "ammunition press"
	base_icon = "ammo"
	icon_state = "ammo"
	lathe_type = LATHE_TYPE_AMMUNITION
	stored_material =  list(MATERIAL_STEEL = 0, MATERIAL_OSMIUM = 0, MATERIAL_PLASTIC = 0)
	storage_capacity = list(MATERIAL_STEEL = 0, MATERIAL_OSMIUM = 0, MATERIAL_PLASTIC = 0)
	build_time = 30

/obj/machinery/autolathe/mint
	name = "coin press"
	base_icon = "ammo"
	icon_state = "ammo"
	lathe_type = LATHE_TYPE_CURRENCY
	stored_material =  list(MATERIAL_GOLD = 0, MATERIAL_SILVER = 0, MATERIAL_IRON = 0, MATERIAL_DIAMOND = 0, MATERIAL_URANIUM = 0, MATERIAL_PLATINUM = 0)
	storage_capacity = list(MATERIAL_GOLD = 0, MATERIAL_SILVER = 0, MATERIAL_IRON = 0, MATERIAL_DIAMOND = 0, MATERIAL_URANIUM = 0, MATERIAL_PLATINUM = 0)
	build_time = 10