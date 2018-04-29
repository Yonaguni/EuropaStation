/decl/xgm_gas/oxygen
	id = GAS_OXYGEN
	name = "Oxygen"
	specific_heat = 20	// J/(mol*K)
	molar_mass = 0.032	// kg/mol

	flags = XGM_GAS_OXIDIZER | XGM_GAS_FUSION_FUEL

/decl/xgm_gas/nitrogen
	id = GAS_NITROGEN
	name = "Nitrogen"
	specific_heat = 20	// J/(mol*K)
	molar_mass = 0.028	// kg/mol

/decl/xgm_gas/carbon_dioxide
	id = GAS_CARBON_DIOXIDE
	name = "Carbon Dioxide"
	specific_heat = 30	// J/(mol*K)
	molar_mass = 0.044	// kg/mol

/decl/xgm_gas/fuel
	id = GAS_FUEL
	name = "Fuel"

	//Note that this has a significant impact on TTV yield.
	//Because it is so high, any leftover phoron soaks up a lot of heat and drops the yield pressure.
	specific_heat = 200	// J/(mol*K)

	//Hypothetical group 14 (same as carbon), period 8 element.
	//Using multiplicity rule, it's atomic number is 162
	//and following a N/Z ratio of 1.5, the molar mass of a monatomic gas is:
	molar_mass = 0.405	// kg/mol

	tile_overlay = "gas_dense"
	tile_overlay_colour = "#FFBB00"
	overlay_limit = 0.7
	flags = XGM_GAS_FUEL | XGM_GAS_CONTAMINANT | XGM_GAS_FUSION_FUEL

/decl/xgm_gas/sleeping_agent
	id = GAS_SLEEPING
	name = "Sleeping Agent"
	specific_heat = 40	// J/(mol*K)
	molar_mass = 0.044	// kg/mol. N2O

	tile_overlay = "gas_sparse"
	overlay_limit = 1
	flags = XGM_GAS_OXIDIZER //N2O is a powerful oxidizer

// This is only to be used for abstract stuff (drowning on Europa etc) for the moment
// may add it as 'Steam' at some point down the track
/decl/xgm_gas/water
	id = GAS_STEAM
	name = "Steam"
	specific_heat = 30	// J/(mol*K)
	molar_mass = 0.020	// kg/mol
	tile_overlay = "gas_dense"

/decl/xgm_gas/hydrogen
	id = GAS_HYDROGEN
	name = "Hydrogen"

	specific_heat = 100	// J/(mol*K)
	molar_mass = 0.002	// kg/mol

	flags = XGM_GAS_FUEL|XGM_GAS_FUSION_FUEL

	burn_product = GAS_STEAM

/decl/xgm_gas/hydrogen/deuterium
	id = GAS_DEUTERIUM
	name = "Deuterium"

/decl/xgm_gas/hydrogen/tritium
	id = GAS_TRITIUM
	name = "Tritium"

/decl/xgm_gas/helium
	id = GAS_HELIUM
	name = "Helium"

	specific_heat = 80	// J/(mol*K)
	molar_mass = 0.004	// kg/mol

	flags = XGM_GAS_FUSION_FUEL
	