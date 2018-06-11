/decl/hierarchy/supply_pack/science
	name = "Science"

/decl/hierarchy/supply_pack/science/phoron
	name = "Air-fuel bomb assembly crate"
	contains = list(/obj/item/tank/phoron = 3,
					/obj/item/assembly/igniter = 3,
					/obj/item/assembly/prox_sensor = 3,
					/obj/item/assembly/timer = 3)
	cost = 10
	containertype = /obj/structure/closet/crate/secure/phoron
	containername = "\improper Air-fuel bomb assembly crate"
	access = access_tox_storage
