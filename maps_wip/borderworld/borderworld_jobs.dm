/datum/map/katydid
	default_role = "Vagrant"
	default_job_type = /datum/job/borderworld
	allowed_jobs = list(
		/datum/job/borderworld
		)

/datum/job/borderworld
	title = "Vagrant"
	total_positions = -1
	spawn_positions = -1
	supervisors = "your conscience"
	selection_color = "#dddddd"

/obj/effect/landmark/start/vagrant
	name = "Vagrant"