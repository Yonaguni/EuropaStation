
/*
 * Recipe datum
 */
/datum/stack_recipe
	var/title = "ERROR"
	var/result_type
	var/req_amount = 1 //amount of material needed for this recipe
	var/res_amount = 1 //amount of stuff that is produced in one batch (e.g. 4 for floor tiles)
	var/max_res_amount = 1
	var/time = 0
	var/one_per_turf = 0
	var/on_floor = 0
	var/use_material

/datum/stack_recipe/New(title, result_type, req_amount = 1, res_amount = 1, max_res_amount = 1, time = 0, one_per_turf = 0, on_floor = 0, supplied_material = null)
	src.title = title
	src.result_type = result_type
	src.req_amount = req_amount
	src.res_amount = res_amount
	src.max_res_amount = max_res_amount
	src.time = time
	src.one_per_turf = one_per_turf
	src.on_floor = on_floor
	src.use_material = supplied_material

/*
 * Recipe list datum
 */
/datum/stack_recipe_list
	var/title = "ERROR"
	var/list/recipes = null
	New(title, recipes)
		src.title = title
		src.recipes = recipes

/material/proc/get_recipes()
	if(!recipes)
		generate_recipes()
	return recipes

/material/proc/generate_recipes()
	recipes = list()

/material/steel/generate_recipes()
	..()
	recipes += new/datum/stack_recipe("wall girders", /obj/structure/girder, 2, time = 50, one_per_turf = 1, on_floor = 1)
	recipes += new/datum/stack_recipe("machine frame", /obj/machinery/constructable_frame/machine_frame, 5, time = 25, one_per_turf = 1, on_floor = 1)

/material/sandstone/generate_recipes()
	..()
	recipes += new/datum/stack_recipe("planting bed", /obj/machinery/hydroponics/soil, 3, time = 10, one_per_turf = 1, on_floor = 1)

/material/cardboard/generate_recipes()
	..()
	recipes += new/datum/stack_recipe("box", /obj/item/storage/box)
	recipes += new/datum/stack_recipe("pizza box", /obj/item/pizzabox)
	recipes += new/datum/stack_recipe_list("folders",list( \
		new/datum/stack_recipe("blue folder", /obj/item/folder/blue), \
		new/datum/stack_recipe("grey folder", /obj/item/folder), \
		new/datum/stack_recipe("red folder", /obj/item/folder/red), \
		new/datum/stack_recipe("white folder", /obj/item/folder/white), \
		new/datum/stack_recipe("yellow folder", /obj/item/folder/yellow) \
		))
