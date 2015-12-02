/obj/structure/table/standard
	icon_state = "plain_preview"
	color = "#EEEEEE"

/obj/structure/table/standard/New(var/newloc)
	..(newloc, DEFAULT_TABLE_MATERIAL)

/obj/structure/table/steel
	icon_state = "plain_preview"
	color = "#666666"

/obj/structure/table/steel/New(var/newloc)
	..(newloc, DEFAULT_WALL_MATERIAL)

/obj/structure/table/marble
	icon_state = "stone_preview"
	color = "#CCCCCC"

/obj/structure/table/marble/New(var/newloc)
	..(newloc, "marble")

/obj/structure/table/reinforced
	icon_state = "reinf_preview"
	color = "#EEEEEE"

/obj/structure/table/reinforced/New(var/newloc)
	..(newloc, DEFAULT_TABLE_MATERIAL, DEFAULT_WALL_MATERIAL)

/obj/structure/table/steel_reinforced
	icon_state = "reinf_preview"
	color = "#666666"

/obj/structure/table/steel_reinforced/New(var/newloc)
	..(newloc, DEFAULT_WALL_MATERIAL, DEFAULT_WALL_MATERIAL)

/obj/structure/table/woodentable
	icon_state = "plain_preview"
	color = "#824B28"

/obj/structure/table/woodentable/New(var/newloc)
	..(newloc, "wood")

/obj/structure/table/gamblingtable
	icon_state = "gamble_preview"

/obj/structure/table/gamblingtable/New(var/newloc)
	carpeted = 1
	..(newloc, "wood")

/obj/structure/table/glass
	icon_state = "plain_preview"
	color = "#00E1FF"
	alpha = 77 // 0.3 * 255

/obj/structure/table/glass/New(var/newloc)
	..(newloc, "glass")

/obj/structure/table/holotable
	icon_state = "holo_preview"
	color = "#EEEEEE"

/obj/structure/table/holotable/New(var/newloc)
	..(newloc, "holo[DEFAULT_TABLE_MATERIAL]")

/obj/structure/table/woodentable/holotable
	icon_state = "holo_preview"

/obj/structure/table/woodentable/holotable/New(var/newloc)
	..(newloc, "holowood")
