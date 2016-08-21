/decl/food_transition/baked
	cooking_method = METHOD_BAKING
	cooking_message = "smells delicious"
	req_container = /obj/item/reagent_containers/kitchen/bakingtray

/decl/food_transition/baked/cracker
	input_type = /obj/item/reagent_containers/food/snacks/ingredient_mix/slice
	output_type = /obj/item/reagent_containers/food/snacks/baked/cracker

/decl/food_transition/baked/meat
	input_type =  /obj/item/reagent_containers/food/snacks/meat/rawcutlet
	output_type = /obj/item/reagent_containers/food/snacks/meat/cutlet

/decl/food_transition/baked/meat/get_output_product(var/obj/item/source)
	var/obj/item/reagent_containers/food/snacks/meat/food = ..()
	if(istype(food) && istype(source, /obj/item/reagent_containers/food/snacks/meat))
		var/obj/item/reagent_containers/food/snacks/meat/other_food = source
		food.set_source_mob(other_food.source_mob)
		food.color = other_food.color
		if(!food.color)
			var/obj/item/reagent_containers/food/filling = source
			if(istype(filling))
				food.color = filling.filling_color
	return food

/decl/food_transition/baked/meat/meatball
	input_type = /obj/item/reagent_containers/food/snacks/meat/rawmeatball
	output_type = /obj/item/reagent_containers/food/snacks/meat/meatball

/decl/food_transition/baked/meat/patty
	input_type =  /obj/item/reagent_containers/food/snacks/meat/rawpatty
	output_type = /obj/item/reagent_containers/food/snacks/meat/patty

/decl/food_transition/baked/soypatty
	input_type =  /obj/item/reagent_containers/food/snacks/tofu/patty
	output_type = /obj/item/reagent_containers/food/snacks/tofu/cookedpatty

/decl/food_transition/baked/bread
	input_type = /obj/item/reagent_containers/food/snacks/ingredient_mix/bread
	output_type = /obj/item/reagent_containers/food/snacks/baked/bread

/decl/food_transition/baked/bread/get_output_product(var/obj/item/source)
	var/obj/item/reagent_containers/food/snacks/ingredient_mix/D = source
	var/obj/item/food = new output_type(source.loc)
	if(istype(D) && D.content_descriptor != "")
		food.name = "[D.content_descriptor] [food.name]"
	return food

/decl/food_transition/baked/bread/pretzel
	input_type = /obj/item/reagent_containers/food/snacks/raw_pretzel
	output_type = /obj/item/reagent_containers/food/snacks/baked/pretzel

/decl/food_transition/baked/bread/bun
	input_type = /obj/item/reagent_containers/food/snacks/ingredient_mix/bun
	output_type = /obj/item/reagent_containers/food/snacks/baked/bun

/decl/food_transition/baked/bread/muffin
	input_type = /obj/item/reagent_containers/food/snacks/ingredient_mix/muffin
	output_type = /obj/item/reagent_containers/food/snacks/baked/muffin

/decl/food_transition/baked/bread/cake
	input_type = /obj/item/reagent_containers/food/snacks/ingredient_mix/batter
	output_type = /obj/item/reagent_containers/food/snacks/complex/cake
	req_container = /obj/item/reagent_containers/kitchen/caketin

/decl/food_transition/baked/bread/pizza
	input_type = /obj/item/reagent_containers/food/snacks/ingredient_mix/flat
	output_type = /obj/item/reagent_containers/food/snacks/complex/pizza

/decl/food_transition/baked/bread/pizza/get_output_product(var/obj/item/source)
	if(source.contents.len)
		return new output_type(source.loc)
	else
		var/obj/item/reagent_containers/food/snacks/ingredient_mix/D = source
		var/obj/item/food = new /obj/item/reagent_containers/food/snacks/baked/flatbread(source.loc)
		if(istype(D) && D.content_descriptor != "")
			food.name = "[D.content_descriptor] [food.name]"
		return food

/decl/food_transition/baked/meatloaf
	input_type = /obj/item/reagent_containers/food/snacks/meat/mince
	output_type = /obj/item/reagent_containers/food/snacks/meat/loaf