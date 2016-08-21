/decl/food_transition/boiled
	cooking_method = METHOD_BOILING
	req_reagents = list("water" = 5)
	cooking_message = "floats about"

/decl/food_transition/boiled/egg
	input_type =  /obj/item/reagent_containers/food/snacks/egg/rawegg
	output_type = /obj/item/reagent_containers/food/snacks/egg/boiled

/decl/food_transition/boiled/spaghetti
	input_type = /obj/item/reagent_containers/food/snacks/spagetti
	output_type = /obj/item/reagent_containers/food/snacks/boiledspagetti

/decl/food_transition/boiled/vegetables
	input_type = /obj/item/reagent_containers/food/snacks/vegetable/hash
	output_type = /obj/item/reagent_containers/food/snacks/vegetable/boiled

/decl/food_transition/boiled/vegetables/get_output_product(var/obj/item/source)
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

	output.name = "cooked [output.base_grown]"
	output.desc += " It's made from [output.base_grown]."
	return output