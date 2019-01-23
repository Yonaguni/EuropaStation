/datum/design/item/synthstorage/AssembleDesignName()
	..()
	name = "Synthetic intelligence storage ([item_name])"

/datum/design/item/synthstorage/paicard
	name = "pAI"
	desc = "Personal Artificial Intelligence device."
	id = "paicard"
	req_tech = list(TECH_DATA = 2)
	materials = list(MATERIAL_GLASS = 500, MATERIAL_STEEL = 500)
	build_path = /obj/item/device/paicard
	sort_string = "VABAI"

/datum/design/item/synthstorage/intelicard
	name = "inteliCard"
	desc = "AI preservation and transportation system."
	id = "intelicard"
	req_tech = list(TECH_DATA = 4, TECH_MATERIAL = 4)
	materials = list(MATERIAL_GLASS = 1000, MATERIAL_GOLD = 200)
	build_path = /obj/item/weapon/aicard
	sort_string = "VACAA"
