/obj/effect/landmark/overmap_target
	var/difficulty = 20 // Percentage chance of missing.

/obj/effect/landmark/overmap_target/Initialize()
	var/obj/effect/overmap/ship/linked = map_sectors["[z]"]
	if(istype(linked)) linked.targets |= src
	. = ..()

/obj/effect/landmark/overmap_target/power_plant
	name = "fusion core"
	difficulty = 80

/obj/effect/landmark/overmap_target/bridge
	name = "bridge"
	difficulty = 80

/obj/effect/landmark/overmap_target/superstructure
	name = "center of mass"
	difficulty = 10

/obj/effect/landmark/overmap_target/port_thrusters
	name = "port thrusters"
	difficulty = 50

/obj/effect/landmark/overmap_target/starboard_thrusters
	name = "starboard thrusters"
	difficulty = 50

/obj/effect/landmark/overmap_target/port_weapons
	name = "port weapon battery"
	difficulty = 30

/obj/effect/landmark/overmap_target/starboard_weapons
	name = "starboard weapon battery"
	difficulty = 30
