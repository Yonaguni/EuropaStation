/obj/item/organ/internal/heart/octopus
	name = "hearts"
	gender = PLURAL

/obj/item/organ/internal/lungs/octopus
	name = "funnel"
	gender = NEUTER
	has_gills = TRUE

/obj/item/organ/internal/lungs/octopus/can_drown()
	return FALSE

/obj/item/organ/internal/lungs/aquatic
	has_gills = TRUE

/obj/item/organ/internal/lungs/aquatic/can_drown()
	return FALSE
