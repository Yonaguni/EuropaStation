var/datum/controller/subsystem/materials/SSmaterials

/datum/controller/subsystem/materials
	name = "Materials"
	init_order = SS_INIT_MATERIALS
	flags = SS_NO_FIRE

	var/list/materials
	var/list/materials_by_name
	var/list/alloy_components
	var/list/alloy_products
	var/list/processable_ores

/datum/controller/subsystem/materials/New()
	NEW_SS_GLOBAL(SSmaterials)

/datum/controller/subsystem/materials/Initialize()

	materials =         list()
	materials_by_name = list()
	alloy_components =  list()
	alloy_products =    list()
	processable_ores =  list()

	for(var/type in subtypesof(/material))
		var/material/new_mineral = new type
		if(new_mineral.name)
			materials += new_mineral
			materials_by_name[lowertext(new_mineral.name)] = new_mineral
			if(new_mineral.ore_smelts_to || new_mineral.ore_compresses_to)
				processable_ores[new_mineral.name] = TRUE
			if(new_mineral.alloy_product && LAZYLEN(new_mineral.composite_material))
				alloy_products[new_mineral] = TRUE
				for(var/component in new_mineral.composite_material)
					processable_ores[component] = TRUE
					alloy_components[component] = TRUE
		CHECK_TICK
	// TEMPORARY
	name_to_material = materials_by_name
	// END TEMPORARY
	. = ..()

/datum/controller/subsystem/materials/proc/get_material_by_name(name)
	return (materials_by_name ? materials_by_name[name] : null)

// PLACEHOLDERS KEPT FOR LEGACY PURPOSES,
// REMOVE THESE PROCS WHEN POSSIBLE PLS.
// Builds the datum list above.
var/list/name_to_material
/proc/populate_material_list(force_remake=0)
	if(name_to_material && !force_remake) return // Already set up!
	name_to_material = list()
	for(var/type in subtypesof(/material))
		var/material/new_mineral = new type
		if(!new_mineral.name)
			continue
		name_to_material[lowertext(new_mineral.name)] = new_mineral
	return 1

// Safety proc to make sure the material list exists before trying to grab from it.
/proc/get_material_by_name(name)
	if(SSmaterials && SSmaterials.materials)
		return SSmaterials.get_material_by_name(name)
	if(!name_to_material)
		populate_material_list()
	return name_to_material[name]

/proc/material_display_name(name)
	var/material/material = get_material_by_name(name)
	if(material)
		return material.display_name
	return null
// END LOUD SHOUTING COMMENT