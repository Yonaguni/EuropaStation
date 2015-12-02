/var/datum/xgm_gas_data/gas_data

/datum/xgm_gas_data
	var/list/gases = list()          //Simple list of all the gas IDs.
	var/list/name = list()           // The friendly, human-readable name for the gas.
	var/list/specific_heat = list()  //Specific heat of the gas.  Used for calculating heat capacity.
	var/list/molar_mass = list()     // Molar mass of the gas.  Used for calculating specific entropy.
	var/list/tile_overlay = list()   // Tile overlays.  /images, created from references to 'icons/effects/tile_effects.dmi'
	var/list/saturated_overlay = list()
	var/list/overlay_limit = list()  // Overlay limits.  There must be at least this many moles for the overlay to appear.
	var/list/flags = list()          // Flags.

/decl/xgm_gas
	var/id = ""
	var/name = "Unnamed Gas"
	var/specific_heat = 20	// J/(mol*K)
	var/molar_mass = 0.032	// kg/mol
	var/tile_overlay = null
	var/tile_overlay_colour = null
	var/overlay_limit = null
	var/layer_offset = 0

	var/flags = 0

/hook/startup/proc/generateGasData()
	gas_data = new
	for(var/p in (typesof(/decl/xgm_gas) - /decl/xgm_gas))
		var/decl/xgm_gas/gas = new p //avoid initial() because of potential New() actions

		if(gas.id in gas_data.gases)
			error("Duplicate gas id `[gas.id]` in `[p]`")
		gas_data.gases += gas.id
		gas_data.name[gas.id] = gas.name
		gas_data.specific_heat[gas.id] = gas.specific_heat
		gas_data.molar_mass[gas.id] = gas.molar_mass
		if(gas.tile_overlay)
			var/image/I = image('icons/effects/xgm_overlays.dmi', gas.tile_overlay)
			I.layer = FLY_LAYER + gas.layer_offset
			if(gas.tile_overlay_colour) I.color = gas.tile_overlay_colour
			gas_data.tile_overlay[gas.id] = I
		var/image/saturation = image('icons/effects/xgm_overlays.dmi', "ocean")
		if(gas.tile_overlay_colour) saturation.color = gas.tile_overlay_colour
		saturation.layer = FLY_LAYER + gas.layer_offset
		gas_data.saturated_overlay[gas.id] = saturation
		if(gas.overlay_limit) gas_data.overlay_limit[gas.id] = gas.overlay_limit
		gas_data.flags[gas.id] = gas.flags

	return 1
