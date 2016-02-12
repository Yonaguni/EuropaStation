/decl/xgm_gas/oxygen
	id = REAGENT_ID_OXYGEN
	name = REAGENT_ID_OXYGEN
	specific_heat = 20	// J/(mol*K)
	molar_mass = 0.032	// kg/mol
	flags = XGM_GAS_OXIDIZER

/decl/xgm_gas/nitrogen
	id = REAGENT_ID_NITROGEN
	name = REAGENT_ID_NITROGEN
	specific_heat = 20	// J/(mol*K)
	molar_mass = 0.028	// kg/mol

/decl/xgm_gas/carbon_dioxide
	id = REAGENT_ID_CARBONDIOXIDE
	name = "Carbon Dioxide"
	specific_heat = 30	// J/(mol*K)
	molar_mass = 0.044	// kg/mol

/decl/xgm_gas/phoron
	id = REAGENT_ID_FUEL
	name = "Fuel"

	//Note that this has a significant impact on TTV yield.
	//Because it is so high, any leftover phoron soaks up a lot of heat and drops the yield pressure.
	specific_heat = 200	// J/(mol*K)
	layer_offset = 0.3

	//Hypothetical group 14 (same as carbon), period 8 element.
	//Using multiplicity rule, it's atomic number is 162
	//and following a N/Z ratio of 1.5, the molar mass of a monatomic gas is:
	molar_mass = 0.405	// kg/mol

	tile_overlay = "gas_dense"
	tile_overlay_colour = "#FFBB00"
	overlay_limit = 0.7
	flags = XGM_GAS_FUEL | XGM_GAS_CONTAMINANT

/decl/xgm_gas/sleeping_agent
	id = REAGENT_ID_N2O
	name = "Sleeping Agent"
	specific_heat = 40	// J/(mol*K)
	molar_mass = 0.044	// kg/mol. N2O
	layer_offset = 0.1

	tile_overlay = "gas_sparse"
	overlay_limit = 1

/decl/xgm_gas/water
	id = "water"
	name = "Water"
	specific_heat = 420	// J/(mol*K)
	molar_mass = 0.018	// kg/mol

	flags = XGM_GAS_LIQUID
	tile_overlay = "water_mid"
	tile_overlay_colour = "#66D1FF"
	overlay_limit = 1
