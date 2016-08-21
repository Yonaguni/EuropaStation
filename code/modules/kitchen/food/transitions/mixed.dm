/decl/food_transition/mixed
	input_type = null
	cooking_method = METHOD_MIXING
	cooking_message = "mixes up"
	cooking_time = 0

// Mixing only cares about reagents.
/decl/food_transition/mixed/matches_input_type()
	return 1

/decl/food_transition/mixed/stuffing
	output_type = /obj/item/reagent_containers/food/snacks/stuffing
	req_reagents = list("egg" = 3, "breadcrumbs" = 10)

/decl/food_transition/mixed/dough
	output_type = /obj/item/reagent_containers/food/snacks/ingredient_mix/bread
	req_reagents = list("egg" = 6, "flour" = 15, "sodiumchloride" = 3)
	cooking_message = "becomes firm and elastic"

/decl/food_transition/mixed/batter
	output_type = /obj/item/reagent_containers/food/snacks/ingredient_mix/batter
	req_reagents = list("egg" = 15, "flour" = 15, "sugar" = 3)
	cooking_message = "becomes smooth and sticky"

/decl/food_transition/mixed/meringue
	output_type = /obj/item/reagent_containers/food/snacks/ingredient_mix/meringue
	req_reagents = list("egg" = 12, "sugar" = 12)
	cooking_message = "becomes thick and creamy"

/decl/food_transition/mixed/jelly
	output_type = /obj/item/reagent_containers/food/snacks/ingredient_mix/jelly //todo
	req_reagents = list("water" = 10, "sugar" = 10, "gelatine" = 10)
	cooking_message = "begins to set"

/decl/food_transition/mixed/pudding
	output_type = /obj/item/reagent_containers/food/snacks/ingredient_mix/pudding //todo
	req_reagents = list("flour" = 15, "sugar" = 15, "milk" = 5, "egg" = 6)
	cooking_message = "becomes thick and heavy"