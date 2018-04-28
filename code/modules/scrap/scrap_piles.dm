/obj/structure/scrap/vehicle
	name = "debris pile"
	parts_icon = 'icons/obj/structures/scrap/vehicle.dmi'
	loot_list = list(
		/obj/item/vehicle_part,
		/obj/item/vehicle_part,
		/obj/item/vehicle_part,
		/obj/item/vehicle_part,
		/obj/item/stack/rods/scrap,
		/obj/item/stack/material/plastic/scrap,
		/obj/item/stack/material/scrap,
		/obj/item/material/shard
		)

/obj/structure/scrap/ore
	name = "mining drone debris"
	loot_min = 10
	loot_max = 20
	loot_list = list(
		/obj/item/ore/uranium,
		/obj/item/ore/iron,
		/obj/item/ore/coal,
		/obj/item/ore/glass,
		/obj/item/ore/silver,
		/obj/item/ore/gold,
		/obj/item/ore/diamond,
		/obj/item/ore/osmium,
		/obj/item/ore/hydrogen
		)

/obj/structure/scrap/large
	name = "large scrap pile"
	opacity = 1
	density = 1
	icon_state = "big"
	loot_min = 10
	loot_max = 20
	base_min = 9
	base_max = 14
	base_spread = 16

/obj/structure/scrap/large/fancy
	name = "glimmering scrap pile"
	loot_list = list(
		/obj/item/stack/material/uranium/scrap,
		/obj/item/stack/material/gold/scrap,
		/obj/item/stack/material/silver/scrap,
		/obj/item/stack/material/platinum/scrap,
		/obj/item/stack/material/plasteel/scrap
		)

/obj/structure/scrap/large/anomalous
	name = "anomalous scrap pile"
	loot_list = list(
		/obj/item/stack/material/mhydrogen/scrap,
		/obj/item/stack/material/tritium/scrap,
		/obj/item/stack/material/osmium/scrap,
		/obj/item/stack/material/diamond/scrap
		)