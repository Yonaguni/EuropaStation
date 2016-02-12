/turf/simulated/floor/carpet
	name = "carpet"
	icon = 'icons/turf/flooring/carpet.dmi'
	icon_state = "carpet"
	initial_flooring = /decl/flooring/carpet

/turf/simulated/floor/bluegrid
	name = "mainframe floor"
	icon = 'icons/turf/flooring/circuit.dmi'
	icon_state = "bcircuit"
	initial_flooring = /decl/flooring/reinforced/circuit

/turf/simulated/floor/greengrid
	name = "mainframe floor"
	icon = 'icons/turf/flooring/circuit.dmi'
	icon_state = "gcircuit"
	initial_flooring = /decl/flooring/reinforced/circuit/green

/turf/simulated/floor/wood
	name = "wooden floor"
	icon = 'icons/turf/flooring/wood.dmi'
	icon_state = "wood"
	initial_flooring = /decl/flooring/wood

/turf/simulated/floor/wood/broken
	icon_state = "broken_preview"

/turf/simulated/floor/wood/broken/New()
	..()
	break_tile()

/turf/simulated/floor/grass
	name = "grass patch"
	icon = 'icons/turf/flooring/grass.dmi'
	icon_state = "grass0"
	initial_flooring = /decl/flooring/grass

/turf/simulated/floor/carpet/blue
	name = "blue carpet"
	icon_state = "bcarpet"
	initial_flooring = /decl/flooring/carpet/blue

/turf/simulated/floor/tiled
	name = "floor"
	icon = 'icons/turf/flooring/tiles.dmi'
	icon_state = "steel"
	initial_flooring = /decl/flooring/tiling

/turf/simulated/floor/reinforced
	name = "reinforced floor"
	icon = 'icons/turf/flooring/tiles.dmi'
	icon_state = "reinforced"
	initial_flooring = /decl/flooring/reinforced


/turf/simulated/floor/cult
	name = "engraved floor"
	icon = 'icons/turf/flooring/cult.dmi'
	icon_state = "cult"
	initial_flooring = /decl/flooring/reinforced/cult

/turf/simulated/floor/cult/cultify()
	return

/turf/simulated/floor/tiled/dark
	name = "dark floor"
	icon_state = "dark"
	initial_flooring = /decl/flooring/tiling/dark

/turf/simulated/floor/tiled/red
	name = "red floor"
	color = COLOR_RED_GRAY
	icon_state = "white"
	initial_flooring = /decl/flooring/tiling/red

/turf/simulated/floor/tiled/steel
	name = "steel floor"
	icon_state = "steel_dirty"
	initial_flooring = /decl/flooring/tiling/steel

/turf/simulated/floor/tiled/white
	name = "white floor"
	icon_state = "white"
	initial_flooring = /decl/flooring/tiling/white

/turf/simulated/floor/tiled/yellow
	name = "yellow floor"
	color = COLOR_BROWN
	icon_state = "white"
	initial_flooring = /decl/flooring/tiling/yellow

/turf/simulated/floor/tiled/freezer
	name = "tiles"
	icon_state = "freezer"
	initial_flooring = /decl/flooring/tiling/freezer

/turf/simulated/floor/lino
	name = "lino"
	icon = 'icons/turf/flooring/linoleum.dmi'
	icon_state = "lino"
	initial_flooring = /decl/flooring/linoleum

//ATMOS PREMADES
/turf/simulated/floor/reinforced/airless
	name = "vacuum floor"
	temperature = TCMB
	initial_air = list()

/turf/simulated/floor/airless
	name = "airless plating"
	initial_air = list()
	temperature = TCMB

/turf/simulated/floor/tiled/airless
	name = "airless floor"
	initial_air = list()
	temperature = TCMB

/turf/simulated/floor/bluegrid/airless
	name = "airless floor"
	initial_air = list()
	temperature = TCMB

/turf/simulated/floor/greengrid/airless
	name = "airless floor"
	initial_air = list()
	temperature = TCMB

/turf/simulated/floor/greengrid/nitrogen
	initial_air = list(REAGENT_ID_NITROGEN = MOLES_N2STANDARD)

/turf/simulated/floor/tiled/white/airless
	name = "airless floor"
	initial_air = list()
	temperature = TCMB

/turf/simulated/floor/plating/airless
	temperature = TCMB
	initial_air = list()

/turf/simulated/floor/plating/airless/New()
	..()
	name = "plating"

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

/turf/simulated/floor/snow
	name = "snow"
	icon = 'icons/turf/floors.dmi'
	icon_state = "snow"
	base_name = "snow"
	base_icon = 'icons/turf/floors.dmi'
	base_icon_state = "snow"
	init_turf = 0

/turf/simulated/floor/snow/ice
	name = "ice"
	icon_state = "ice"
	base_name = "ice"
	base_icon_state = "ice"
	init_turf = 0

/turf/simulated/floor/flooded
	color = "#66D1FF"
	flooded = 1

/turf/simulated/floor/flooded/New()
	..()
	color = null

// Placeholders
/turf/simulated/floor/light
/turf/simulated/floor/beach/coastline
/turf/simulated/floor/plating/snow
/turf/simulated/floor/airless/ceiling

/turf/simulated/floor/beach
	name = "beach"
	icon = 'icons/misc/beach.dmi'

/turf/simulated/floor/beach/sand
	name = "sand"
	icon_state = "sand"

/turf/simulated/floor/beach/sand/desert
	icon_state = "desert"

/turf/simulated/floor/beach/coastline
	name = "coastline"
	icon = 'icons/misc/beach2.dmi'
	icon_state = "sandwater"

/turf/simulated/floor/beach/water
	name = "water"
	icon_state = "water"

/turf/simulated/floor/beach/water/update_dirt()
	return	// Water doesn't become dirty

/turf/simulated/floor/beach/water/ocean
	icon_state = "seadeep"

/turf/simulated/floor/beach/water/New()
	..()
	overlays += image("icon"='icons/misc/beach.dmi',"icon_state"="water5","layer"=MOB_LAYER+0.1)
