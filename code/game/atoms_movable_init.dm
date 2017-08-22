/atom/movable
	var/auto_init = 0

/atom/movable/New()
	..()
	if(auto_init)
		if(ticker && ticker.current_state == GAME_STATE_PLAYING)
			initialize()
		else
			init_atoms += src

/mob/auto_init = 1

/obj/structure/sign/double/barsign/auto_init = 1
/obj/structure/sign/poster/auto_init = 1
/obj/structure/crematorium/auto_init = 1
/obj/structure/noticeboard/auto_init = 1
/obj/structure/pit/closed/auto_init = 1
/obj/structure/gravemarker/random/auto_init = 1
/obj/structure/safe/auto_init = 1
/obj/structure/closet/auto_init = 1
/obj/structure/largecrate/auto_init = 1
/obj/structure/fire_source/auto_init = 1
/obj/structure/flora/seaweed/glow/auto_init = 1
/obj/structure/bookcase/auto_init = 1
/obj/structure/ladder/auto_init = 1
/obj/structure/filingcabinet/auto_init = 1
/obj/structure/table/auto_init = 1

/obj/item/flashlight/auto_init = 1
/obj/item/cartridge/auto_init = 1
/obj/item/radio/auto_init = 1
/obj/item/taperoll/auto_init = 1
/obj/item/bone/single/auto_init = 1
/obj/item/clothing/head/cardborg/auto_init = 1
/obj/item/clothing/head/helmet/space/auto_init = 1
/obj/item/clothing/suit/cardborg/auto_init = 1
/obj/item/clothing/under/aeolus/auto_init = 1
/obj/item/ammo_casing/auto_init = 1
/obj/item/gun_component/accessory/chamber/flashlight/auto_init = 1
/obj/item/book/magazine/auto_init = 1
/obj/item/cell/auto_init = 1
/obj/item/fuel_assembly/auto_init = 1
/obj/item/reagent_containers/food/snacks/meat/auto_init = 1
/obj/item/disk/nuclear/auto_init = 1

/obj/random/auto_init = 1

/obj/random_multi/auto_init = 1

/obj/effect/floor_decal/auto_init = 1
/obj/effect/wingrille_spawn/auto_init = 1
/obj/effect/overmap/auto_init = 1
/obj/effect/fluid/auto_init = 1
/obj/effect/lobby_image/auto_init = 1
/obj/machinery/auto_init = 1

//obj/machinery/atmospherics/auto_init = 0

/obj/vehicle/auto_init = 1
