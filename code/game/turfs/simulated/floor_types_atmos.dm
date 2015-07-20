/turf/simulated/floor/airless
	icon_state = "floor"
	name = "airless floor"
	initial_temperature = TCMB
	initial_air = list()

/turf/simulated/floor/airless/New()
	..()
	name = "floor"

/turf/simulated/floor/airless/lava
	name = "lava"
	icon_state = "lava"
	lava = 1
	light_range = 2
	light_color = "#CC0000"

/turf/simulated/floor/airless/ceiling
	icon_state = "rockvault"

/turf/simulated/floor/engine/n20
	initial_air = list("sleeping_agent" = 2000)

/turf/simulated/floor/engine/vacuum
	name = "vacuum floor"
	icon_state = "engine"
	temperature = TCMB
	initial_air = list()

/turf/simulated/floor/plating/airless
	icon_state = "plating"
	name = "airless plating"
	temperature = TCMB
	initial_air = list()

/turf/simulated/floor/plating/airless/New()
	..()
	name = "plating"

/turf/simulated/floor/nitrogen
	initial_air = list("nitrogen" = 2000)

/turf/simulated/floor/oxygen
	initial_air = list("oxygen" = 2000)

/turf/simulated/floor/phoron
	initial_air = list("phoron" = 2000)

/turf/simulated/floor/carbon_dioxide
	initial_air = list("carbon_dioxide" = 2000)

/turf/simulated/floor/plating/flooded
	color = "#66D1FF"
	initial_temperature = 250
	initial_air = list("water" = 1500)

/turf/simulated/floor/plating/flooded/New()
	..()
	color = null
