/datum/shuttle/ferry/escape_pod/escape_pod_one
	name = "Escape Pod 1"
	location = 0
	warmup_time = 0
	area_station = /area/shuttle/escape_pod1/station
	area_offsite = /area/shuttle/escape_pod1/centcom
	area_transition = /area/shuttle/escape_pod1/transit
	docking_controller_tag = "escape_pod_1"
	dock_target_station = "escape_pod_1_berth"
	transit_direction = NORTH

/datum/shuttle/ferry/escape_pod/escape_pod_two
	name = "Escape Pod 2"
	location = 0
	warmup_time = 0
	area_station = /area/shuttle/escape_pod2/station
	area_offsite = /area/shuttle/escape_pod2/centcom
	area_transition = /area/shuttle/escape_pod2/transit
	docking_controller_tag = "escape_pod_2"
	dock_target_station = "escape_pod_2_berth"
	transit_direction = NORTH

/datum/shuttle/ferry/escape_pod/escape_pod_three
	name = "Escape Pod 3"
	location = 0
	warmup_time = 0
	area_station = /area/shuttle/escape_pod3/station
	area_offsite = /area/shuttle/escape_pod3/centcom
	area_transition = /area/shuttle/escape_pod3/transit
	docking_controller_tag = "escape_pod_3"
	dock_target_station = "escape_pod_3_berth"
	transit_direction = NORTH

/datum/shuttle/ferry/escape_pod/escape_pod_four
	name = "Escape Pod 4"
	location = 0
	warmup_time = 0
	area_station = /area/shuttle/escape_pod4/station
	area_offsite = /area/shuttle/escape_pod4/centcom
	area_transition = /area/shuttle/escape_pod4/transit
	docking_controller_tag = "escape_pod_4"
	dock_target_station = "escape_pod_4_berth"
	transit_direction = SOUTH

/datum/shuttle/ferry/escape_pod/escape_pod_five
	name = "Escape Pod 5"
	location = 0
	warmup_time = 0
	area_station = /area/shuttle/escape_pod5/station
	area_offsite = /area/shuttle/escape_pod5/centcom
	area_transition = /area/shuttle/escape_pod5/transit
	docking_controller_tag = "escape_pod_5"
	dock_target_station = "escape_pod_5_berth"
	transit_direction = SOUTH

/datum/shuttle/ferry/escape_pod/escape_pod_six
	name = "Escape Pod 6"
	location = 0
	warmup_time = 0
	area_station = /area/shuttle/escape_pod6/station
	area_offsite = /area/shuttle/escape_pod6/centcom
	area_transition = /area/shuttle/escape_pod6/transit
	docking_controller_tag = "escape_pod_6"
	dock_target_station = "escape_pod_6_berth"
	transit_direction = SOUTH

/datum/shuttle/ferry/supply/cargo
	name = "Supply"
	location = 1
	warmup_time = 10
	area_offsite = /area/supply/dock
	area_station = /area/supply/station
	docking_controller_tag = "supply_shuttle"
	dock_target_station = "cargo_bay"

/datum/shuttle/ferry/expedition
	name = "Expedition"
	warmup_time = 10
	area_offsite = /area/shuttle/mining/outpost
	area_station = /area/shuttle/mining/station
	docking_controller_tag = "mining_shuttle"
	dock_target_station = "mining_shuttle_dock"

/obj/machinery/computer/shuttle_control/expedition
	name = "expedition shuttle control console"
	shuttle_tag = "Expedition"
	circuit = /obj/item/circuitboard/mining_shuttle