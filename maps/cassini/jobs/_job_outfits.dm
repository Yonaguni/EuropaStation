/decl/hierarchy/outfit/job/cassini
	name = "Cassini Colonist"
	uniform_lower = /obj/item/clothing/under/lower/pants/beige
	uniform_upper = /obj/item/clothing/under/upper/shirt/beige
	uniform_over = /obj/item/clothing/under/jumpsuit/cassini
	id_type = /obj/item/weapon/card/id/cassini

/decl/hierarchy/outfit/job/cassini/clerk
	name = "Cassini Clerk"
	id_type = /obj/item/weapon/card/id/cassini/admin
	uniform_over = /obj/item/clothing/under/jumpsuit/cassini/admin

/decl/hierarchy/outfit/job/cassini/clerk/administrator
	name = "Cassini Administrator"
	uniform_over = /obj/item/clothing/under/jumpsuit/cassini/admin/manager

/decl/hierarchy/outfit/job/cassini/utilities
	name = "Cassini Utilities"
	uniform_over = /obj/item/clothing/under/jumpsuit/cassini/utilities
	id_type = /obj/item/weapon/card/id/cassini/utilities

/decl/hierarchy/outfit/job/cassini/utilities/chief
	name = "Cassini General Foreman"
	uniform_over = /obj/item/clothing/under/jumpsuit/cassini/utilities/manager

/decl/hierarchy/outfit/job/cassini/utilities/construction
	name = "Cassini Construction Worker"

/decl/hierarchy/outfit/job/cassini/police
	name = "Cassini Police"
	uniform_over = /obj/item/clothing/under/jumpsuit/cassini/police
	uniform_lower = /obj/item/clothing/under/lower/pants/police
	uniform_upper = /obj/item/clothing/under/upper/longsleeve/police
	head = /obj/item/clothing/head/police_cap
	uniform_accessories = list(/obj/item/clothing/accessory/police_badge)

/decl/hierarchy/outfit/job/cassini/police/chief
	name = "Cassini Chief of Police"
	head = /obj/item/clothing/head/police_hat
	uniform_accessories = list(/obj/item/clothing/accessory/black_tie, /obj/item/clothing/accessory/police_badge)
	uniform_over = /obj/item/clothing/under/jumpsuit/cassini/police/manager

/decl/hierarchy/outfit/job/cassini/medical
	name = "Cassini Physician"
	uniform_over = /obj/item/clothing/under/jumpsuit/cassini/medical
	id_type = /obj/item/weapon/card/id/cassini/medical

/decl/hierarchy/outfit/job/cassini/medical/chief
	name = "Cassini Chief Physician"
	uniform_over = /obj/item/clothing/under/jumpsuit/cassini/medical/manager
