/obj/turbolift_map_holder/yonaguni
	icon = 'icons/obj/turbolift_preview_2x2.dmi'
	depth = 2
	lift_size_x = 3
	lift_size_y = 3

/obj/turbolift_map_holder/yonaguni/sec
	name = "Exodus turbolift map placeholder - Securiy"
	dir = EAST

	areas_to_use = list(
		/area/turbolift/security_maintenance,
		/area/turbolift/security_station
		)

/obj/turbolift_map_holder/yonaguni/research
	name = "Exodus turbolift map placeholder - Research"
	dir = WEST

	areas_to_use = list(
		/area/turbolift/research_maintenance,
		/area/turbolift/research_station
		)

/obj/turbolift_map_holder/yonaguni/engineering
	name = "Exodus turbolift map placeholder - Engineering"
	icon = 'icons/obj/turbolift_preview_3x3.dmi'
	dir = EAST
	lift_size_x = 4
	lift_size_y = 4

	areas_to_use = list(
		/area/turbolift/engineering_maintenance,
		/area/turbolift/engineering_station
		)

/obj/turbolift_map_holder/yonaguni/cargo
	name = "Exodus turbolift map placeholder - Cargo"

	areas_to_use = list(
		/area/turbolift/cargo_maintenance,
		/area/turbolift/cargo_station
		)

/obj/turbolift_map_holder/yonaguni/salvage
	name = "Exodus turbolift map placeholder - Salvage"
	icon = 'icons/obj/turbolift_preview_3x3.dmi'
	dir = NORTH
	lift_size_x = 4
	lift_size_y = 4
	depth = 3
	icon_state = "nowalls"
	place_interior_doors = FALSE
	place_exterior_doors = FALSE
	place_walls = FALSE
	exterior_panel_type = /obj/structure/lift/button/freestanding
	interior_panel_type = /obj/structure/lift/panel/freestanding
	areas_to_use = list(
		/area/turbolift/salvage_sublevel,
		/area/turbolift/salvage_maintenance,
		/area/turbolift/salvage_station
		)

/obj/turbolift_map_holder/yonaguni/salvage/New()
	panel_offsets = list("int-[NORTH]-y" = -1, "ext-[NORTH]-y" = -1)
	. = ..()
