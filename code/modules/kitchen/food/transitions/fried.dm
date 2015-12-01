/decl/food_transition/fried
	cooking_method = METHOD_FRYING
	cooking_message = "sizzles"

/decl/food_transition/fried/egg
	input_type =  /obj/item/weapon/reagent_containers/food/snacks/egg/frying
	output_type = /obj/item/weapon/reagent_containers/food/snacks/egg/fried

/decl/food_transition/fried/cutlet
	input_type =  /obj/item/weapon/reagent_containers/food/snacks/meat/rawcutlet
	output_type = /obj/item/weapon/reagent_containers/food/snacks/meat/cutlet

/decl/food_transition/fried/patty
	input_type =  /obj/item/weapon/reagent_containers/food/snacks/meat/rawpatty
	output_type = /obj/item/weapon/reagent_containers/food/snacks/meat/patty

/decl/food_transition/fried/soypatty
	input_type =  /obj/item/weapon/reagent_containers/food/snacks/tofu/patty
	output_type = /obj/item/weapon/reagent_containers/food/snacks/tofu/cookedpatty

/decl/food_transition/fried/meatball
	input_type = /obj/item/weapon/reagent_containers/food/snacks/meat/rawmeatball
	output_type = /obj/item/weapon/reagent_containers/food/snacks/meat/meatball

/decl/food_transition/fried/steak
	input_type = /obj/item/weapon/reagent_containers/food/snacks/meat/slab
	output_type = /obj/item/weapon/reagent_containers/food/snacks/meat/meatsteak
	cooking_message = "is seared to perfection"

/decl/food_transition/fried/hash
	input_type = /obj/item/weapon/reagent_containers/food/snacks/vegetable/hash
	output_type = /obj/item/weapon/reagent_containers/food/snacks/vegetable/friedhash
	cooking_message = "turns a rich golden-brown"

/decl/food_transition/fried/hash/potato_chips
	input_type =  /obj/item/weapon/reagent_containers/food/snacks/vegetable/rawsticks
	output_type = /obj/item/weapon/reagent_containers/food/snacks/vegetable/fries

/decl/food_transition/fried/hash/get_output_product(var/obj/item/source)
	var/obj/item/weapon/reagent_containers/food/snacks/vegetable/hash/S = source
	var/obj/item/food = new output_type(source.loc)
	if(istype(S))
		food.name = "[S.base_grown] hashbrown"
		food.desc += "[S.base_grown]."
	if(source.color)
		food.color = source.color
	return food

/decl/food_transition/fried/pancakes
	input_type = /obj/item/weapon/reagent_containers/food/snacks/ingredient_mix/muffin
	output_type = /obj/item/weapon/reagent_containers/food/snacks/pancakes
	cooking_message = "turn a rich golden-brown"

/decl/food_transition/fried/pancakes/get_output_product(var/obj/item/source)
	var/obj/item/weapon/reagent_containers/food/snacks/ingredient_mix/S = source
	var/obj/item/food = new output_type(source.loc)
	if(istype(S))
		if(S.examined_descriptor && S.examined_descriptor != "") food.desc += " [S.examined_descriptor]"
		if(S.content_descriptor && S.content_descriptor != "")   food.name =  "[S.content_descriptor] [food.name]"
	if(S.color)
		food.color = source.color
	return food