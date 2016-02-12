/datum/reagent/acid
	name = "Sulphuric acid"
	id = REAGENT_ID_ACID
	color = "#DB5008"
	metabolism = REM * 2
	touch_met = 50 // It's acid!
	acid = 5
	acid_melt_threshold = 10
	disinfectant = 1

/datum/reagent/water
	name = "Water"
	id = REAGENT_ID_WATER
	color = "#0064C877"
	metabolism = REM * 10
	hydration_factor = 4

/datum/reagent/antiseptic
	name = "Antiseptic"
	id = REAGENT_ID_ANTISEPTIC
	color = "#C8A5DC"
	touch_met = 5
	disinfectant = 1

/datum/reagent/woodpulp
	name = "Wood Pulp"
	id = REAGENT_ID_WOOD
	color = "#B97A57"

/datum/reagent/fuel
	name = REAGENT_ID_FUEL
	id = REAGENT_ID_FUEL
	color = "#660000"
	touch_met = 5
	flammable = 1
	toxic_blood = 1

/datum/reagent/fuel/touch_turf(var/turf/T)
	new /obj/effect/decal/cleanable/liquid_fuel(T, volume)
	remove_self(volume)
	return
