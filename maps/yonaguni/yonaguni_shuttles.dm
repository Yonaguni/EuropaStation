/*
Notes to self about shuttle system:
- base area is the area that the shuttle is expected to leave behind itself when it leaves a given landmark
- docking tags are hard
- initial shuttle area on the map just defines bounds of the shuttle, shouldn't be used for base_area unless you want to mess things up
*/

// Cargo.
// Evac ferry.
/datum/shuttle/autodock/ferry/emergency/evac
	name = "Escape"
	location = 1
	warmup_time = 10
	shuttle_area = /area/shuttle/europa/evac
	waypoint_offsite = "nav_evac_start"
	waypoint_station = "nav_evac_station"
	waypoint_transition = "nav_evac_transit"
	dock_target = "escape_shuttle"

/obj/effect/shuttle_landmark/evac/transit
	name = "In transit"
	base_area = /area/europa/ocean
	landmark_tag = "nav_evac_transit"

/obj/effect/shuttle_landmark/evac/offsite
	name = "Evac - Rhadamanthus"
	landmark_tag = "nav_evac_start"
	base_area = /area/centcom/europa/offstation/surface
	docking_controller = "centcom_dock"

/obj/effect/shuttle_landmark/evac/onsite
	name = "Evac - Yonaguni"
	landmark_tag = "nav_evac_station"
	base_area = /area/europa/ocean
	docking_controller = "escape_dock"

// Escape pods.
/obj/effect/shuttle_landmark/escape_pod/start
	base_area = /area/europa/ocean

/obj/effect/shuttle_landmark/escape_pod/out
	base_area = /area/centcom/europa/offstation/surface

/obj/effect/shuttle_landmark/escape_pod/transit
	base_area = /area/centcom/europa/offstation/surface

/datum/shuttle/autodock/ferry/escape_pod/europa
	shuttle_area = /area/shuttle/europa/pod/one
	pod_number = 1

/obj/effect/shuttle_landmark/escape_pod/start/one
	pod_number = 1

/obj/effect/shuttle_landmark/escape_pod/out/one
	pod_number = 1
/obj/effect/shuttle_landmark/escape_pod/transit/one
	pod_number = 1

/datum/shuttle/autodock/ferry/escape_pod/europa/pod_two
	shuttle_area = /area/shuttle/europa/pod/two
	pod_number = 2
/obj/effect/shuttle_landmark/escape_pod/start/two
	pod_number = 2
/obj/effect/shuttle_landmark/escape_pod/out/two
	pod_number = 2
/obj/effect/shuttle_landmark/escape_pod/transit/two
	pod_number = 2

/datum/shuttle/autodock/ferry/escape_pod/europa/pod_three
	shuttle_area = /area/shuttle/europa/pod/three
	pod_number = 3
/obj/effect/shuttle_landmark/escape_pod/start/three
	pod_number = 3
/obj/effect/shuttle_landmark/escape_pod/out/three
	pod_number = 3
/obj/effect/shuttle_landmark/escape_pod/transit/three
	pod_number = 3

/datum/shuttle/autodock/ferry/escape_pod/europa/pod_five
	shuttle_area = /area/shuttle/europa/pod/five
	pod_number = 5
/obj/effect/shuttle_landmark/escape_pod/start/five
	pod_number = 5
/obj/effect/shuttle_landmark/escape_pod/out/five
	pod_number = 5
/obj/effect/shuttle_landmark/escape_pod/transit/five
	pod_number = 5

// ERT sub
/datum/shuttle/autodock/ferry/ert
	name = "Asset Protection Submarine"
	warmup_time = 0
	shuttle_area = /area/shuttle/europa/ert
	waypoint_station = "nav_ert_start"
	waypoint_offsite = "nav_ert_out"

/obj/effect/shuttle_landmark/ert/base
	name = "Asset Protection Base"
	landmark_tag = "nav_ert_start"

/obj/effect/shuttle_landmark/ert/station
	name = "Asset Protection Dock"
	landmark_tag = "nav_ert_out"

/obj/machinery/computer/shuttle_control/navy
	shuttle_tag = "Asset Protection Submarine"

// Navy sub
/datum/shuttle/autodock/multi/antag/navy
	name = "Navy"
	warmup_time = 0
	shuttle_area = /area/shuttle/europa/navy
	destinations = list("nav_navy_start","nav_navy_station")
	current_location = "nav_navy_start"
	waypoint_transition = "nav_navy_transit"

/obj/effect/shuttle_landmark/navy/base
	name = "Naval Base"
	landmark_tag = "nav_navy_start"

/obj/effect/shuttle_landmark/navy/transit
	name = "In transit"
	landmark_tag = "nav_navy_transit"

/obj/effect/shuttle_landmark/navy/station
	name = "Nearby dome"
	landmark_tag = "nav_navy_station"

// Merc sub
/datum/shuttle/autodock/multi/antag/merc
	name = "Mercenary"
	warmup_time = 0
	shuttle_area = /area/shuttle/europa/merc
	destinations = list("nav_merc_start","nav_merc_station")
	current_location = "nav_merc_start"
	waypoint_transition = "nav_merc_transit"

/obj/effect/shuttle_landmark/merc/base
	name = "Mercenary Base"
	landmark_tag = "nav_merc_start"

/obj/effect/shuttle_landmark/merc/transit
	name = "In transit"
	landmark_tag = "nav_merc_transit"

/obj/effect/shuttle_landmark/merc/station
	name = "Nearby dome"
	landmark_tag = "nav_merc_station"

// Pirate sub
/datum/shuttle/autodock/multi/antag/pirate
	name = "Skipjack"
	warmup_time = 0
	shuttle_area = /area/shuttle/europa/pirate
	destinations = list("nav_pirate_start","nav_pirate_station")
	current_location = "nav_pirate_start"
	waypoint_transition = "nav_pirate_transit"

/obj/effect/shuttle_landmark/pirate/base
	name = "Pirate Base"
	landmark_tag = "nav_pirate_start"

/obj/effect/shuttle_landmark/pirate/transit
	name = "In transit"
	landmark_tag = "nav_pirate_transit"

/obj/effect/shuttle_landmark/pirate/station
	name = "Nearby dome"
	landmark_tag = "nav_pirate_station"

// Control consoles.
/obj/machinery/computer/shuttle_control/ert
	name = "\improper AP submarine control console"
	req_access = list(access_cent_general)
	shuttle_tag = "Asset Protection Submarine"

/obj/machinery/computer/shuttle_control/navy
	name = "navy submarine control console"
	req_access = list(access_cent_general)
	shuttle_tag = "Navy"

/obj/machinery/computer/shuttle_control/pirate
	name = "skipjack control console"
	req_access = list(access_syndicate)
	shuttle_tag = "Skipjack"
