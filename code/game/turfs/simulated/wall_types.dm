/turf/simulated/wall/r_wall
	icon_state = "rgeneric"

/turf/simulated/wall/r_wall/Initialize(mapload)
	. = ..(mapload, MATERIAL_PLASTEEL,MATERIAL_PLASTEEL) //3strong

/turf/simulated/wall/iron/Initialize(mapload)
	. = ..(mapload,MATERIAL_IRON)

/turf/simulated/wall/uranium/Initialize(mapload)
	. = ..(mapload,MATERIAL_URANIUM)

/turf/simulated/wall/diamond/Initialize(mapload)
	. = ..(mapload,MATERIAL_DIAMOND)

/turf/simulated/wall/gold/Initialize(mapload)
	. = ..(mapload,MATERIAL_GOLD)

/turf/simulated/wall/silver/Initialize(mapload)
	. = ..(mapload,MATERIAL_SILVER)

/turf/simulated/wall/sandstone/Initialize(mapload)
	. = ..(mapload,MATERIAL_SANDSTONE)

/turf/simulated/wall/wood/Initialize(mapload)
	. = ..(mapload,MATERIAL_WOOD)

/turf/simulated/wall/golddiamond/Initialize(mapload)
	. = ..(mapload,MATERIAL_GOLD,MATERIAL_DIAMOND)

/turf/simulated/wall/silvergold/Initialize(mapload)
	. = ..(mapload,MATERIAL_SILVER,MATERIAL_GOLD)

/turf/simulated/wall/sandstonediamond/Initialize(mapload)
	. = ..(mapload,MATERIAL_SANDSTONE,MATERIAL_DIAMOND)

/turf/simulated/wall/titanium/Initialize(mapload)
	. = ..(mapload, MATERIAL_TITANIUM)
