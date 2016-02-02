var/list/teleportlocs = list()
var/list/ghostteleportlocs = list()

/hook/startup/proc/setupTeleportLocs()
	for(var/area/AR in all_areas)
		if(!istype(AR) || (AR.flags & DENY_TELEPORT) || teleportlocs.Find(AR.name))
			continue
		var/turf/picked = pick_area_turf(AR.type, list(/proc/is_station_turf))
		if (picked)
			teleportlocs[AR.name] = AR
	teleportlocs = sortAssoc(teleportlocs)
	return 1

/hook/startup/proc/setupGhostTeleportLocs()
	for(var/area/AR in all_areas)
		if(!(istype(AR)) || (AR.flags & DENY_GHOST_TELEPORT) || ghostteleportlocs.Find(AR.name))
			continue
		var/turf/picked = pick_area_turf(AR.type, list(/proc/is_station_turf))
		if (picked)
			ghostteleportlocs[AR.name] = AR

	ghostteleportlocs = sortAssoc(ghostteleportlocs)
	return 1