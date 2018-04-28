var/datum/controller/subsystem/materials/SSmaterials

/datum/controller/subsystem/materials
	name = "Materials"
	init_order = SS_INIT_MATERIALS
	flags = SS_NO_FIRE

	var/list/materials
	var/list/materials_by_path
	var/list/alloy_components
	var/list/alloy_products
	var/list/processable_ores

/datum/controller/subsystem/materials/New()
	NEW_SS_GLOBAL(SSmaterials)

/datum/controller/subsystem/materials/Initialize()

	materials =         list()
	materials_by_path = list()
	alloy_components =  list()
	alloy_products =    list()
	processable_ores =  list()

	for(var/type in subtypesof(/material))
		var/material/new_material = get_material(type)
		if(new_material.ore_smelts_to || new_material.ore_compresses_to)
			processable_ores[new_material.name] = TRUE
		if(new_material.alloy_product && LAZYLEN(new_material.composite_material))
			alloy_products[new_material] = TRUE
			for(var/component in new_material.composite_material)
				processable_ores[component] = TRUE
				alloy_components[component] = TRUE
		CHECK_TICK
	. = ..()

/datum/controller/subsystem/materials/proc/get_material(var/path)
	if(!materials_by_path) materials_by_path = list()
	if(!materials_by_path[path])
		var/material/new_material = new path()
		materials_by_path[path] = new_material
		if(!materials) materials = list()
		materials += new_material
	return materials_by_path[path]
