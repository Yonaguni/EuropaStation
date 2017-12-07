/decl/hierarchy/supply_pack/miscellaneous
	name = "Miscellaneous"

/decl/hierarchy/supply_pack/miscellaneous/carpet
	name = "Carpet"
	contains = list(/obj/item/stack/tile/carpet/fifty)
	cost = 15
	containername = "\improper Carpet crate"

/decl/hierarchy/supply_pack/miscellaneous/linoleum
	name = "Linoleum"
	contains = list(/obj/item/stack/tile/linoleum/fifty)
	cost = 15
	containername = "\improper Linoleum crate"

/decl/hierarchy/supply_pack/miscellaneous/white_tiles
	name = "White floor tiles"
	contains = list(/obj/item/stack/tile/floor_white/fifty)
	cost = 15
	containername = "\improper White floor tile crate"

/decl/hierarchy/supply_pack/miscellaneous/dark_tiles
	name = "Dark floor tiles"
	contains = list(/obj/item/stack/tile/floor_dark/fifty)
	cost = 15
	containername = "\improper Dark floor tile crate"

/decl/hierarchy/supply_pack/miscellaneous/freezer_tiles
	name = "Freezer floor tiles"
	contains = list(/obj/item/stack/tile/floor_freezer/fifty)
	cost = 15
	containername = "\improper Freezer floor tile crate"

/decl/hierarchy/supply_pack/miscellaneous/card_packs
	num_contained = 5
	contains = list(/obj/item/pack/cardemon,
					/obj/item/pack/spaceball,
					/obj/item/deck/holder)
	name = "\improper Trading Card Crate"
	cost = 20
	containername = "\improper cards crate"
	supply_method = /decl/supply_method/randomized

/decl/hierarchy/supply_pack/miscellaneous/eftpos
	contains = list(/obj/item/eftpos)
	name = "EFTPOS scanner"
	cost = 10
	containername = "\improper EFTPOS crate"

/decl/hierarchy/supply_pack/miscellaneous/cardboard_sheets
	name = "50 cardboard sheets"
	contains = list(/obj/item/stack/material/cardboard/fifty)
	cost = 10
	containername = "\improper Cardboard sheets crate"

/decl/hierarchy/supply_pack/miscellaneous/exosuit_mod
	num_contained = 1
	name = "Random APLU modkit"
	contains = list(
		/obj/item/kit/paint/ripley,
		/obj/item/kit/paint/ripley/death,
		/obj/item/kit/paint/ripley/flames_red,
		/obj/item/kit/paint/ripley/flames_blue
		)
	cost = 200
	containername = "heavy crate"
	supply_method = /decl/supply_method/randomized
