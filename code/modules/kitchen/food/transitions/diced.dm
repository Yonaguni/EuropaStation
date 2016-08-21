/decl/food_transition/diced
	cooking_method = METHOD_DICING
	cooking_message = "slices up"
	cooking_time = 0

/decl/food_transition/diced/spaghetti
	input_type = /obj/item/reagent_containers/food/snacks/ingredient_mix/slice
	output_type = /obj/item/reagent_containers/food/snacks/spagetti

/decl/food_transition/diced/chocchips
	input_type = /obj/item/reagent_containers/food/snacks/chocolatebar
	output_type = /obj/item/reagent_containers/food/snacks/chocolatechips
	cooking_message = "roughly chops"

/decl/food_transition/diced/sticks
	input_type = /obj/item/reagent_containers/food/snacks/grown
	output_type = /obj/item/reagent_containers/food/snacks/vegetable/rawsticks
	var/modifier = "sliced"

/decl/food_transition/diced/sticks/get_output_product(var/obj/item/source)
	var/obj/item/reagent_containers/food/snacks/vegetable/output = new output_type(source.loc)
	var/obj/item/reagent_containers/food/snacks/vegetable/input = source
	if(istype(input))
		output.base_grown = input.base_grown
	else
		output.base_grown = source.name

	output.color = source.color
	if(!output.color)
		var/obj/item/reagent_containers/food/filling = source
		if(istype(filling))
			output.color = filling.filling_color

	output.name = "[modifier] [output.base_grown]"
	output.desc += " It's made from [output.base_grown]."
	return output

/decl/food_transition/diced/sticks/hash
	input_type = /obj/item/reagent_containers/food/snacks/vegetable/rawsticks
	output_type = /obj/item/reagent_containers/food/snacks/vegetable/hash
	modifier = "diced"
	cooking_message = "dices up"
