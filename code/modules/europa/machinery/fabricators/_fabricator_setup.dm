#define FABRICATOR_AMMO        "ammofab"
#define FABRICATOR_BASIC       "basicfab"
#define FABRICATOR_CIRCUITS    "circuitfab"
#define FABRICATOR_ELECTRONICS "elecfab"
#define FABRICATOR_GLASS       "glassfab"
#define FABRICATOR_HEAVY       "heavyfab"
#define FABRICATOR_TYPES list(FABRICATOR_AMMO,FABRICATOR_BASIC,FABRICATOR_CIRCUITS,FABRICATOR_ELECTRONICS,FABRICATOR_GLASS,FABRICATOR_HEAVY)
#define MAX_FAB_QUEUE 50

/decl/fabricator_design
	var/name = "object"
	var/path
	var/fabtype = FABRICATOR_BASIC
	var/list/resources
	var/list/reagents
	var/hidden
	var/category
	var/power_use = 0
	var/is_stack
	var/stack_max

// These are basically just to avoid having to deal with lists of lists.
/datum/fabricator_design_list
	var/list/recipes = list()

/datum/fabricator_queue_entry
	var/decl/fabricator_design/design
	var/multiplier = 1

/datum/fabricator_queue_entry/New(var/decl/fabricator_design/use_design, var/newmultiplier = 1)
	if(!use_design)
		del(src)
		return
	design = use_design
	multiplier = newmultiplier

var/global/list/fabricator_categories
var/global/list/fabricator_recipes

/proc/populate_fabricator_recipes()

	fabricator_recipes = list()
	fabricator_categories = list()

	// Could be hacked using lists of lists but that makes me v. uncomfortable.
	for(var/fabtype in FABRICATOR_TYPES)
		fabricator_recipes[fabtype] = new /datum/fabricator_design_list

	for(var/R in typesof(/decl/fabricator_design)-/decl/fabricator_design)
		var/decl/fabricator_design/recipe = new R
		fabricator_categories |= recipe.category
		var/obj/item/I = new recipe.path
		if(istype(I, /obj/item/stack))
			var/obj/item/stack/S = I
			recipe.is_stack = 1
			recipe.stack_max = S.max_amount
		if(I.matter && !recipe.resources) //This can be overidden in the datums.
			recipe.resources = list()
			for(var/material in I.matter)
				recipe.resources[material] = I.matter[material]*1.25 // More expensive to produce than they are to recycle.
			qdel(I)
		var/datum/fabricator_design_list/FDL = fabricator_recipes[recipe.fabtype]
		FDL.recipes += recipe
