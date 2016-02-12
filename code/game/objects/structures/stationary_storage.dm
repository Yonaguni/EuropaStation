/obj/item/weapon/storage/stationary
	name = "cabinet"
	density = 1
	anchored = 1
	layer = 2.9
	icon = 'icons/obj/closet.dmi'
	icon_state = "cabinet_closed"
	max_w_class = 5
	max_storage_space = 20

	var/icon_closed = "cabinet_closed"
	var/icon_open = "cabinet_open"
	var/open

/obj/item/weapon/storage/stationary/New()
	..()
	if(!icon_open)
		icon_open = icon_state
	if(!icon_closed)
		icon_closed = icon_state
	// Mapping aid; grab everything mapped over it.
	if(ticker && ticker.current_state < GAME_STATE_PLAYING)
		for(var/obj/item/I in get_turf(src))
			if(I.simulated && !I.anchored)
				I.forceMove(src)

/obj/item/weapon/storage/stationary/update_icon()
	..()
	if(open)
		icon_state = icon_open
	else
		icon_state = icon_closed

/obj/item/weapon/storage/stationary/open(var/mob/user)
	..()
	if(!open)
		open = 1
		update_icon()

/obj/item/weapon/storage/stationary/close(var/mob/user)
	..()
	if(open)
		open = 0
		update_icon()

/obj/item/weapon/storage/stationary/attack_hand(var/mob/user)
	return open(user)

// These can just be containers for the moment.
// No idea how money is going to work down the track.
/obj/item/weapon/storage/stationary/vendor
	name = "vending machine"
	desc = "A generic vending machine."
	icon = 'icons/obj/vending.dmi'
	icon_state = "generic"
	icon_closed = null
	icon_open = null

	var/list/initial_contents = list()

/obj/item/weapon/storage/stationary/vendor/New()
	..()
	for(var/stockpath in initial_contents)
		for(var/x = 1 to initial_contents[stockpath])
			new stockpath(src)

/obj/item/weapon/storage/stationary/vendor/snack
	name = "snack machine"
	icon_state = "snack"
	initial_contents = list(
		/obj/item/weapon/reagent_containers/food/snacks/chocolatebar = 10
		)

/obj/item/weapon/storage/stationary/vendor/cola
	name = "drinks machine"
	icon_state = "soda"
	initial_contents = list(
		/obj/item/weapon/reagent_containers/food/drinks/cans/lemonade = 5,
		/obj/item/weapon/reagent_containers/food/drinks/cans/cola = 5,
		/obj/item/weapon/reagent_containers/food/drinks/cans/waterbottle = 5
		)
