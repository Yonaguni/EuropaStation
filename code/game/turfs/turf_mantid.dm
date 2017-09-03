/turf/simulated/floor/fixed/mantid
	name = "composite flooring"
	icon = 'icons/turf/flooring/mantid.dmi'
	icon_state = "floor"

/turf/simulated/floor/fixed/mantid/grate
	icon_state = "grate"

/turf/simulated/wall/mantid
	color = "#9c73dd"
	icon_state = "composite_preview"

/turf/simulated/wall/mantid/New(var/newloc)
	..(newloc, "composite")

/turf/simulated/wall/mantid_reinf
	color = "#9c73dd"
	icon_state = "composite_reinf_preview"

/turf/simulated/wall/mantid_reinf/New(var/newloc)
	..(newloc, "composite", "energy conduit")
