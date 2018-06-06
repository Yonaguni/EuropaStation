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

	// Gas data.
	var/list/specific_heats     // Specific heat of the gas.  Used for calculating heat capacity.
	var/list/molar_masses       // Molar mass of the gas.  Used for calculating specific entropy.
	var/list/gas_tile_overlays  // Tile overlays.  /images, created from references to 'icons/effects/tile_effects.dmi'
	var/list/gas_overlay_limits // Overlay limits.  There must be at least this many moles for the overlay to appear.
	var/list/gas_flags          // Flags.
	var/list/gas_burn_products  // Products created when burned. For fuel only for now (not oxidizers)

/datum/controller/subsystem/materials/New()
	NEW_SS_GLOBAL(SSmaterials)

/datum/controller/subsystem/materials/Initialize()

	materials =          list()
	materials_by_path =  list()
	alloy_components =   list()
	alloy_products =     list()
	processable_ores =   list()
	specific_heats =     list()
	molar_masses =       list()
	gas_tile_overlays =  list()
	gas_flags =          list()
	gas_burn_products =  list()
	gas_overlay_limits = list()

	for(var/mtype in subtypesof(/material))

		var/material/new_material = get_material(mtype)
		if(new_material.ore_smelts_to || new_material.ore_compresses_to)
			processable_ores[new_material.name] = TRUE
		if(new_material.alloy_product && LAZYLEN(new_material.composite_material))
			alloy_products[new_material] = TRUE
			for(var/component in new_material.composite_material)
				processable_ores[component] = TRUE
				alloy_components[component] = TRUE

		specific_heats[mtype] =    new_material.specific_heat
		molar_masses[mtype] =      new_material.molar_mass
		gas_flags[mtype] =         new_material.gas_flags
		gas_burn_products[mtype] = new_material.gas_burn_product

		if(new_material.gas_overlay_limit)
			gas_overlay_limits[mtype] = new_material.gas_overlay_limit

		if(new_material.gas_tile_overlay)
			var/image/I = image('icons/effects/xgm_overlays.dmi', new_material.gas_tile_overlay, FLY_LAYER)
			if(new_material.gas_tile_overlay_colour) I.color = new_material.gas_tile_overlay_colour
			gas_tile_overlays[mtype] = I

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
