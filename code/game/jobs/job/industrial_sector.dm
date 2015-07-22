/datum/job/industry
	title = "Employee"
	flag = WORKER
	department_flag = INDUSTRY
	department = "Industrial Sector"
	faction = "Station"
	total_positions = 6
	spawn_positions = 4
	supervisors = "the board of investors and colonial law"
	selection_color = "#ffeeff"
	access = list()
	minimal_access = list()
	alt_titles = list("Factory Worker", "Miner", "Shipping Clerk", "Fabrication Technician")
	idtype = /obj/item/weapon/card/id/europa/corpcard

/datum/job/industry/science
	title = "Scientist"
	flag = SCIENTIST
	total_positions = 5
	spawn_positions = 3
	supervisors = "the funding committee and colonial law"
	alt_titles = list("Xenobiologist","Field Technician")
	idtype = /obj/item/weapon/card/id/europa/lanyard
