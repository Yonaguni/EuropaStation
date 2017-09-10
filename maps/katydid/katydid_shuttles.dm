// Cargo.
/obj/effect/shuttle_landmark/escape_pod/start
	base_area = /area/space

/obj/effect/shuttle_landmark/escape_pod/out
	base_area = /area/space

/obj/effect/shuttle_landmark/escape_pod/transit
	base_area = /area/space

/datum/shuttle/autodock/ferry/escape_pod/katydid
	shuttle_area = /area/shuttle/katydid/pod/one
	pod_number = 1

/obj/effect/shuttle_landmark/escape_pod/start/one
	pod_number = 1

/obj/effect/shuttle_landmark/escape_pod/out/one
	pod_number = 1
/obj/effect/shuttle_landmark/escape_pod/transit/one
	pod_number = 1

/datum/shuttle/autodock/ferry/escape_pod/katydid/pod_two
	shuttle_area = /area/shuttle/katydid/pod/two
	pod_number = 2
/obj/effect/shuttle_landmark/escape_pod/start/two
	pod_number = 2
/obj/effect/shuttle_landmark/escape_pod/out/two
	pod_number = 2
/obj/effect/shuttle_landmark/escape_pod/transit/two
	pod_number = 2

/datum/shuttle/autodock/ferry/escape_pod/katydid/pod_three
	shuttle_area = /area/shuttle/katydid/pod/three
	pod_number = 3
/obj/effect/shuttle_landmark/escape_pod/start/three
	pod_number = 3
/obj/effect/shuttle_landmark/escape_pod/out/three
	pod_number = 3
/obj/effect/shuttle_landmark/escape_pod/transit/three
	pod_number = 3

/datum/shuttle/autodock/ferry/escape_pod/katydid/pod_four
	shuttle_area = /area/shuttle/katydid/pod/four
	pod_number = 4
/obj/effect/shuttle_landmark/escape_pod/start/four
	pod_number = 4
/obj/effect/shuttle_landmark/escape_pod/out/four
	pod_number = 4
/obj/effect/shuttle_landmark/escape_pod/transit/four
	pod_number = 4

/datum/shuttle/autodock/ferry/escape_pod/katydid/pod_five
	shuttle_area = /area/shuttle/katydid/pod/five
	pod_number = 5
/obj/effect/shuttle_landmark/escape_pod/start/five
	pod_number = 5
/obj/effect/shuttle_landmark/escape_pod/out/five
	pod_number = 5
/obj/effect/shuttle_landmark/escape_pod/transit/five
	pod_number = 5

/datum/shuttle/autodock/ferry/escape_pod/katydid/pod_six
	shuttle_area = /area/shuttle/katydid/pod/six
	pod_number = 6
/obj/effect/shuttle_landmark/escape_pod/start/six
	pod_number = 6
/obj/effect/shuttle_landmark/escape_pod/out/six
	pod_number = 6
/obj/effect/shuttle_landmark/escape_pod/transit/six
	pod_number = 6

/obj/machinery/computer/shuttle_control/explore/katydid
	name = "expedition shuttle control console"
	shuttle_tag = "Expedition Shuttle"

/datum/shuttle/autodock/overmap/expedition
	name = "Expedition Shuttle"
	shuttle_area = /area/shuttle/katydid/expedition
	current_location = "nav_expedition_start"
	dock_target = "mining_shuttle_dock"

/obj/effect/shuttle_landmark/katydid_explorer
	name = "Expedition Shuttle"
	landmark_tag = "nav_expedition_start"
	docking_controller = "mining_shuttle"
