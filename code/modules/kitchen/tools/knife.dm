/obj/item/material/knife
	name = "kitchen knife"
	icon = 'icons/obj/kitchen/inedible/tools.dmi'
	icon_state = "knife"
	desc = "A general purpose Chef's Knife made by SpaceCook Incorporated. Guaranteed to stay sharp for years to come."
	flags = CONDUCT
	sharp = 1
	edge = 1
	force_divisor = 0.15 // 9 when wielded with hardness 60 (steel)
	matter = list(DEFAULT_WALL_MATERIAL = 12000)
	attack_verb = list("slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
	unbreakable = 1

/obj/item/material/knife/afterattack(var/atom/A, var/mob/user, var/proximity)
	if(!proximity) return

	// It slices!
	if(istype(A, /obj/item/reagent_containers/food/snacks))
		var/obj/item/reagent_containers/food/snacks/S = A
		if(S.is_sliceable())
			var/trans_amt
			if(S.reagents && S.reagents.total_volume)
				trans_amt = round(S.reagents.total_volume/S.slice_count)

			var/obj/item/reagent_containers/food/snacks/ingredient_mix/D
			if(istype(S, /obj/item/reagent_containers/food/snacks/ingredient_mix))
				D = S

			// Create one slice to check if we're moving reagents and stuff around.
			var/is_mix
			var/obj/item/reagent_containers/food/snacks/ingredient_mix/slice = new S.slices_to(get_turf(S))
			if(istype(slice) && D)
				is_mix = 1
				slice.base_ingredients = D.base_ingredients.Copy()
				slice.reagent_ingredients = D.reagent_ingredients.Copy()
				slice.update_from_ingredients()
			if(trans_amt)
				S.reagents.trans_to_obj(slice,trans_amt)

			// Snowflakey as fuck.
			var/is_meat = 0
			var/obj/item/reagent_containers/food/snacks/meat/meatsource = S
			var/obj/item/reagent_containers/food/snacks/meat/meatoutput = slice
			if(istype(meatsource) && istype(meatoutput))
				is_meat = 1
				meatoutput.set_source_mob(meatsource.source_mob)

			// Repeate for remaining slices.
			if(S.slice_count > 1)
				for(var/i=1;i<=(S.slice_count-1);i++)
					slice = new S.slices_to(get_turf(S))
					if(is_meat)
						meatoutput = slice
						meatoutput.set_source_mob(meatsource.source_mob)
					if(is_mix && D)
						slice.base_ingredients = D.base_ingredients.Copy()
						slice.reagent_ingredients = D.reagent_ingredients.Copy()
						slice.update_from_ingredients()
					if(trans_amt) S.reagents.trans_to_obj(slice,trans_amt)
			user.visible_message("\The [user] slices \the [S] into [S.slice_count] [S.slice_count == 1 ? "piece" : "pieces"].")
			qdel(A)
			return

	// It dices!
	var/decl/food_transition/F = get_food_transition(A, METHOD_DICING, 1)
	if(F)
		var/obj/item/food = F.get_output_product(A)
		food.forceMove(get_turf(A))
		food.name = "[trim(food.name)]"
		user.visible_message("\The [user] [F.cooking_message ? F.cooking_message : "dices up"] \the [A].")
		qdel(A)
		return

	return ..()

/obj/item/material/knife/butch
	name = "butcher's cleaver"
	icon_state = "butch"
	desc = "A huge thing used for chopping and chopping up meat. This includes clowns and clown by-products."
	force_divisor = 0.25 // 15 when wielded with hardness 60 (steel)
	attack_verb = list("cleaved", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
