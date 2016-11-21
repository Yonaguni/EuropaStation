/decl/hierarchy/supply_pack/hospitality
	name = "Hospitality"

/decl/hierarchy/supply_pack/hospitality/party
	name = "Party equipment"
	contains = list(
			/obj/item/storage/box/mixedglasses = 2,
			/obj/item/storage/box/glasses/square,
			/obj/item/reagent_containers/food/drinks/shaker,
			/obj/item/reagent_containers/food/drinks/flask/barflask,
			/obj/item/reagent_containers/food/drinks/bottle/patron,
			/obj/item/reagent_containers/food/drinks/bottle/goldschlager,
			/obj/item/storage/fancy/cigarettes/dromedaryco,
			/obj/item/lipstick/random,
			/obj/item/reagent_containers/food/drinks/bottle/small/ale = 2,
			/obj/item/reagent_containers/food/drinks/bottle/small/beer = 4
			)
	cost = 20
	containername = "\improper Party equipment"

/decl/hierarchy/supply_pack/hospitality/barsupplies
	name = "Bar supplies"
	contains = list(
			/obj/item/storage/box/glasses/cocktail,
			/obj/item/storage/box/glasses/rocks,
			/obj/item/storage/box/glasses/square,
			/obj/item/storage/box/glasses/pint,
			/obj/item/storage/box/glasses/wine,
			/obj/item/storage/box/glasses/shake,
			/obj/item/storage/box/glasses/shot,
			/obj/item/storage/box/glasses/mug,
			/obj/item/reagent_containers/food/drinks/shaker,
			/obj/item/storage/box/glass_extras/straws,
			/obj/item/storage/box/glass_extras/sticks
			)
	cost = 10
	containername = "crate of bar supplies"

/decl/hierarchy/supply_pack/hospitality/lasertag
	name = "Lasertag equipment"
	contains = list(/obj/item/gun/composite/premade/laser_assault/practice = 6)
	cost = 20
	containertype = /obj/structure/closet
	containername = "\improper Lasertag Closet"

/decl/hierarchy/supply_pack/hospitality/pizza
	num_contained = 5
	name = "Surprise pack of five pizzas"
	contains = list(/obj/item/pizzabox/margherita,
					/obj/item/pizzabox/mushroom,
					/obj/item/pizzabox/meat,
					/obj/item/pizzabox/vegetable)
	cost = 15
	containertype = /obj/structure/closet/crate/freezer
	containername = "\improper Pizza crate"
	supply_method = /decl/supply_method/randomized
