/turf/simulated/floor/reinforced/airless
	temperature = TCMB
	initial_air = list()

/turf/simulated/floor/airless
	initial_air = list()
	temperature = TCMB

/turf/simulated/floor/tiled/airless
	initial_air = list()
	temperature = TCMB

/turf/simulated/floor/bluegrid/airless
	initial_air = list()
	temperature = TCMB

/turf/simulated/floor/greengrid/airless
	initial_air = list()
	temperature = TCMB

/turf/simulated/floor/greengrid/nitrogen
	initial_air = list(REAGENT_ID_NITROGEN = MOLES_N2STANDARD)

/turf/simulated/floor/tiled/white/airless
	initial_air = list()
	temperature = TCMB

/turf/simulated/floor/plating/airless
	temperature = TCMB
	initial_air = list()

/turf/simulated/floor/reinforced/airless
	initial_air = list()

/turf/simulated/floor/reinforced/airmix
	initial_air = list(REAGENT_ID_OXYGEN = MOLES_O2ATMOS, REAGENT_ID_NITROGEN = MOLES_N2ATMOS)

/turf/simulated/floor/reinforced/nitrogen
	initial_air = list(REAGENT_ID_NITROGEN = 5000)

/turf/simulated/floor/reinforced/oxygen
	initial_air = list(REAGENT_ID_OXYGEN = 5000)

/turf/simulated/floor/reinforced/phoron
	initial_air = list(REAGENT_ID_FUEL = 5000)

/turf/simulated/floor/reinforced/carbon_dioxide
	initial_air = list(REAGENT_ID_CARBONDIOXIDE = 5000)

/turf/simulated/floor/reinforced/n20
	initial_air = list(REAGENT_ID_N2O = 5000)

/turf/space
	temperature = T20C
	thermal_conductivity = OPEN_HEAT_TRANSFER_COEFFICIENT

/turf/simulated/floor/greengrid/nitrogen
	initial_air = list(REAGENT_ID_NITROGEN = MOLES_N2STANDARD)

/turf/simulated/shuttle/plating/vox //Skipjack plating
	initial_air = list(REAGENT_ID_NITROGEN = MOLES_N2STANDARD + MOLES_O2STANDARD)

/turf/simulated/shuttle/floor4 // Added this floor tile so that I have a seperate turf to check in the shuttle -- Polymorph
	name = "Brig floor"        // Also added it into the 2x3 brig area of the shuttle.
	icon_state = "floor4"

/turf/simulated/shuttle/floor4/vox //skipjack floors
	name = "skipjack floor"
	initial_air = list(REAGENT_ID_NITROGEN = MOLES_N2STANDARD + MOLES_O2STANDARD)

/turf/simulated/ocean
	initial_air = list()
