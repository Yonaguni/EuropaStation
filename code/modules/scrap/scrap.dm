/obj/item/weapon/storage/stationary/scrap
	name = "scrap pile"
	desc = "Someone met an unfortunate fate. Better see what's left."
	opacity = 0
	density = 0
	icon_state = "small1"
	icon = 'icons/obj/structures/scrap.dmi'
	icon_closed = null
	icon_open = null

	var/base_icon = "small"
	var/loot_min = 3
	var/loot_max = 5
	var/list/loot_list = list(
		/obj/item/stack/rods/scrap,
		/obj/item/stack/material/plastic/scrap,
		/obj/item/stack/material/scrap,
		/obj/item/stack/material/glass/scrap,
		/obj/item/stack/material/plasteel/scrap,
		/obj/item/weapon/material/shard,
		/obj/item/weapon/material/shard/shrapnel
		)

/obj/item/weapon/storage/stationary/scrap/vehicle
	name = "debris pile"
	loot_list = list(
		/obj/item/vehicle_part,
		/obj/item/vehicle_part,
		/obj/item/vehicle_part,
		/obj/item/vehicle_part,
		/obj/item/stack/rods/scrap,
		/obj/item/stack/material/plastic/scrap,
		/obj/item/stack/material/scrap,
		/obj/item/weapon/material/shard
		)

/obj/item/weapon/storage/stationary/scrap/New()
	icon_state = "[base_icon][rand(1,2)]"
	var/amt = rand(loot_min, loot_max)
	for(var/x = 1 to amt)
		var/loot_path = pick(loot_list)
		if(initial_contents[loot_path])
			initial_contents[loot_path]++
		else
			initial_contents[loot_path] = 1
	..()

// Random order!
/obj/item/weapon/storage/stationary/open(var/mob/user)
	if(contents.len) contents = shuffle(contents)
	..(user)

/obj/item/weapon/storage/stationary/scrap/large
	name = "large scrap pile"
	opacity = 1
	density = 1
	icon_state = "large1"
	base_icon = "large"
	loot_min = 10
	loot_max = 20

	// They are bigger!
	pixel_x = -16
	pixel_y = -16
