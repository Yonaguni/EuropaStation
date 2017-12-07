/obj/turbolift_map_holder/makara
	name = "Makara turbolift placeholder"
	icon = 'icons/obj/turbolift_preview_2x3.dmi'
	depth = 3
	lift_size_x = 4
	lift_size_y = 3
	dir = EAST
	place_exterior_doors = FALSE

	areas_to_use = list(
		/area/turbolift/makara_one,
		/area/turbolift/makara_two,
		/area/turbolift/makara_three
		)
	panel_offsets = list(
		"ext-4-x" = -1, //offset east panel x by -1
		"ext-4-y" = 1   //offset east panel y by 1
		)
