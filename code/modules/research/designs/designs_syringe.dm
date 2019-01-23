/datum/design/item/syringe/AssembleDesignName()
	name = "Syringe prototype ([item_name])"

/datum/design/item/syringe/noreactsyringe
	name = "Cryo Syringe"
	desc = "An advanced syringe that stops reagents inside from reacting. It can hold up to 20 units."
	id = "noreactsyringe"
	req_tech = list(TECH_BIO = 4, TECH_MATERIAL = 4)
	materials = list(MATERIAL_GLASS = 2000, MATERIAL_GOLD = 1000, MATERIAL_PLASTIC = 500)
	build_path = /obj/item/weapon/reagent_containers/syringe/noreact
	sort_string = "MCAAC"
